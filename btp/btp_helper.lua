
function btp_helper_load()
    print ("helper loaded");
end

-- that are used for state information
function btp_helper_init()
    -- initilize the spellbook even if in combat since it is uninitalized.
    if (#BTP_SPELLBOOK == 0) then
        BTP_SPELLBOOK = btp_build_valid_spellbook(BOOKTYPE_SPELL);
    end
    if (#BTP_SPELLBOOK_PET == 0) then
        BTP_SPELLBOOK_PET = btp_build_valid_spellbook(BOOKTYPE_PET);
    end

    --refresh the spell books once in a while not in combat
    if (((math.floor(GetTime()) % 10) ~= 0) and not UnitAffectingCombat("player")) then
        BTP_SPELLBOOK = btp_build_valid_spellbook(BOOKTYPE_SPELL);
        BTP_SPELLBOOK_PET = btp_build_valid_spellbook(BOOKTYPE_PET);
    end

    _btp_follow_player = "";
    _btp_assist_player = "";
end


function btp_helper_go()
    btp_bind_keys();

    if (btp_helper_handle_spell_callback()) then
        return true;
    else
        current_cb = nil;
        btp_start_moving();
    end

    -- check our state
    btp_helper_init();
    if ((math.floor(GetTime()) % 10) ~= 0) then
        btp_cleanup();
        if (btp_config_get("ACCEPT")) then btp_helper_handle_interaction(); end
    end

    -- if we are not in a callback that means nothing is channeling so
    -- restart  movemnet
    return _btp_helper_go();
end

-- this is the begining of the new helper function
function _btp_helper_go(unit)
    if (unit == nil) then unit = "target"; end
    unit_name = UnitName(unit) or "NONE";
    btp_debug("btp_helper_go - " .. unit .. " - " .. unit_name);
    -- if (btp_config_get("THREAT")and btp_class_callback("threat", unit)) then return true; end
    if (btp_config_get("HEAL") and btp_class_callback("heal", unit)) then return true; end
    btp_debug("btp_helper_go - HEAL FINISHED " .. unit .. " - " .. unit_name);
    if (btp_config_get("DPS") and btp_class_callback("dps", unit)) then return true; end
    btp_debug("btp_helper_go - DPS FINISHED " .. unit .. " - " .. unit_name);
    if (btp_config_get("BUFF") and btp_class_callback("buff", unit)) then return true; end
    btp_debug("btp_helper_go - BUFF FINISHED " .. unit .. " - " .. unit_name);
    -- if we have a target to follow then follow them, otherwise look for another
    if (btp_config_get("FOLLOW")) then btp_helper_handle_follow(unit); end
    btp_debug("btp_helper_go - FOLLOW FINISHED " .. unit .. " - " .. unit_name);
    -- if we are just in roaming mode it will target random people to follow/buff/etc
    if (btp_config_get("ROAMING") and btp_helper_roaming(unit)) then return true; end
    btp_debug("btp_helper_go - ROAMING FINISHED " .. unit .. " - " .. unit_name);
end

-- This will just cycle through nearby friendly targets
function btp_helper_roaming(unit)

    btp_debug("enter - btp_helper_roaming");
    -- cant roam on ourself
    if (btp_is_player(unit)) then
        btp_debug("target is player get a new tartget");
        return btp_target_friend();
    end

    local unitinfo = btp_unitinfo_get(unit);
    local previous_roaming_target = btp_state_get("roaming_target") or nil;
    local unitinfo_previous = btp_unitinfo_get(previous_roaming_target) or nil;

    -- get_unitinfo returns false or nil if the target is not valid
    if (unitinfo == nil) then
        -- check a new target
        btp_debug("No target, checking for new target");
        return btp_target_friend();
    end

    if (previous_roaming_target == nil) then
        btp_debug("no previous target");
        return btp_target_friend();
    end

    if (unitinfo.name == unitinfo_previous.name) then
        btp_debug("same target as before");
        return btp_target_friend();
    end

    -- check if we have a higher priority
    local priority_unit = btp_unitinfo_get_priority(unitinfo);
    if (priority_unit) then
        -- if we had a higher priority cycle until we get them
        if (priority_unit.name ~= unitinfo.name) then
            btp_debug("Switching target to " .. priority_unit.name);
            return btp_target_friend();
        end
    end
    if (unitinfo.name == btp_state_get("follow_name")) then
        btp_debug("btp_helper_roaming - already following " .. unitinfo.name .. " get a new tartget")
        return btp_target_friend();
    end


    -- helper has a roaming target let the FOLLOW routine decide
    -- if the target should be followed or not.
    return false;
end


function btp_cleanup()
    -- never run when we are in combat
    if (UnitAffectingCombat("player") or UnitAffectingCombat("target")) then return false; end
    -- unitinfo can get large so purge it every 10 seconds
    btp_unitinfo_purge(10);
end

function btp_helper_handle_follow(unit)
    btp_debug("enter - btp_helper_handle_follow");
    -- check old options
    if (not btpFollow) then return false; end
    -- if we are casting something dont start to follow
    if (btp_is_casting("player")) then return false; end

    -- check who to follow
    local follow_unit = btp_helper_pick_follow(unit);

    if (not follow_unit) then 
        -- no follow unit found scan for a new one
        if (btp_config_get("FOLLOW_GUILD")) then
            btp_debug("FOLLOW_GUILD - no follow unit found scan for a new one");
            return btp_target_friend();
        elseif (btp_config_get("ROAMING")) then
            btp_debug("ROAMING - no follow unit found scan for a new one");
            return btp_target_friend();
        end
        return false;
    end

    local last_follow_name = btp_state_get("follow_name") or "no one";
    local curr_unit_name = UnitName(follow_unit) or "NONE";
    if (btp_helper_should_follow(follow_unit)) then
        btp_state_set("follow_unit", follow_unit);
        btp_state_set("follow_name", curr_unit_name);
        -- every time we FollowUnit update follow_time so we know 
        -- our previous follow is still in range.
        btp_state_set("follow_time", GetTime());
        btp_debug("Following: " .. curr_unit_name .. " - " .. follow_unit);
        FollowUnit(follow_unit);

    --[[ TODO: mount checking is broken
    if (btp_is_mounted(follow_unit)) then
        -- btp_helper_handle_mount(follow_unit);
    end
    ]]

        local follow_jump_time = btp_state_get("follow_jump_time") or 0;
        local jump_interval = GetTime() - follow_jump_time;
        -- might need to disable this when mounted
        btp_debug("Doing jump check on: " .. curr_unit_name .. " - " .. follow_unit .. " - " .. jump_interval)
        if (not btp_check_dist(follow_unit, 2) and 
                btp_check_dist(follow_unit, 4) and
                (jump_interval > btp_config_get("FOLLOW_JUMP_INTERVAL"))) then
                    btp_debug("Jumping to follow: " .. curr_unit_name);
            btp_state_set("follow_jump_time", GetTime());
            btp_do_movement("JUMP");
        end

    end

    return follow_unit;
end

function btp_helper_pick_follow(unit)

    local unit_name = UnitName(unit) or "NONE";
    -- check if the unit passed in is our follow player
    local follow_name = btp_config_get("FOLLOW_NAME");
    if (follow_name and unit_name == follow_name) then
        btp_debug(unit_name .. " (" .. unit .. ") FOLLOW_NAME selected to follow");
        return unit;
    elseif (follow_name) then
        -- scan out party for the follow player.
        for nextPlayer in btp_iterate_group_members() do
            if(UnitName(nextPlayer) == follow_name
                and btp_check_dist(nextPlayer, 1)) then
                btp_debug(UnitName(nextPlayer) .. " (" .. nextPlayer .. ") FOLLOW_NAME selected to follow");
                return nextPlayer;
            end
        end
        btp_debug("Could not find FOLLOW_NAME in party in target or party");
        return nil;
    end


    -- if no follow player is set look for a unit in our party
    for nextPlayer in btp_iterate_group_members() do
        if (not btp_dont_follow(UnitName(nextPlayer)) and
            not btp_is_player(nextPlayer) and
            btp_check_dist(nextPlayer, 1)) then
            btp_debug(UnitName(nextPlayer) .. " (" .. nextPlayer .. ") selected to follow");
            return nextPlayer;
        end
    end
    btp_debug("Could not find a party member to follow");


    local unit_in_follow_range = btp_check_dist(unit, 4);
    follow_name = btp_state_get("follow_name");

    -- cound not find a follow_unit or party member to follow, so
    -- check if try world targets if they are in range, ROAMING or FOLLOW_GUILD
    -- will need to be enabled for this to work.
    if (unit_in_follow_range) then
        if (btp_is_guild_member(unit)) then
            btp_debug(unit_name .. " (" .. unit .. ") GUILD member selected to follow");
            return unit;
        end
        if (unit_name == follow_name) then
            btp_debug(unit_name .. " (" .. unit .. ") previous follow selected to follow");
            return unit;
        end
    end

    -- nothing to follow
    if (unit == "player") then btp_degub(unit .. " is invalid follow target"); return false; end
    if (btp_is_player(unit)) then btp_degub(unit .. " is the player");  return false; end
    return unit;
end


-- used to interact to user request
function btp_helper_handle_interaction()
    -- only run every 10 seconds
    AcceptGroup();
    AcceptTrade();
end


-- i feel like should_follow and pick_follow should be combine
-- there is some repeat logic here.
-- TODO: rewrit to use unitinfo so i can use the cache to calulate
--       how long ago the last follow unit was in range, so we can
--       avoid the helper standing around doing nothing. If we are
--       in roming mode we cant check distance by unit since the
--       unit was likely "target" and that will be reassigned
function btp_helper_should_follow(unit)
    btp_debug("enterd")
    if (not btp_config_get("FOLLOW")) then btp_debug("FOLLOW - disabled"); return false; end
    if (not btpFollow or stopMoving) then btp_debug("FOLLOW - not btpFollow or stopMoving"); return false; end
    if (btp_state_get("stop_moving")) then btp_debug("FOLLOW - stop_moving"); return false; end
    if (not btp_check_dist(unit, 4)) then btp_debug("FOLLOW - " .. unit .. " not in range"); return false; end
    if (not UnitExists(unit)) then btp_debug("FOLLOW - " .. unit .. "does not exist"); return false; end

    local unit_name = UnitName(unit) or nil;
    if (not unit_name) then
        btp_debug("FOLLOW - could not find UnitName for - " .. unit);
        return false;
    end
    local last_follow_name = btp_state_get("follow_name") or "NONE";
    local follow_time_started = btp_state_get("follow_time") or 0;
    local follow_durration = GetTime() - follow_time_started;
    btp_debug("last: " .. last_follow_name .. " time: " .. follow_durration .. " curr: " .. unit_name);

    -- never follow ourself
    if(btp_is_player(unit)) then return false; end
    btp_debug("unit is not player");
    -- if its not a player dont follow.
    if (not UnitIsPlayer(unit)) then return false; end
    btp_debug("unit is a player character");
    -- never follow pets
    if (btp_unit_is_pet(unit)) then return false; end
    btp_debug("unit is not a pet");


    -- check if we are set to follow someone
    local follow_name = btp_config_get("FOLLOW_NAME") or btp_state_get("follow_name") or "NEVER_FOLLOWED";

    -- following the hard coded unit
    if (unit_name == follow_name) then
        btp_debug(unit_name .. " is follow_name");
        return true;
    end

    -- in ROAMING MODE if are following random people
    if ((btp_config_get("ROAMING") or btp_config_get("FOLLOW_GUILD")) and
        not btp_in_party() and unit == "target") then

        btp_debug("FOLLOW_GUILD or ROAMING target")
        local current_follow_name = btp_state_get("follow_name") or "NONE";
        if (current_follow_name == unit_name) then
            btp_debug("FOLLOW_WORLD already following: " .. unit_name);
            return true;
        end

        -- we are following the target of the helper, this can happen from /targetfriend aka random people
        btp_debug("last_follow_name: " .. last_follow_name .. " current_unit_name: " .. unit_name .. " follow_durration: " .. follow_durration); 
        if (last_follow_name ~= unit_name and follow_durration < 10) then
            -- only follow new people every 10 seconds so the bother doesnt jump around
            btp_debug("FOLLOW_WORLD to soon to start following: " .. unit_name);
            return false;
        else
            btp_debug("FOLLOW_WORLD ok to start follow: " .. unit_name);
        end
    end
    btp_debug("FOLLOW - OK: " .. unit_name);
    return true;
end

function btp_helper_handle_spell_callback()
    if (not btp_config_get("USE_SPELL_CALLBACKS")) then return false; end
    btp_debug("btp_helper_handle_spell_callback");
    local current_cb_spell = btp_state_get("current_cb_spell") or "UNKNOWN";
    local current_cb_target = btp_state_get("current_cb_target");
    local current_cb_target_name = btp_state_get("current_cb_target_name");
    local current_cb_start_time = btp_state_get("current_cb_start_time") or 0;
    local current_cb_durration = GetTime() - current_cb_start_time;

    local cb_timeout = btp_config_get("CB_TIMEOUT") or 5;

    if (current_cb == nil) then 
        btp_debug("no current callback");
        return false;
    end

    -- check for callback timout
    if (current_cb_durration > cb_timeout) then
        btp_debug("CALLBACK TIMEOUT on " .. current_cb_spell .. " after " .. current_cb_durration .. " seconds");
        btp_frame_debug("CALLBACK TIMEOUT on " .. current_cb_spell .. " after " .. current_cb_durration .. " seconds");
        btp_state_set("current_cb", nil);
        btp_state_set("current_cb_start_time", nil);
        -- dont stop casting here cause we are unsure what
        -- happend there are all sorts of reasons a cb can
        -- get inturrepted 
        -- btp_stop_casting();
        return false;
    end

    -- First we get the Casting and channel information about the player
    -- and use this to make sure the player is casting something.
    cast_spell, cast_rank, cast_display_name, cast_icon, cast_start_time,
    cast_end_time, cast_is_trade_skill = UnitCastingInfo("player");
    btp_debug("cast_spell: " .. tostring(cast_spell));

    -- May just be between casts, so let it stand, otherwise we should
    -- clear the callback if it's not the spell we expect.
    if (cast_spell == nil and current_cb_durration > 1) then
        -- if this stays nill worst case we will have to wait for the timeout
        btp_debug("cast_spell durration greater than 1 and nil - " .. current_cb_spell .. " for " .. current_cb_durration);
        return false;
    elseif (cast_spell == nil and current_cb_durration < 1) then
        -- we are between casts and have been for a while
        btp_debug("cast_spell is nil for - " .. current_cb_spell .. " for " .. current_cb_durration);
        -- i think this can happen cause the ahk has lag between when
        -- we call cast spell and when it actually happens
        return true;
    elseif (cast_spell ~= current_cb_spell) then
        -- Well we are not casting our spell, so we can clear the callback.
        btp_debug("NO MATCH cast_spell " .. cast_spell .. " does not match " .. current_cb_spell);
        -- not sure we should stop casting here, it could interupt a manual cast.
        btp_stop_casting();
        return false;
    end

    if (current_cb()) then
        btp_debug("still casting: " .. current_cb_spell ..
                  " on " .. current_cb_target_name ..
                  " duration: " .. current_cb_durration);
        return true;
    end

    return false;
end

