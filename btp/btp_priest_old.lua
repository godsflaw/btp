function PriestBuffOld()
    noFort = true;
    noInnerFire = true;
    noShadowProtection = true;
    noDivineSpirit = true;
    noTouchOfWeakness = true;
    nextPlayer = "player";
    hasFortitude = false;
    hasShadowProtect = false;
    hasInnerFire = false;
    hasDivineSpirit = false;
    hasTouchOfWeakness = false;
    hasPrayerFort = false;
    hasPrayerSpirit = false;
    hasPrayerShadowProtect = false;
    hasCandle = false;
    goodToBuff = true;

    ProphetKeyBindings();

    local i = 1
    while true do
       local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL);
       if not spellName then
          do break end
       end

        if(not btp_priest_is_innerwill() and not btp_priest_is_innerfire()) then
            if(btp_cast_spell("Inner Fire")) then 
           	    hasInnerFire = true;
		    return true; 
	    end
       end

       if (strfind(spellName, "Shadow Protection")) then
           hasShadowProtect = true;
       end

       if (strfind(spellName, "Power Word: Fortitude")) then
           hasFortitude = true;
       end

       if (strfind(spellName, "Divine Spirit")) then
           hasDivineSpirit = true;
       end

       if (not UnitAffectingCombat("player") and
           strfind(spellName, "Touch of Weakness")) then
           hasTouchOfWeakness = true;
       end

       if (strfind(spellName, "Prayer of Fortitude")) then
           start, duration = GetSpellCooldown(i, BOOKTYPE_SPELL);
           if (duration - (GetTime() - start) <= 0) then
              hasPrayerFort = true;
           end
       end

       if (strfind(spellName, "Prayer of Spirit")) then
           start, duration = GetSpellCooldown(i, BOOKTYPE_SPELL);
           if (duration - (GetTime() - start) <= 0) then
              hasPrayerSpirit = true;
           end
       end

       if (strfind(spellName, "Prayer of Shadow Protection")) then
           start, duration = GetSpellCooldown(i, BOOKTYPE_SPELL);
           if (duration - (GetTime() - start) <= 0) then
              hasPrayerShadowProtect = true;
           end
       end

       i = i + 1
    end

    for bag=0,4 do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot)) then
          if (string.find(C_Container.GetContainerItemLink(bag,slot), "Candle")) then
              hasCandle = true;
              break;
          end
        end
      end
    end

    if (GetNumPartyMembers() ~= 0) then
        for i = 1, GetNumPartyMembers() do
            nextPlayer = "party" .. i;
            if (UnitHealth(nextPlayer) < 4 or
                not btp_check_dist(nextPlayer,1)) then
                goodToBuff = false;
                break;
            end                
        end
    end
      
    for i = 0, 256 do
        buffName, buffRank, buffTexture,
        buffApplications, buffDuration, buffTime = UnitBuff("player", i);

        if (buffTexture and strfind(buffTexture, "Fortitude")) then
            noFort = false;
        end

        if (buffTexture and (strfind(buffTexture, "AntiShadow") or
            strfind(buffTexture, "ShadowProtection"))) then
            noShadowProtection = false;
        end

        if (buffTexture and strfind(buffTexture, "InnerFire")) then
            noInnerFire = false;
        end

        if (buffTexture and strfind(buffTexture, "Spirit")) then
            noDivineSpirit = false;
        end

        if (buffTexture and strfind(buffTexture, "DeadofNight")) then
            noTouchOfWeakness = false;
        end
    end

    if (hasCandle and hasPrayerFort and noFort and goodToBuff and
        not pvpBot) then
        FuckBlizzardTargetUnit("player");
        FuckBlizzardByName("Prayer of Fortitude");
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (hasFortitude and noFort) then
        FuckBlizzardTargetUnit("player");
        FuckBlizzardByName("Power Word: Fortitude");
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (hasCandle and hasPrayerSpirit and noDivineSpirit and goodToBuff and
        not pvpBot) then
        FuckBlizzardTargetUnit("player");
        FuckBlizzardByName("Prayer of Spirit");
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (hasDivineSpirit and noDivineSpirit) then
        FuckBlizzardTargetUnit("player");
        FuckBlizzardByName("Divine Spirit");
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (hasCandle and hasPrayerShadowProtect and noShadowProtection and
        goodToBuff and not pvpBot) then
        FuckBlizzardTargetUnit("player");
        FuckBlizzardByName("Prayer of Shadow Protection");
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (hasShadowProtect and noShadowProtection) then
        FuckBlizzardTargetUnit("player");
        FuckBlizzardByName("Shadow Protection");
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (hasInnerFire and noInnerFire) then
        FuckBlizzardTargetUnit("player");
        FuckBlizzardByName("Inner Fire");
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (hasTouchOfWeakness and noTouchOfWeakness) then
        FuckBlizzardTargetUnit("player");
        FuckBlizzardByName("Touch of Weakness");
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    for i = 1, GetNumPartyMembers() do
        nextPlayer = "party" .. i;
        noFort = true;
        noInnerFire = true;
        noShadowProtection = true;
        noDivineSpirit = true;

        if (UnitHealth(nextPlayer) >= 5 and
            btp_check_dist(nextPlayer,1)) then
            for i = 0, 256 do
                buffName, buffRank, buffTexture,
                buffApplications, buffDuration,
                buffTime = UnitBuff(nextPlayer, i);

                if (buffTexture and strfind(buffTexture, "Fortitude")) then
                    noFort = false;
                end

                if (buffTexture and (strfind(buffTexture, "AntiShadow") or
                    strfind(buffTexture, "ShadowProtection"))) then
                    noShadowProtection = false;
                end

                if (buffTexture and strfind(buffTexture, "Spirit")) then
                    noDivineSpirit = false;
                end
            end

            if (hasCandle and hasPrayerFort and noFort and goodToBuff and
                not pvpBot) then
                FuckBlizzardTargetUnit(nextPlayer);
                FuckBlizzardByName("Prayer of Fortitude");
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end

            if (hasFortitude and noFort) then
                FuckBlizzardTargetUnit(nextPlayer);
                FuckBlizzardByName("Power Word: Fortitude");
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end

            if (hasCandle and hasPrayerSpirit and noDivineSpirit and
                goodToBuff and not pvpBot) then
                FuckBlizzardTargetUnit("player");
                FuckBlizzardByName("Prayer of Spirit");
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end

            if (hasDivineSpirit and noDivineSpirit) then
                FuckBlizzardTargetUnit(nextPlayer);
                FuckBlizzardByName("Divine Spirit");
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end

            if (hasCandle and hasPrayerShadowProtect and noShadowProtection and
                goodToBuff and not pvpBot) then
                FuckBlizzardTargetUnit(nextPlayer);
                FuckBlizzardByName("Prayer of Shadow Protection");
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end

            if (hasShadowProtect and noShadowProtection) then
                FuckBlizzardTargetUnit(nextPlayer);
                FuckBlizzardByName("Shadow Protection");
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end
        end
    end
end


function btp_priest_heal_pvp()
BTP_PRIEST_THRESH_CRIT=.35
BTP_PRIEST_THRESH_LARGE=.49
BTP_PRIEST_THRESH_MEDIUM=.78
BTP_PRIEST_THRESH_SMALL=.85
BTP_PRIEST_THRESH_MANA=.15

    -- init
    ProphetKeyBindings();

    -- Check the player
    local cur_health = UnitHealth("player");
    local cur_health_max = UnitHealthMax("player");
    local cur_class = UnitClass("player");
    

    -- check if we are in spirit form if so spam out heals
    if(btp_priest_is_spirit()) then
        cur_player, party_cnt, raid_cnt, cur_party = btp_health_status(BTP_PRIEST_THRESH_LARGE);
        if(cur_player ~= false) then
            if(btp_cast_spell_on_target("Greater Heal", cur_player)) then return true; end
        end

        cur_player, party_cnt, raid_cnt, cur_party = btp_health_status(BTP_PRIEST_THRESH_MEDIUM);
        if(cur_player ~= false) then
            if(UnitAffectingCombat("player") and not btp_priest_is_pom()) then
                if(btp_cast_spell_on_target("Prayer of Mending", cur_player)) then return true; end
            end
            if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end
        end

        cur_player, party_cnt, raid_cnt, cur_party = btp_health_status((BTP_PRIEST_THRESH_SMALL + .04));
        if(cur_player ~= false) then

            if(cur_party >= 2) then
                if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end
            end

            if(not btp_priest_is_renew()) then
                if(btp_cast_spell_on_target("Renew", "player")) then return true; end
            end

            if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end
        end
    end
--[[

    if ((((GetTime() - lastDecurse) >= 5) or blockOnDecurse) and
        BTP_Decursive()) then                                   
        lastDecurse = GetTime();
        return true;            
    end
]]

    if(SelfHeal(BTP_PRIEST_THRESH_CRIT, BTP_PRIEST_THRESH_MANA)) then
        return true;
    end

    -- if we are getting hurt and in pvp mode
    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_SMALL and
       cur_health >= 5) then
        if(UnitAffectingCombat("player")) then
            if(btp_cast_spell("Psychic Scream")) then return true; end
            if(UnitAffectingCombat("player") and not btp_priest_is_pom()) then
                if(btp_cast_spell_on_target("Prayer of Mending", "player")) then return true; end
            end
            if(not btp_priest_is_pws()) then
                if(btp_cast_spell_on_target("Power Word: Shield", "player")) then return true; end
            end
        end
    end
    
    -- if we are about to die
    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_CRIT and
       cur_health >= 5) then
        if(btp_priest_is_sol()) then 
            if(btp_cast_spell_on_target("Flash Heal", "player")) then return true; end;
        end
        if(btp_cast_spell_on_target("Desperate Prayer", "player")) then return true; end

        if(not btp_priest_is_pws()) then
            if(btp_cast_spell_on_target("Power Word: Shield", "player")) then return true; end
        end

        if( not btp_priest_is_pom()) then
            if(btp_cast_spell_on_target("Prayer of Mending", "player")) then return true; end
        end
        if(stopMoving) then
            if(btp_cast_spell_on_target("Flash Heal", "player")) then return true; end
        end
        if(btp_cast_spell_on_target("Circle of Healing", "player")) then return true; end
    end

    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_MEDIUM and
       cur_health >= 5) then
        if(btp_priest_is_sol()) then 
            if(btp_cast_spell_on_target("Flash Heal", "player")) then return true; end;
        end
        if(UnitAffectingCombat("player") and not btp_priest_is_pom()) then
            if(btp_cast_spell_on_target("Prayer of Mending", "player")) then return true; end
        end
        if(not btp_priest_is_pws()) then
            if(btp_cast_spell_on_target("Power Word: Shield", "player")) then return true; end
        end
        if(not btp_priest_is_renew()) then
            if(btp_cast_spell_on_target("Renew", "player")) then return true; end
        end
        -- may want to remove this but should make her last longer in pvp
        if(btp_cast_spell_on_target("Circle of Healing", "player")) then return true; end
    end

    -- bang out any critical heals
    cur_player = btp_health_status(BTP_PRIEST_THRESH_CRIT);
    if(cur_player ~= false) then

           if(btp_priest_is_sol()) then 
            if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end;
        end

        if(UnitAffectingCombat(cur_player)) then
            if(btp_cast_spell_on_target("Guardian Spirit", cur_player)) then return true; end

            if(btp_priest_is_pws()) then
                if(btp_cast_spell_on_target("Power Word: Shield", "player")) then return true; end
            end

            if(not btp_priest_is_pom()) then
                if(btp_cast_spell_on_target("Prayer of Mending", cur_player)) then return true; end
            end

            if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end
        else

            if(not btp_priest_is_renew(cur_player)) then
                if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
            end
            if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end
        end
    end


    -- check if we need to stop or start moving
    cur_player = btp_health_status(.78);
    if((cur_health/cur_health_max <= .45 or
        cur_player ~= false)) then
        -- we only want to stop when we are close to the action
        -- or when we are so low on health that we need a larger heal
        if(btp_check_dist(cur_player, 2) or
            (cur_health/cur_health_max <= .45)) then
            -- stop moving
            -- btp_frame_debug("STOP Moving");
            --
            -- XXX for not disable
            stopMoving = true;
            FuckBlizzardMove("TURNLEFT");
        end
    elseif(stopMoving) then
        cur_player = btp_health_status(BTP_PRIEST_THRESH_LARGE);
        if((cur_health/cur_health_max >= BTP_PRIEST_THRESH_LARGE) and
            not cur_player) then
            -- btp_frame_debug("START Moving");
            stopMoving = false;
        end
    end


    -- cast our larger heals on our self if need be
    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_LARGE and
       cur_health >= 5) then
           -- if someone else is also hurt might as well use binding heal
        cur_player = btp_health_status(BTP_PRIEST_THRESH_MEDIUM);
        if(cur_player ~= false and stopMoving) then
            if(btp_cast_spell_on_target("Binding Heal", cur_player)) then return true; end;
        end
        -- no one else is hurt so target ourself
           if(btp_priest_is_sol()) then 
            if(btp_cast_spell_on_target("Flash Heal", "player")) then return true; end;
        end

        if(UnitAffectingCombat("player")) then
            if(not btp_priest_is_pom()) then
                if(btp_cast_spell_on_target("Prayer of Mending", "player")) then return true; end
            end

            if(not btp_priest_is_renew(cur_player)) then
                if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
            end

            if(not btp_priest_is_pws()) then
                if(btp_cast_spell_on_target("Power Word: Shield", "player")) then return true; end
            end

            if(stopMoving) then
                if(btp_cast_spell_on_target("Greater Heal", "player")) then return true; end
            else
                if(btp_cast_spell_on_target("Circle of Healing", "player")) then return true; end
            end
        else
            if(stopMoving) then
                if(btp_cast_spell_on_target("Greater Heal", "player")) then return true; end
            else
                if(not btp_priest_is_renew(cur_player)) then
                    if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
                end
                if(btp_cast_spell_on_target("Flash Heal", "player")) then return true; end
            end
        end
    end


    -- check everyone else for a large heal
    cur_player = btp_health_status(BTP_PRIEST_THRESH_LARGE);
    if(cur_player ~= false) then
           if(btp_priest_is_sol()) then 
            if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end;
        end

        if(UnitAffectingCombat(cur_player)) then
            if(not btp_priest_is_pom(cur_player)) then
                if(btp_cast_spell_on_target("Prayer of Mending", cur_player)) then return true; end
            end

            if(not btp_priest_is_pws()) then
                if(btp_cast_spell_on_target("Power Word: Shield", cur_player)) then return true; end
            end

            if(stopMoving) then
                if(btp_cast_spell_on_target("Greater Heal", cur_player)) then return true; end
            else
                if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end
            end

        else
            if(stopMoving) then
                if(btp_cast_spell_on_target("Greater Heal", cur_player)) then return true; end
            else
                if(not btp_priest_is_renew(cur_player)) then
                    if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
                end
                if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end
            end
        end

    end

    -- Check for medium heals
    cur_player, party_cnt, raid_cnt, cur_party = btp_health_status(BTP_PRIEST_THRESH_MEDIUM);
    if(cur_player ~= false) then

           if(btp_priest_is_sol()) then 
            if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end;
        end

        if(UnitAffectingCombat(cur_player)) then
            if(not btp_priest_is_pom(cur_player)) then
                if(btp_cast_spell_on_target("Prayer of Mending", cur_player)) then return true; end
            end
 
            if(not btp_priest_is_renew(cur_player)) then
                if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
            end

            if(not btp_priest_is_pws()) then
                if(btp_cast_spell_on_target("Power Word: Shield", cur_player)) then return true; end
            end

            if(stopMoving) then
                if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end
            else
                if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end
            end


        else
            if(not btp_priest_is_renew(cur_player)) then
                if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
            end

            if(stopMoving) then
                if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end
            end
        end

    end

    -- Check for small heals last
    -- XXX will want to change this
    cur_player = btp_health_status(BTP_PRIEST_THRESH_SMALL);
    if(cur_player ~= false) then
           if(btp_priest_is_sol()) then 
            if(btp_cast_spell_on_target("Flash Heal", cur_player)) then return true; end;
        end
        if(not btp_priest_is_renew(cur_player)) then
            if(btp_cast_spell_on_target("Renew", cur_player)) then return true; end
        end
    end

--[[
    if(BTP_Decursive()) then
        return true;
    end
]]
    return false;
end

function btp_priest_heal_std()
    -- init
    ProphetKeyBindings();

    -- Check the player
    local cur_health = UnitHealth("player");
    local cur_health_max = UnitHealthMax("player");
    local cur_class = UnitClass("player");

    -- check if we are in spirit form if so spam out heals
    if(btp_priest_is_spirit()) then
        cur_player = btp_health_status(BTP_PRIEST_THRESH_SMALL);
        FuckBlizzardTargetUnit(cur_player);
        if(cur_player ~= false) then
            if(UnitAffectingCombat("player") and not btp_priest_is_pom()) then
                if(btp_cast_spell("Prayer of Mending")) then return true; end
            end
            if(btp_cast_spell("Circle of Healing")) then return true; end
            if(btp_cast_spell("Prayer of Healing")) then return true; end
            if(btp_cast_spell("Flash Heal")) then return true; end
        end

    end
--[[

    if ((((GetTime() - lastDecurse) >= 5) or blockOnDecurse) and
        BTP_Decursive()) then                                   
        lastDecurse = GetTime();
        return true;            
    end
]]

    if(SelfHeal(BTP_PRIEST_THRESH_CRIT, BTP_PRIEST_THRESH_MANA)) then
        return true;
    end

    -- if we are getting hurt and in pvp mode
    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_SMALL and
       cur_health >= 5) then
        if(UnitAffectingCombat("player")) then
               if(pvpBot) then
                if(btp_cast_spell("Psychic Scream")) then return true; end
            else
                if(btp_cast_spell("Fade")) then return true; end
            end
        end
    end

    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_CRIT and
       cur_health >= 5) then
        FuckBlizzardTargetUnit("player");
        if(not btp_priest_is_pws()) then
            if(btp_cast_spell("Power Word: Shield")) then return true; end
        end
        if(btp_cast_spell("Circle of Healing")) then 
            return true; 
        end
        if(btp_cast_spell("Flash Heal")) then 
            return true; 
        end
    end

    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_MEDIUM and
       cur_health >= 5) then
        FuckBlizzardTargetUnit("player");
        if(not btp_priest_is_renew()) then
            if(btp_cast_spell("Renew")) then return true; end
        end
    end

    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_LARGE and
       cur_health >= 5) then
        cur_player = btp_health_status(BTP_PRIEST_THRESH_MEDIUM);
        if(cur_player ~= false) then
            FuckBlizzardTargetUnit(cur_player);
            if(btp_cast_spell("Binding Heal")) then return true; end;
        end
        FuckBlizzardTargetUnit("player");
        if(pvpBot) then
            if(btp_cast_spell("Flash Heal")) then return true; end
        else
            if(btp_cast_spell("Greater Heal")) then return true; end
        end
    end

    -- Check for critical heals and use a fast heal
    cur_player = btp_health_status(BTP_PRIEST_THRESH_CRIT);
    if(cur_health/cur_health_max <= BTP_PRIEST_THRESH_CRIT and
       cur_health >= 5) then
        FuckBlizzardTargetUnit(cur_player);
        if(not btp_priest_is_pws(cur_player)) then
            if(btp_cast_spell("Power Word: Shield")) then return true; end
        end
        if(btp_cast_spell("Circle of Healing")) then 
            return true; 
        end
        if(btp_cast_spell("Flash Heal")) then 
            return true; 
        end
    end

    -- Check for large heals
    cur_player = btp_health_status(BTP_PRIEST_THRESH_LARGE);
    if(cur_player ~= false) then
        FuckBlizzardTargetUnit(cur_player);
        if(pvpBot) then
            if(btp_cast_spell("Flash Heal")) then return true; end
        else
            if(btp_cast_spell("Greater Heal")) then return true; end
        end
    end

    
    -- Check for medium heals
    -- cur_player = btp_health_status(BTP_PRIEST_THRESH_MEDIUM);
    cur_player, party_cnt, raid_cnt, cur_party = btp_health_status(BTP_PRIEST_THRESH_MEDIUM);
    
    if(cur_player ~= false) then
        FuckBlizzardTargetUnit(cur_player);

        if(not btp_priest_is_renew(cur_player)) then
            if(btp_cast_spell("Renew")) then return true; end
        end

        if(UnitAffectingCombat(cur_player) and not btp_priest_is_pom(cur_player)) then
            if(btp_cast_spell("Prayer of Mending")) then return true; end
        end

        if(UnitAffectingCombat(cur_player)) then
            if(cur_party >= 2) then
                if(btp_cast_spell_on_target("Circle of Healing", cur_player)) then return true; end
            end

            if(btp_cast_spell("Flash Heal")) then 
                return true; 
            end
        end
    end

    -- Check for small heals last
    -- XXX will want to change this
    cur_player = btp_health_status(BTP_PRIEST_THRESH_SMALL);
    if(cur_player ~= false) then

        FuckBlizzardTargetUnit(cur_player);
        if(not btp_priest_is_renew(cur_player)) then
            if(btp_cast_spell("Renew")) then return true; end
        end
        if(UnitAffectingCombat(cur_player) and not btp_priest_is_pom(cur_player)) then
            if(btp_cast_spell("Prayer of Mending")) then return true; end
        end


    end

--[[
     if(BTP_Decursive()) then
         return true;
     end
]]
    return false;
end

