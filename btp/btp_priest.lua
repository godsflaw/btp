-- btp_priest.lua
--
-- 
-- This file is part of BTP.
-- 
-- BTP is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- BTP is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with BTP.  If not, see <http://www.gnu.org/licenses/>.
-- 
local BTP_PRIEST_THRESH_CRIT=.35
local BTP_PRIEST_THRESH_LARGE=.49
local BTP_PRIEST_THRESH_MEDIUM=.84
local BTP_PRIEST_THRESH_SMALL=.93
local BTP_PRIEST_THRESH_MANA=.15

local SPELL_DATA = {
    -- Format: ["Spell Name"] = {{trainable level, mana, min heal, max heal, time}, ...}
    ["Lesser Heal"] = {
        {1, 30, 46, 58, 1.5},   -- Rank 1
        {4, 45, 71, 89, 2.0},   -- Rank 2
        {10, 75, 135, 165, 2.5},-- Rank 3
    },
    ["Heal"] = {
        {16, 155, 295, 341, 3.0}, -- Rank 1
        {22, 205, 429, 499, 3.0}, -- Rank 2
        {28, 255, 566, 658, 3.0}, -- Rank 3
        {34, 305, 712, 826, 3.0}, -- Rank 4
    },
    ["Renew"] = {
        {8, 30, 45, 45, 999},    -- Rank 1
        {14, 65, 100, 100, 999},  -- Rank 2
        {20, 105, 175, 175, 999}, -- Rank 3
        {26, 140, 245, 245, 999}, -- Rank 4
        {32, 170, 315, 315, 999}, -- Rank 5
        {38, 205, 400, 400, 999}, -- Rank 6
        {44, 250, 510, 510, 999}, -- Rank 7
    },
    ["Flash Heal"] = {
        {20, 125, 202, 247, 1.5}, -- Rank 1
        {26, 155, 269, 325, 1.5}, -- Rank 2
        {32, 185, 339, 406, 1.5}, -- Rank 3
        {38, 215, 414, 499, 1.5}, -- Rank 4
        {44, 265, 534, 643, 1.5}, -- Rank 5
        {50, 315, 662, 791, 1.5}, -- Rank 6
        {56, 380, 828, 996, 1.5}, -- Rank 7
        {60, 410, 958, 1120, 1.5},-- Rank 8
    },
    ["Greater Heal"] = {
        {40, 370, 924, 1039, 3.0}, -- Rank 1
        {46, 455, 1178, 1318, 3.0},-- Rank 2
        {52, 545, 1470, 1642, 3.0},-- Rank 3
        {58, 655, 1813, 2021, 3.0},-- Rank 4
        {60, 750, 2234, 2499, 3.0},-- Rank 5
    },
    ["Prayer of Healing"] = {
        {30, 410, 312, 363, 3.0}, -- Rank 1
        {40, 560, 458, 507, 3.0}, -- Rank 2
        {50, 770, 675, 730, 3.0}, -- Rank 3
        {60, 1030, 939, 1002, 3.0},-- Rank 4
    },
    -- Continue to add data for other spells in a similar format
}

function btp_compare_buff(spell_name, unit)
    return true;
end

function btp_check_buff_rank(unit, spellName)
    for i = 1, 40 do
        local name, _, _, _, _, _, _, _, _, spellId = UnitBuff(unit, i)
        if name == spellName then
            local rank = GetSpellSubtext(spellId)
            return rank
        end
    end
    return nil
end

local SPELL_LOGIC = {
    ["Renew"] = function(unit)
        return true;
    end
};

-- Moved a lot of stuff to btp_priest_old.lua
function btp_priest_initialize()
    btp_frame_debug("Priest INIT");

    SlashCmdList["PRIESTB"] = function() PriestBuff("target"); end
    SLASH_PRIESTB1 = "/pb";
    SlashCmdList["PRIESTH"] = function() btp_priest_heal("target"); end
    SLASH_PRIESTH1 = "/ph";
    SlashCmdList["PRIESTDPS"] = btp_priest_dps;
    SLASH_PRIESTDPS1 = "/pdps";
    SlashCmdList["PRIESTDPS"] = btp_priest_dps_pve;
    SLASH_PRIESTDPS2 = "/pdps_pve";
    SlashCmdList["PRIESTDPSPVP"] = btp_priest_dps_pvp;
    SLASH_PRIESTDPSPVP1 = "/pdps_pvp";

    cb_array["Flash Heal"] = function() return btp_cb_generic_heal("Flash Heal"); end
    cb_array["Greater Heal"] = function() return btp_cb_generic_heal("Greater Heal"); end
    cb_array["Lesser Heal"] = function()
        btp_debug("Lesser Heal - cb_array");
        return btp_cb_generic_heal("Lesser Heal");
    end
    cb_array["Heal"] = function() return btp_cb_generic_heal("Heal"); end
    cb_array["Binding Heal"] = function() return btp_cb_generic_heal("Binding Heal"); end
    cb_array["Smite"] = function() return btp_cb_generic_dps("Smite"); end

    -- cb_array["Prayer of Healing"]       = btp_cb_priest_prayer_of_healing("Prayer of Healing");
    -- cb_array["Holy Word: Sanctuary"]    = btp_cb_priest_holy_word_sanctuary("Holy Word: Sanctuary");
    -- cb_array["Hymn of Hope"]            = btp_cb_priest_hymn_of_hope("Hymn of Hope");

    btp_config_set("HEAL", true);
    btp_config_set("BUFF", true);
    btp_config_set("DPS", false);
    btp_config_set("FOLLOW", true);
    btp_config_set("ACCEPT", true); -- auto accept trades/invites/res

    -- setup our class callbacks
    BTP_CLASS_CALLBACKS["Priest"] = {
        heal = function(unit) return btp_priest_heal(unit) end,
        buff = function(unit) return PriestBuff(unit) end,
        dps = function(unit) return btp_helper_priest_dps(unit) end,
        -- might not be required now that we have IsSpellInRange
        range = function(unit) return btp_in_range("Lesser Heal", unit) end
        -- currently we fade/scream in heal functions i think
        -- this logic should be run before healing and not inline
        -- threat = function return btp_priest_threat(unit) end
    };


end

function PriestBuff(unit)
    btp_bind_keys();
    -- only run when not in combat
    if UnitAffectingCombat("player") then return false; end

    -- only buff if we have extra mana
    if (UnitPower("player")/UnitPowerMax("player") < .65) then return false; end

    -- check target
    if (btp_priest_buff("target")) then return true; end

    -- check self
    if (btp_priest_buff("player")) then return true; end

    -- check group
    for nextPlayer in btp_iterate_group_members() do
        if (btp_priest_buff(nextPlayer)) then return true; end
    end

    if (unit ~= nil) then
        btp_debug("PriestBuff: " .. unit);
    end

    -- checkd the party first so buff targets if presented
    if (btp_priest_buff(unit)) then return true; end
    return false;
end

function btp_priest_buff(unit)
    if (not unit or unit == nil) then 
        btp_debug("called without unit");
        return false;
    end

    if (not UnitExists(unit)) then
        return false;
    end

    local unit_name = UnitName(unit) or "NONE";
    btp_debug(unit_name .. " buffing");

    if(not btp_in_range("Power Word: Fortitude", unit)) then return false; end;
    btp_debug(UnitName(unit) .. " in range");

    -- can only buff players (TODO: this excludes pets)
    if (not UnitIsFriend("player", unit)) then
        return false;
    end
    btp_debug(UnitName(unit) .. " unit is friend");

    -- only buff players or pets
    if (not UnitPlayerControlled(unit)) then
        return false;
    end
    btp_debug(UnitName(unit) .. " unit is player or pet");

    btp_debug("checking fort")
    if(not btp_priest_is_fortitude (unit)) then
        btp_debug("casting fort");
        return btp_cast_spell_on_target("Power Word: Fortitude", unit);
    end
    btp_debug("done fort");

    -- These spells can only be cast on player
    if (unit ~= "player") then return false; end
    if(not btp_priest_is_innerwill("player") and not btp_priest_is_innerfire("player")) then
        if (btp_cast_spell_on_target("Inner Fire", "player")) then return true; end
    end

    if(not btp_priest_is_touchofweakness ("player")) then
        if(btp_cast_spell_on_target("Touch of Weakness", "player")) then return true; end
    end
    return false;
end


function btp_priest_dps_pve(unit)
    if(not unit or unit == nil or unit == "") then  return false; end
    if (_btp_priest_dps_pve(unit)) then return true; end
    return false;
end

function btp_priest_dps_pvp(unit)
    if(not unit or unit == nil or unit == "") then  return false; end
    if (_btp_priest_dps_pvp(unit)) then return true; end
    return false;
end

-- old was called by helper in follow mode
function _btp_priest_dps_pvp(unit)
    -- if we are moving then put up some dot to trip orbs
    if (btp_is_moving()) then
        -- keep up dp
        if (not btp_priest_is_my_dp()) then
    	    if(btp_cast_spell_on_target("Devouring Plague", unit)) then return true end
        end

        -- check if our target does not yet have SWP on 
        if (not btp_priest_is_my_swp(unit)) then
            if(btp_cast_spell_on_target("Shadow Word: Pain", unit)) then return true end;
        end

    end

    if(not btp_priest_is_shadowform()) then
        if(btp_cast_spell_on_target("Penance", unit)) then return true end;
        if(btp_cast_spell_on_target("Holy Fire", unit)) then return true end;
        if(btp_cast_spell_on_target("Smite", unit)) then return true end;
    else
        if (btp_priest_is_my_mindspike(unit)) then
            if(btp_cast_spell_on_target("Mind Blast", unit)) then return true end;
        end
        if(btp_cast_spell_on_target("Mind Spike", unit)) then return true end;
    end
    return false;
end

function btp_priest_dispell_buffs(unit)
    if (not unit) then unit="target"; end

    -- return if the target is friendly
    if (not UnitIsEnemy("player", unit)) then return false; end

    -- return if it is an npc
    if (not UnitIsPlayer(unit)) then return false; end

    while (buffTexture) do
        buffName, buffRank, buffTexture, buffApplications,
        buffType, buffDuration, buffTime, buffMine,
        buffStealable = UnitBuff(unit, i);

	if (buffTexture and buffTime and (
	    strfind(buffTexture, "Power Word: Shield") or
	    strfind(buffTexture, "Anti Shadow") or
	    strfind(buffTexture, "Prayer of Shadow Protection") or
	    strfind(buffTexture, "Ice Lament") or
	    strfind(buffTexture, "Frost Armor")
	   )) then
            if (btp_cast_spell_on_target("Dispel Magic", debuffPlayer)) then return true; end
        end
    end
    return false;
end

function _btp_priest_dps_pve(unit)

    -- cast vamperic touch first if we are not moving
    if(not btp_is_moving()) then
    	-- if we have 3 shadow orbs use them
        if(btp_priest_is_shadoworbs()) then 
            if(btp_cast_spell_on_target("Mind Blast", unit)) then return true end;
        end   
        if (not btp_priest_is_my_vampirictouch(unit)) then
            if(btp_cast_spell_on_target("Vampiric Touch", unit)) then return true end;
        end
    end

    -- keep up dp
    if (not btp_priest_is_my_dp(unit)) then
    	if(btp_cast_spell_on_target("Devouring Plague", unit)) then return true end
    end

    -- check if our target does not yet have SWP on 
    if (not btp_priest_is_my_swp(unit)) then
        if(btp_cast_spell_on_target("Shadow Word: Pain", unit)) then return true end;
    end

    -- cast vamperic touch if it's not up
    if(not btp_priest_is_my_vampirictouch(unit)) then
        if(btp_cast_spell_on_target("Vampiric Touch", unit)) then return true end;
    end

    if (not btp_is_moving()) then
        if(not btp_priest_is_shadowform()) then
            if(btp_cast_spell_on_target("Penance", unit)) then return true end;
            if(btp_cast_spell_on_target("Holy Fire", unit)) then return true end;
            if(btp_cast_spell_on_target("Smite", unit)) then return true end;
        else
            if(btp_cast_spell_on_target("Mind Blast", unit)) then btp_stop_moving(); return true end;
            if(btp_cast_spell_on_target("Mind Flay", unit)) then btp_stop_moving(); return true end;
            if(btp_cast_spell_on_target("Smite", unit)) then btp_stop_moving(); return true end;
        end
    end
    --
    -- Try to drain mana if we can
        -- if(UnitPower(unit) > 110) then
    --     if(btp_cast_spell_on_target("Mana Burn", unit)) then return true end;
    -- end
    FuckBlizzardAttackTarget(unit);

    return false;
end


-- handles targeting when in dps helper mode, this can probably be
-- a general function for all classes that calls a callback for class
-- specific dps
function btp_helper_priest_dps(unit)
    btp_debug("in dps helper")
    -- we only ever dsp our follow targets target
    local follow_name = btp_state_get("follow_name") or "NONE";
    -- local follow_unitinfo = btp_unitinfo_get(follow_name);

    -- we dont have a friendly player targeted
    if (not UnitExists("target")) then 
        btp_debug("priest_dps - target does not exist lets target a party member")
        return false;
    end

    if (not btp_helper_should_follow("target")) then
        btp_debug("priest_dps - the target is not a party member or friendly");
        return false;
    end

    local current_target_name = UnitName("target");
    -- only dps if our current target is the one we are following
    btp_debug("priest_dps - follow_name: " .. follow_name);
    btp_debug("priest_dps - current_target_name: " .. current_target_name);

    -- a little hacky but this should only dps the follow players target
    -- it would be easy enough to make this any player name
    if (follow_name ~= nil and follow_name ~= current_target_name) then
        btp_debug("priest_dps - target is not follow_name: " .. follow_name);
        return false;
    end
    btp_debug("priest_dps - got target");

    -- if we are not in combat then dont dps
    if (not UnitAffectingCombat("target")) then return false; end
    btp_debug("priest_dps - target in combat");
    -- if (not UnitAffectingCombat("player")) then return false; end

    --[[ not sure we have an easy way to target enemy around usable
    if (UnitAffectingCombat("player")) then
        -- something is targeting us and attacking so we should fight back maybe?
    end
    ]]

    -- if the targettarget is not a npc then dont dps
    if (UnitIsPlayer("targettarget")) then return false; end
    btp_debug("priest_dps - unit is not a player");


    --[[ this would make the helper fail for some reason
    -- if the targettarget is not an enemy then dont dps
    if (UnitIsEnemy("player", "targettarget")) then return false; end
    btp_debug("unit is an enemy");
    ]]

    -- if the targettarget is not in combat then dont dps
    if (not UnitAffectingCombat("targettarget")) then return false; end
    btp_debug("priest_dps - unit is in combat");

    -- if the targettarget is not damaged then dont dps
    if (UnitHealth("targettarget") == UnitHealthMax("targettarget")) then return false; end
    btp_debug("priest_dps - unit is loosing health");

    -- if we are not in range then dont dps
    -- if (not btp_unit_in_casting_range("targettarget")) then return false; end
    btp_debug("priest_dps - seems to be in range");

    -- if we are low on mana then switch to wand
    local mana_low = btp_config_get("MANA_LOW");
    if (UnitPower("player")/UnitPowerMax("player") < .85) then 
        btp_debug("priest_dps - low mana")
        --[[ this did not seem to work
            if(IsAutoRepeatSpell("Shoot")) then return false; end
        ]]
        return btp_cast_spell_on_target("Shoot", "targettarget");
    end
    btp_debug("priest_dps - enough mana");

    return btp_priest_dps_pve("targettarget");
end


PR_THRESH = .45
PR_SCALAR = .50;
PR_MANA = .30;

function btp_priest_heal(unit)
    -- Put any callback code here.
    -- btp_frame_debug("CALLING: Priest Heal");

    -- doing a self heal here (healthstones, potions, etc)
    if (SelfHeal(PR_THRESH, PR_MANA/3)) then return true; end


    
    -- if we are passed in a unit and have a target
    if (unit ~= nil and unit ~= "target") then
        if (btp_priest_heal_unit(unit)) then
            return true;
        end
    end

    -- this code calls health_stats stuff and picks a target
    return btp_priest_heal_scan();
end

function btp_priest_heal_unit(unit)
    -- never heal a friendly unit
    if (unit and UnitIsPlayer(unit) and 
        UnitIsEnemy("player", unit)) then
            return false;
    end

    local cur_percent = UnitHealth(unit) / UnitHealthMax(unit);
    local cur_health = UnitHealth(unit);
    
    -- always heal ourself first
    if (btp_priest_heal_self()) then return true; end

    btp_frame_debug("btp_priest_heal_unit: " .. unit .. " " .. cur_percent .. " " .. cur_health);
    if(btp_priest_heal_crit(cur_percent, cur_health, unit)) then return true; end;
    if(btp_priest_heal_large(cur_percent, cur_health, unit)) then return true; end;
    if(btp_priest_heal_medium(cur_percent, cur_health, unit)) then return true; end;
    if(btp_priest_heal_small(cur_percent, cur_health, unit)) then return true; end;
    return false;
end

function btp_priest_resurrection()

    for i = 0, GetNumPartyMembers() do
        res_name = "party" .. i;
        if (UnitHealth(res_name) < 2 and UnitHealth("player") >= 2 and
            btp_check_dist(res_name,1)) then
            resurrectionName = res_name;
        end
    end

    if (not UnitAffectingCombat("player") and
        res_name ~= "none" and res_name ~= nil and
        UnitPower("player")/UnitPowerMax("player") > PR_MANA) then
    if(btp_cast_spell_on_target("Resurrection", res_name)) then 
        return true; 
    end
    end

    return false;
end

function btp_priest_heal_scan()
    -- init
    btp_bind_keys();


    --[[
    if (current_cb ~= nil and current_cb()) then
        return true;
    end
    -- only place we stop moving is in a callback so start back up
    btp_start_moving();
    ]]


    -- Check the player
    local cur_health = UnitHealth("player");
    local cur_health_max = UnitHealthMax("player");
    local cur_class = UnitClass("player");

    -- if (btp_is_casting()) then return true; end

    -- start moving unless something else tells us to stop

    -- blast out heals if we are in spirit form
    -- if(btp_priest_is_spirit()) then
    --     if(btp_priest_heal_crit(lowest_percent, lowest_health, lowest_target)) then return true; end;
    --     if(btp_priest_heal_large(lowest_percent, lowest_health, lowest_target)) then return true; end;
    --     if(btp_priest_heal_medium(lowest_percent, lowest_health, lowest_target)) then return true; end;
    --     if(btp_priest_heal_small(lowest_percent, lowest_health, lowest_target)) then return true; end;
    -- end

    -- use any items since they should not trigger cooldown
--     if(SelfHeal(BTP_PRIEST_THRESH_CRIT, BTP_PRIEST_THRESH_MANA)) then
--         return true;
--     end

    -- fix once we have callbacks
    -- decurse if needed
--     if ((((GetTime() - lastDecurse) >= 3) or blockOnDecurse) and
--         BTP_Decursive()) then                                   
--         lastDecurse = GetTime();
--         return true;            
--     end

    -- get our health status this is one pass
    -- local lowest_target = btp_health_status(.99);
    local lowest_percent, lowest_health, lowest_target = btp_health_status_quick();

    if (btp_unit_is_pet(cur_target)) then
        btp_debug("priest_heal_scan - target is pet");
        if(btp_priest_heal_small(lowest_percent, lowest_health, lowest_target)) then return true; end;
        return false;
    end

    -- if there is no longer anyone to heal, start moving again
    if(not lowest_percent or not lowest_health or not lowest_target 
       or lowest_target == false or lowest_target == nil) then
        stopMoving = false;
        return false;
    end

    -- do our crit and large heals first
    if(btp_priest_heal_crit(lowest_percent, lowest_health, lowest_target)) then return true; end;
    if(btp_priest_heal_large(lowest_percent, lowest_health, lowest_target)) then return true; end;
    if(btp_priest_heal_medium(lowest_percent, lowest_health, lowest_target)) then return true; end;

    -- heal our self second
    if(btp_priest_heal_self()) then return true; end

    -- small heals after we heal ourself
    if(btp_priest_heal_small(lowest_percent, lowest_health, lowest_target)) then return true; end;

--[[
    if(BTP_Decursive()) then return true; end
]]
    return false;
end


function btp_priest_heal_crit(cur_percent, cur_health, cur_player)
    -- bang out any critical heals
    if(cur_percent > BTP_PRIEST_THRESH_CRIT) then return false; end
    btp_debug("need crit heal " .. cur_player .. " " ..  UnitName(cur_player));
    -- btp_frame_debug("NEED CRIT " .. cur_player .. " " ..  UnitName(cur_player));

    if(btp_priest_is_sol()) then 
        if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end;
    end

    if(UnitAffectingCombat(cur_player)) then
        btp_debug("need crit in combat" .. cur_player .. " " ..  UnitName(cur_player));
        if(btp_cast_spell_on_target("Guardian Spirit", cur_player)) then return true; end

        if(not btp_priest_is_pws(cur_player) and btp_unit_in_party(cur_player)) then
            if(btp_cast_spell_on_target("Power Word: Shield", cur_player)) then return true; end
        end

        if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end

        if(not btp_priest_is_pom(cur_player)) then
            if(btp_cast_spell_on_target("Prayer of Mending", cur_player)) then return true; end
        end

        if(btp_priest_bestheal(cur_player)) then return true; end
    else
        btp_debug("need crit not in combat" .. cur_player .. " " ..  UnitName(cur_player));
        if(not btp_priest_is_renew(cur_player)) then
            if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
        end
        if(btp_priest_bestheal(cur_player)) then return true; end
    end
    btp_debug("need crit heal but have not spell to cast " .. cur_player .. " " ..  UnitName(cur_player));
    return false;
end


function btp_priest_heal_large(cur_percent, cur_health, cur_player)
    -- check everyone else for a large heal
    if(cur_percent > BTP_PRIEST_THRESH_LARGE) then return false; end
    btp_debug("need large heal " .. cur_player .. " " ..  UnitName(cur_player));

    -- btp_frame_debug("NEED LARGE " .. cur_player .. " " ..  UnitName(cur_player));

    if(btp_priest_is_sol()) then 
        if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end;
    end

    if(UnitAffectingCombat(cur_player)) then
        btp_debug("need large heal in combat " .. cur_player .. " " ..  UnitName(cur_player));
        if(not btp_priest_is_pom(cur_player)) then
            if(btp_cast_spell_on_target("Prayer of Mending", cur_player)) then return true; end
        end

        if(not btp_priest_is_pws(cur_player) and btp_unit_in_party(cur_player)) then
            if(btp_cast_spell_on_target("Power Word: Shield", cur_player)) then return true; end
        end

        if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end
        if(btp_priest_bestheal(cur_player)) then return true; end
    else
        btp_debug("need large heal not in combat " .. cur_player .. " " ..  UnitName(cur_player));
        if(btp_is_moving()) then
            if(not btp_priest_is_renew(cur_player)) then
                if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
            end
        else
            if(btp_priest_bestheal(cur_player)) then return true; end
        end
    end
    btp_debug("need large heal but have not spell to cast " .. cur_player .. " " ..  UnitName(cur_player));
    return false;
end

function btp_priest_heal_medium(cur_percent, cur_health, cur_player)
    -- Check for medium heals
    if(cur_percent > BTP_PRIEST_THRESH_MEDIUM) then return false; end
    btp_debug("need medium heal " .. cur_player .. " " ..  UnitName(cur_player));

    -- btp_frame_debug("NEED MEDIUM " .. cur_player .. " " .. UnitName(cur_player));

    if(btp_priest_is_sol()) then
        if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end;
    end

    if(UnitAffectingCombat(cur_player)) then
        btp_debug("need medium heal in combat " .. cur_player .. " " ..  UnitName(cur_player));

        if(not btp_priest_is_pom(cur_player)) then
            if(btp_cast_spell_on_target("Prayer of Mending", cur_player)) then return true; end
        end

        if(not btp_priest_is_renew(cur_player)) then
            if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
        end

        -- only cast for medium damage if the unit is in combat and has high threat
        if((not btp_priest_is_pws(cur_player)) and
               btp_unit_has_threat(cur_player) and
               btp_is_soft_target(cur_player) and
               btp_unit_in_party(cur_player)) then
            if(btp_cast_spell_on_target("Power Word: Shield", cur_player)) then return true; end
        end

        if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end
        -- might want to check for mana efficent/fastest heal here
        if(btp_cast_spell_on_target("Lesser Heal", cur_player)) then btp_stop_moving(); return true; end
    else
        if(not btp_priest_is_renew(cur_player)) then
            if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
        end
        if(btp_cast_spell_on_target("Lesser Heal", cur_player)) then return true; end
    end
    btp_debug("need medium heal but have not spell to cast " .. cur_player .. " " ..  UnitName(cur_player));

    return false;
end

function btp_priest_heal_small(cur_percent, cur_health, cur_player)
    -- Check for small heals last
    if(cur_percent > BTP_PRIEST_THRESH_SMALL) then return false; end
    btp_debug("need small heal " .. cur_player .. " " ..  UnitName(cur_player));
    -- btp_frame_debug("NEED SMALL " .. cur_player .. " " .. UnitName(cur_player));
    if(btp_cast_spell_on_target("Chakra", "player")) then return true; end

    if(not btp_priest_is_pom(cur_player)) then
        if(btp_cast_spell_on_target("Prayer of Mending", cur_player)) then return true; end
    end

    if(not btp_priest_is_renew(cur_player)) then
        if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
    end

    -- dont waste a powerful heal until they need it
    -- if(btp_cast_spell_on_target("Heal", cur_player)) then return true; end
end

function btp_priest_heal_self()
    -- Check the player
    local my_health = UnitHealth("player");
    local my_health_max = UnitHealthMax("player");
    local my_class = UnitClass("player");
    local my_percent = my_health/my_health_max;

    -- crit heal ourself
    if (btp_priest_heal_crit(my_percent, my_health, "player")) then return true; end

    -- try to fear people off of us
    if((my_percent <= BTP_PRIEST_THRESH_SMALL) and 
       (my_health > 2) and 
       UnitThreatSituation("player") ~= nil and
       UnitThreatSituation("player") > 0) then
            if(btp_cast_spell("Fade")) then return true; end
        -- if(btp_cast_spell("Psychic Scream")) then return true; end
    end

    if (btp_priest_heal_large(my_percent, my_health, "player")) then return true; end
    if (btp_priest_heal_medium(my_percent, my_health, "player")) then return true; end
    if (btp_priest_heal_small(my_percent, my_health, "player")) then return true; end
end

function btp_priest_bestheal(unit)
    if (not unit) then unit="target"; end

    local my_health = UnitHealth("player");
    local my_health_max = UnitHealthMax("player");
    local my_class = UnitClass("player");
    local my_percent = my_health/my_health_max;

    -- dont bother trying to cast if we are moving
    -- if (btp_is_moving()) then return false; end

    -- if we are hurt and our target is hurt
    if(my_percent <= BTP_PRIEST_THRESH_MEDIUM and my_health > 2) then
        if(unit ~= nil and (UnitName(unit) ~= UnitName("player"))) then
            -- btp_frame_debug("unit: " .. unit .. " name: " .. UnitName(unit));
            if(btp_cast_spell_on_target("Binding Heal", unit)) then
                btp_stop_moving();
                return true;
            end;
        end
    end

    -- we are not hurt so choose best heal spell
    if (btp_priest_is_serendipity()) then
        if(btp_cast_spell_on_target("Greater Heal", unit)) then btp_stop_moving(); return true; end
    else
        if(btp_cast_spell_on_target("Flash Heal", unit)) then btp_stop_moving(); return true; end;
        if(btp_cast_spell_on_target("Greater Heal", unit)) then btp_stop_moving(); return true; end;
        if(btp_cast_spell_on_target("Heal", unit)) then btp_stop_moving(); return true; end;
        if(btp_cast_spell_on_target("Lesser Heal", unit)) then btp_stop_moving(); return true; end;
    end

    -- might be low on mana so use old heal
    return false;
end

function btp_priest_is_pws(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_debuff("Ashes To Ashes", unit)) then return true; end
    if(btp_check_buff("Power Word: Shield", unit)) then return true; end
    return false;
end

function btp_priest_is_sol(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("SurgeOfLight", unit)) then 
        return true; 
    end
    return false;
end

function btp_priest_is_serendipity(unit, num) 
    if(not unit) then  unit = "player"; end
    if(not num) then num = 2; end
    has_sdip, my_sdip, num_sdip = btp_check_buff("Serendipity", unit);
    if (has_sdip and num_sdip >= num) then return true; end
    return false;
end

function btp_priest_is_shadoworbs(unit, num) 
    if(not unit) then  unit = "player"; end
    if(not num) then num = 3; end
    has_orbs, my_orbs, num_orbs = btp_check_buff("shadoworbs", unit);
    if (has_orbs and num_orbs >= num) then return true; end
    return false;
end

function btp_priest_is_renew(unit)
    if(not unit) then  unit = "player"; end
    -- targets can have multiple renews so only return true
    -- if they have your renew on
    has_renew, my_renew, num_renew = btp_check_buff("Renew", unit);
    if(my_renew) then return true; end
    return false;
end

function btp_priest_is_spirit(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("GreaterHeal", unit)) then return true; end
    return false;
end

function btp_priest_is_pom(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("Prayer Of Mending", unit)) then return true; end
    return false;
end

function btp_priest_is_shadowform(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("Shadowform", unit)) then return true; end
    return false;
end

function btp_priest_is_fearward(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("Excorcism", unit)) then return true; end
    return false;
end

function btp_priest_is_fortitude(unit)
    if(not unit) then  return false; end
    if(UnitCreatureFamily(unit) == "Imp") then return true; end
    if(btp_check_buff("Power Word: Fortitude", unit)) then return true; end
    if(btp_check_buff("Prayer of Fortitude", unit)) then return true; end
    return false;
end

function btp_priest_is_innerfire(unit)
    if(btp_check_buff("Inner Fire")) then return true; end
    return false;
end

function btp_priest_is_divinespirit(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("Divine Spirit", unit)) then return true; end
    if(btp_check_buff("Prayer of Spirit", unit)) then return true; end
    return false;
end

function btp_priest_is_innerwill(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("Inner WIll", unit)) then return true; end
    return false;
end

function btp_priest_is_shadowprotection(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("Shadow Protection", unit)) then return true; end
    if(btp_check_buff("Prayer of Shadow Protection", unit)) then return true; end
    return false;
end


function btp_priest_is_touchofweakness(unit)
    if(not unit) then  unit = "player"; end
    if(btp_check_buff("Touch of Weakness", unit)) then return true; end
    return false;
end

function btp_priest_is_my_vampiricembrace(unit)
    if(not unit) then  unit = "player"; end
    has_vemb, my_vemb, num_vemb = btp_check_buff("UnsummonBuilding", unit);
    if (my_vemb) then return true; end
    return false;
end

function btp_priest_is_my_vampirictouch(unit)
    if(not unit) then  unit = "player"; end
    has_vtouch, my_vtouch, num_vtouch = btp_check_debuff("Stoicism", unit);
    if(my_vtouch) then return true; end
    return false;
end;

function btp_priest_is_my_mindspike(unit, num)
    if(not unit) then  unit = "target"; end
    if(not num) then num = 3; end
    has_mspike, my_mspike, num_mspike = btp_check_debuff("mindspike", unit);
    if (my_mspike and num_mspike >= num) then return true; end
    return false;
end;

function btp_priest_is_my_swp(unit)
    if(not unit) then  unit = "target"; end
    has_swp, my_swp, num_swp = btp_check_debuff("Shadow Word: Pain", unit);
    return my_swp;
end

function btp_priest_is_my_dp(unit)
    if(not unit) then  unit = "target"; end
    has_swp, my_swp, num_swp = btp_check_debuff("Devouring Plague", unit);
    return my_swp;
end

function btp_priest_cast_heal(spell, unit)
    if(not unit) then  btp_frame_debug("btp_priest_cast_spell called without unit"); return false; end
    if(not spell) then btp_frame_debug("btp_priest_cast_heal - called without a spell"); return false; end

    if(not btp_cast_spell_on_target(spell, unit)) then return false; end
    return true;
end
function btp_priest_cast_spell(spell, unit)
    if(not unit) then  unit = "target"; end
    if(not spell) then return false; end
    if(not btp_in_range(spell, unit)) then return false; end
    if(not btp_cast_spell_on_target(spell, unit)) then return false; end
    return true;
end
