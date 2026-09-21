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


BTP_SHAM_THRESH_MANA=.33
BTP_SHAM_THRESH_CRIT=.40
BTP_SHAM_THRESH_LARGE=.70
BTP_SHAM_THRESH_SMALL=.95

earthShieldPlayer    = nil;
earthShieldPlayerOld = nil;
fireTotem            = "Searing Totem";
earthTotem           = "Tremor Totem";
waterTotem           = "Mana Spring Totem";
airTotem             = "Wrath of Air Totem";

fireTotemActive  = true;
earthTotemActive = true;
waterTotemActive = true;
airTotemActive   = true;
allTotemsOff     = false;

function btp_shaman_initialize()
	btp_frame_debug("Shaman INIT");
	SlashCmdList["SHAMTOT"] = btp_sham_totem;
	SLASH_SHAMTOT1 = "/shamtotem";
	SlashCmdList["SHAMHEAL"] = btp_sham_heal;
	SLASH_SHAMHEAL1 = "/shamheal";
	SlashCmdList["SHAMBUFF"] = btp_sham_buff;
	SLASH_SHAMBUFF1 = "/shambuff";

    cb_array["Lesser Healing Wave"]  = btp_cb_shaman_lesser_healing_wave;
    cb_array["Healing Wave"]         = btp_cb_shaman_healing_wave;
    cb_array["Chain Heal"]           = btp_cb_shaman_chain_heal;
end

function btp_cb_shaman_lesser_healing_wave()
    --
    -- First we get the Casting and channel information about the player
    -- and use this to make sure the player is casting something.
    --
    cast_spell, cast_rank, cast_display_name, cast_icon, cast_start_time,
    cast_end_time, cast_is_trade_skill = UnitCastingInfo("player");

    --
    -- May just be beteen casts, so let it stand, otherwise we should
    -- clear the callback if it's not the spell we expect.
    --
    if (cast_spell == nil) then
        return false;
    elseif (cast_spell ~= "Lesser Healing Wave") then
        --
        -- Well we are not casting our spell, so we can clear the callback.
        --
        current_cb = nil;
        return false;
    end

    --
    -- This is the second case where we clear the callback.  All the above
    -- code should stay the same; however, everything below this line will
    -- be very different based on the type of spell and what we expect to
    -- do with the callback.
    --

    if (UnitHealth(current_cb_target) < 2 or
       (((cast_start_time - GetTime()) <= 1) and
        UnitHealth(current_cb_target)/UnitHealthMax(current_cb_target) >
        BTP_SHAM_THRESH_SMALL)) then
        --
        -- We will use the IPT target box because we never use this,
        -- and we may get to do some back-to-back stop cast and cast
        -- something else action.  If this doesn't work well, then we
        -- should try to make this return true.
        --
        FuckBlizzardByNameStrange("stopcasting");
        current_cb = nil;
        return false;
    end

    return true;
end

function btp_cb_shaman_healing_wave()
    --
    -- First we get the Casting and channel information about the player
    -- and use this to make sure the player is casting something.
    --
    cast_spell, cast_rank, cast_display_name, cast_icon, cast_start_time,
    cast_end_time, cast_is_trade_skill = UnitCastingInfo("player");

    --
    -- May just be beteen casts, so let it stand, otherwise we should
    -- clear the callback if it's not the spell we expect.
    --
    if (cast_spell == nil) then
        return false;
    elseif (cast_spell ~= "Healing Wave") then
        --
        -- Well we are not casting our spell, so we can clear the callback.
        --
        current_cb = nil;
        return false;
    end

    --
    -- This is the second case where we clear the callback.  All the above
    -- code should stay the same; however, everything below this line will
    -- be very different based on the type of spell and what we expect to
    -- do with the callback.
    --

    if (UnitHealth(current_cb_target) < 2 or
       (((cast_start_time - GetTime()) <= 1) and
        UnitHealth(current_cb_target)/UnitHealthMax(current_cb_target) >
        BTP_SHAM_THRESH_SMALL)) then
        --
        -- We will use the IPT target box because we never use this,
        -- and we may get to do some back-to-back stop cast and cast
        -- something else action.  If this doesn't work well, then we
        -- should try to make this return true.
        --
        FuckBlizzardByNameStrange("stopcasting");
        current_cb = nil;
        return false;
    end

    return true;
end

function btp_cb_shaman_chain_heal()
    --
    -- First we get the Casting and channel information about the player
    -- and use this to make sure the player is casting something.
    --
    cast_spell, cast_rank, cast_display_name, cast_icon, cast_start_time,
    cast_end_time, cast_is_trade_skill = UnitCastingInfo("player");

    --
    -- May just be beteen casts, so let it stand, otherwise we should
    -- clear the callback if it's not the spell we expect.
    --
    if (cast_spell == nil) then
        return false;
    elseif (cast_spell ~= "Chain Heal") then
        --
        -- Well we are not casting our spell, so we can clear the callback.
        --
        current_cb = nil;
        return false;
    end

    --
    -- This is the second case where we clear the callback.  All the above
    -- code should stay the same; however, everything below this line will
    -- be very different based on the type of spell and what we expect to
    -- do with the callback.
    --

    if (UnitHealth(current_cb_target) < 2 or
       (((cast_start_time - GetTime()) <= 1) and
        UnitHealth(current_cb_target)/UnitHealthMax(current_cb_target) >
        BTP_SHAM_THRESH_SMALL)) then
        --
        -- We will use the IPT target box because we never use this,
        -- and we may get to do some back-to-back stop cast and cast
        -- something else action.  If this doesn't work well, then we
        -- should try to make this return true.
        --
        FuckBlizzardByNameStrange("stopcasting");
        current_cb = nil;
        return false;
    end

    return true;
end

function btp_sham_set_earth(unit)
    foundPlayer = false;

    if (earthShieldManual or string.find(unit, "pet")) then
        return;
    end

    if(pcount > 0) then
        -- First check our priority queue
        for j = 0, pcount do
            pval = PRIORITY_G[j];

            for i = 1, GetNumRaidMembers() do
                    nextPlayer = "raid" .. i;
                    if(pval and UnitName(nextPlayer) and
                       string.lower(UnitName(nextPlayer)) ==
                       string.lower(pval)) then
                        foundPlayer          = true;
                        earthShieldPlayer    = nextPlayer;
                        earthShieldPlayerOld = nextPlayer;
                        break;
                    end
            end

            if (foundPlayer) then
                break;
            end

            if (GetNumRaidMembers() <= 0) then
                for i = 1, GetNumPartyMembers() do
                    nextPlayer = "party" .. i;
                    if(pval and UnitName(nextPlayer) and
                       string.lower(UnitName(nextPlayer)) ==
                       string.lower(pval)) then
                        foundPlayer          = true;
                        earthShieldPlayer    = nextPlayer;
                        earthShieldPlayerOld = nextPlayer;
                        break;
                    end
                end
            end
        end
    end

    if (foundPlayer) then
        return;
    end

    if (unit ~= nil) then
        if (earthShieldPlayerOld == nil or earthShieldPlayer == nil) then
            earthShieldPlayerOld = unit;
            earthShieldPlayer    = unit;
            return;
        end

        earthShieldPlayerOld = earthShieldPlayer;
        earthShieldPlayer    = unit;
    end
end

function btp_sham_buff()
	-- Check the player
	local cur_health = UnitHealth("player");
	local cur_health_max = UnitHealthMax("player");
	local cur_class = UnitClass("player");

    hasBandageBuff, myBandageBuff,
    numBandageBuff = btp_check_buff("Holy_Heal", bandageTarget);

    if (((GetTime() - lastBandage) <= 2) or hasBandageBuff) then
        castingBandage = true;
    end

    if (castingBandage) then
        return true;
    end

	-- Check the player
	local cur_health = UnitHealth("player");
	local cur_health_max = UnitHealthMax("player");
	local cur_class = UnitClass("player");

    --
    -- WaterShield check
    --
    hasWaterShield, myWaterShield,
    numWaterShield = btp_check_buff("WaterShield", "player");

    --
    -- Earthliving Weapon check
    --
    hasMainHandEnchant, mainHandExpiration, mainHandCharges,
    hasOffHandEnchant, offHandExpiration,
    offHandCharges = GetWeaponEnchantInfo();

    --
    -- EarthShield check
    --
    hasEarthShield, myEarthShield,
    numEarthShield = btp_check_buff("SkinofEarth", "player");

    if (not hasEarthShield and not hasWaterShield and
        UnitHealth("player")/UnitHealth("player") > BTP_SHAM_THRESH_CRIT and
        btp_cast_spell("Water Shield")) then
        return true;
    end

    if (not hasEarthShield and numWaterShield < 3 and
        not UnitAffectingCombat("player") and
        btp_cast_spell("Water Shield")) then
        return true;
    end

    if (not (hasMainHandEnchant or hasOffHandEnchant) and
        not UnitAffectingCombat("player") and
        btp_cast_spell("Earthliving Weapon")) then
        return true;
    end

    --
    -- Check if the earthShieldPlayer value is set and if so does that 
    -- person still have an earth shield on?  Note: use the
    -- btp_sham_set_earth() function to set this to the unit you want.
    --
    if (earthShieldPlayer == nil or earthShieldPlayerOld == nil) then
        return false;
    end

    --
    -- EarthShield check
    --
    hasEarthShieldOld, myEarthShieldOld,
    numEarthShieldOld = btp_check_buff("SkinofEarth", earthShieldPlayerOld);

    --
    -- EarthShield check
    --
    hasEarthShield, myEarthShield,
    numEarthShield = btp_check_buff("SkinofEarth", earthShieldPlayer);

    --
    -- WaterShield check
    --
    hasWaterShield, myWaterShield,
    numWaterShield = btp_check_buff("WaterShield", earthShieldPlayer);

    if (myEarthShieldOld and UnitAffectingCombat("player")) then
        return false;
    elseif (hasEarthShield and myEarthShield and numEarthShield < 6 and
            not UnitAffectingCombat("player") and
            UnitHealth(earthShieldPlayer)/UnitHealth(earthShieldPlayer) >
            BTP_SHAM_THRESH_CRIT and
            btp_check_dist(earthShieldPlayer, 1) and
            btp_cast_spell_on_target("Earth Shield", earthShieldPlayer)) then
        return true;
    elseif (not hasEarthShield and not hasWaterShield and
            UnitHealth(earthShieldPlayer)/UnitHealth(earthShieldPlayer) >
            BTP_SHAM_THRESH_CRIT and
            btp_check_dist(earthShieldPlayer, 1) and
            btp_cast_spell_on_target("Earth Shield", earthShieldPlayer)) then
        return true;
    else
        return false;
    end
end



function btp_sham_heal()
    castingBandage = false;
    hasBandage = false;
    bandageBag = 0;
    bandageSlot = 1;
    swiftnessActive = false;

    hasBandageBuff, myBandageBuff,
    numBandageBuff = btp_check_buff("Holy_Heal", bandageTarget);

    if (((GetTime() - lastBandage) <= 2) or hasBandageBuff) then
        castingBandage = true;
    end

    if (castingBandage) then
        return true;
    end

	ProphetKeyBindings();

    for bag=0,4 do
      for slot=1,GetContainerNumSlots(bag) do
        if (GetContainerItemLink(bag,slot)) then
          if (string.find(GetContainerItemLink(bag,slot), "Bandage")) then
              start, duration, enable = GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasBandage = true;
                  bandageBag = bag;
                  bandageSlot = slot;
              end
              break;
          end
        end
      end
    end

	-- Check the player
	local cur_health = UnitHealth("player");
	local cur_health_max = UnitHealthMax("player");
	local cur_class = UnitClass("player");

    if (SelfHeal(BTP_SHAM_THRESH_LARGE, BTP_SHAM_THRESH_MANA/3)) then
        --
        -- doing a self heal here (healthstones, potions, etc)
        --
        return true;
    end

    if ((((GetTime() - lastDecurse) >= 5) or blockOnDecurse) and
        BTP_Decursive()) then
        lastDecurse = GetTime();
        return true;
    end

    --
    -- check if we need to stop or start moving, this is just
    -- for PVP heals.
    --
    cur_player, partyHurtCount, raidHurtCount,
    raidSubgroupHurtCount = btp_health_status(BTP_SHAM_THRESH_SMALL);

    if (not stopMoving and pvpBot and cur_player ~= false) then
        -- we only want to stop when we are close to the action
        -- or when we are so low on health that we need a heal
        if (cur_player) then
            lastStopMoving = GetTime();
            stopMoving = true;
            FuckBlizzardMove("TURNLEFT");
        end
    elseif (stopMoving) then
        if (not cur_player) then
            stopMoving = false;
        elseif ((GetTime() - lastStopMoving) > 2) then
            lastStopMoving = GetTime();
            stopMoving = true;
            FuckBlizzardMove("TURNLEFT");
        end
    end

    --
	-- Check for critical heals and use an instant large heal
    -- if we can.  If we do not have huge heals ready to instant
    -- cast then we are just going to drop fast heals to get the
    -- target out of the woods.
    --
    cur_player, partyHurtCount, raidHurtCount,
    raidSubgroupHurtCount = btp_health_status(BTP_SHAM_THRESH_CRIT);

    if (cur_player ~= false and cur_health >= 2) then
        --
        -- Bandage Debuff check
        --
        hasBandageDebuff, myBandageDebuff,
        numBandageDebuff = btp_check_debuff("Bandage_08", cur_player);

        --
        -- Riptide Buff check
        --
        hasRiptide, myRiptide,
        numRiptide = btp_check_buff("Druid_Typhoon", cur_player);
    end

	if (((cur_health/cur_health_max <= BTP_SHAM_THRESH_CRIT and
        UnitAffectingCombat("player")) or (cur_player ~= false) and
        UnitAffectingCombat(cur_player)) and cur_health >= 2 and
        btp_cast_spell_alt("Nature's Swiftness")) then
        swiftnessActive = true;
	end

	if (cur_player ~= false and cur_health >= 2 and swiftnessActive and
        btp_cast_spell_on_target("Healing Wave", cur_player)) then
		-- btp_frame_debug("Healing Wave: " .. cur_player);
		FuckBlizzardTargetUnit("playertarget");
        btp_sham_set_earth(cur_player);
		return true; 
	elseif (cur_player ~= false and cur_health >= 2 and not myRiptide and
            btp_cast_spell_on_target("Riptide", cur_player)) then
		-- btp_frame_debug("Riptide: " .. cur_player);
		FuckBlizzardTargetUnit("playertarget");
        btp_sham_set_earth(cur_player);
		return true; 
	elseif (cur_player ~= false and cur_health >= 2 and
           ((pvpBot and stopMoving) or not pvpBot) and
            btp_cast_spell_on_target("Lesser Healing Wave", cur_player)) then
		-- btp_frame_debug("Lesser Healing Wave: " .. cur_player);
		FuckBlizzardTargetUnit("playertarget");
        btp_sham_set_earth(cur_player);
		return true; 
    elseif (cur_player ~= false and cur_health >= 2 and
           ((pvpBot and stopMoving) or not pvpBot) and
            hasBandage and not hasBandageDebuff and
            UnitAffectingCombat("player") and
            UnitPower("player")/UnitPowerMax("player") <=
            BTP_SHAM_THRESH_MANA/4) then
        lastBandage = GetTime();
        bandageTarget = cur_player;
        FuckBlizzardTargetUnitContainer(cur_player);
        FuckBlizUseContainerItem(bandageBag, bandageSlot);
        return true;
	end



    --
	-- Check for small heals and if > 2 people in a group need it chain
    --
    cur_player, partyHurtCount, raidHurtCount,
    raidSubgroupHurtCount = btp_health_status(BTP_SHAM_THRESH_SMALL,
                                              btpRaidHeal);

    if (cur_player ~= false and cur_health >= 2) then
        --
        -- Bandage Debuff check
        --
        hasBandageDebuff, myBandageDebuff,
        numBandageDebuff = btp_check_debuff("Bandage_08", cur_player);

        --
        -- Riptide Buff check
        --
        hasRiptide, myRiptide,
        numRiptide = btp_check_buff("Druid_Typhoon", cur_player);
    end

	if (cur_player ~= false and cur_health >= 2 and not myRiptide and
        UnitHealth(cur_player)/UnitHealthMax(cur_player) <=
        BTP_SHAM_THRESH_LARGE and
        btp_cast_spell_on_target("Riptide", cur_player)) then
		-- btp_frame_debug("Riptide: " .. cur_player);
		FuckBlizzardTargetUnit("playertarget");
        btp_sham_set_earth(cur_player);
		return true; 
	elseif (cur_player ~= false and cur_health >= 2 and
           ((raidHurtCount > 2) or (strfind(cur_player, "party") and
             partyHurtCount > 2)) and ((pvpBot and stopMoving) or
             not pvpBot) and UnitAffectingCombat("player") and
             btp_cast_spell("Tidal Force")) then
		return true; 
	elseif (cur_player ~= false and cur_health >= 2 and
           ((raidHurtCount > 2) or (strfind(cur_player, "party") and
             partyHurtCount > 2)) and ((pvpBot and stopMoving) or
             not pvpBot) and
            btp_cast_spell_on_target("Chain Heal", cur_player)) then
		-- btp_frame_debug("Chain Heal: " .. cur_player);
		FuckBlizzardTargetUnit("playertarget");
        btp_sham_set_earth(cur_player);
		return true; 
	elseif (cur_player ~= false and cur_health >= 2 and
            UnitHealth(cur_player)/UnitHealthMax(cur_player) <=
            BTP_SHAM_THRESH_LARGE and
           ((pvpBot and stopMoving) or not pvpBot) and
            btp_cast_spell_on_target("Healing Wave", cur_player)) then
		-- btp_frame_debug("Healing Wave: " .. cur_player);
		FuckBlizzardTargetUnit("playertarget");
        btp_sham_set_earth(cur_player);
        return true;
	elseif (cur_player ~= false and cur_health >= 2 and
           ((pvpBot and stopMoving) or not pvpBot) and
            btp_cast_spell_on_target("Lesser Healing Wave", cur_player)) then
		-- btp_frame_debug("Lesser Healing Wave: " .. cur_player);
		FuckBlizzardTargetUnit("playertarget");
        btp_sham_set_earth(cur_player);
		return true; 
    elseif (cur_player ~= false and cur_health >= 2 and
           ((pvpBot and stopMoving) or not pvpBot) and
            hasBandage and not hasBandageDebuff and
            UnitAffectingCombat("player") and
            UnitPower("player")/UnitPowerMax("player") <=
            BTP_SHAM_THRESH_MANA/4) then
        lastBandage = GetTime();
        bandageTarget = cur_player;
        FuckBlizzardTargetUnitContainer(cur_player);
        FuckBlizUseContainerItem(bandageBag, bandageSlot);
        return true;
	end

    -- Strange Place for this, but we want this to run after the
    -- healing code.
    --
    if (btp_sham_totem()) then
        return true;
    end

    if (BTP_Decursive()) then
        lastDecurse = GetTime();
        return true;
    end

    if (btp_sham_resurrection()) then
        return true;
    end

    return false;
end


function btp_sham_totem()
    hasBandageBuff, myBandageBuff,
    numBandageBuff = btp_check_buff("Holy_Heal", bandageTarget);

    if (((GetTime() - lastBandage) <= 2) or hasBandageBuff) then
        castingBandage = true;
    end

    if (castingBandage) then
        return true;
    end

    --
    -- Do fire totem
    --
    if (not allTotemsOff and fireTotemActive) then
        haveTotem, totemName, startTime, duration = GetTotemInfo(1);

        if (UnitAffectingCombat("player") and pvpBot and
            totemName ~= nil and
            not strfind(totemName, "Fire Elemental Totem") and
            btp_cast_spell("Fire Elemental Totem")) then
            return true;
        elseif (UnitAffectingCombat("player") and
                totemName ~= nil and not strfind(totemName, fireTotem) and
                not strfind(totemName, "Fire Elemental Totem") and
                btp_cast_spell(fireTotem)) then
            return true;
        end
    end

    --
    -- Do earth totem
    --
    if (not allTotemsOff and earthTotemActive) then
        haveTotem, totemName, startTime, duration = GetTotemInfo(2);

        if (UnitAffectingCombat("player") and pvpBot and
            totemName ~= nil and
            not strfind(totemName, "Earth Elemental Totem") and
            btp_cast_spell("Earth Elemental Totem")) then
            return true;
        elseif (UnitAffectingCombat("player") and
                totemName ~= nil and not strfind(totemName, earthTotem) and
                not strfind(totemName, "Earth Elemental Totem") and
                btp_cast_spell(earthTotem)) then
            return true;
        end
    end

    --
    -- Do water totem
    --
    if (not allTotemsOff and waterTotemActive) then
        haveTotem, totemName, startTime, duration = GetTotemInfo(3);

        if (UnitAffectingCombat("player") and
            totemName ~= nil and not strfind(totemName, "Mana Tide Totem") and
            UnitPower("player")/UnitPowerMax("player") <= BTP_SHAM_THRESH_MANA and
            btp_cast_spell("Mana Tide Totem")) then
            return true;
        elseif ((UnitAffectingCombat("player") or
               (strfind(waterTotem, "Mana Spring") and
               UnitHealth("player") >= 2 and
               UnitPower("player")/UnitPowerMax("player") <= .99)) and
               totemName ~= nil and not strfind(totemName, waterTotem) and
               not strfind(totemName, "Mana Tide Totem") and
               not strfind(totemName, "Poison Cleansing Totem") and
               not strfind(totemName, "Disease Cleansing Totem") and
               btp_cast_spell(waterTotem)) then
            return true;
        end
    end

    --
    -- Do air totem
    --
    if (not allTotemsOff and airTotemActive) then
        haveTotem, totemName, startTime, duration = GetTotemInfo(4);

        if (UnitAffectingCombat("player") and pvpBot and
            totemName ~= nil and not strfind(totemName, "Grounding Totem") and
            btp_cast_spell("Grounding Totem")) then
            return true;
        elseif (UnitAffectingCombat("player") and
                totemName ~= nil and not strfind(totemName, airTotem) and
                not strfind(totemName, "Grounding Totem") and
                btp_cast_spell(airTotem)) then
            return true;
        end
    end

    return false;
end


function btp_sham_resurrection()
    res_name = nil;
    resurrectionName = nil;

    for i = 0, GetNumPartyMembers() do
        res_name = "party" .. i;
        if (UnitHealth(res_name) < 2 and UnitHealth("player") >= 2 and
            btp_check_dist(res_name, 1)) then
            resurrectionName = res_name;
        end
    end

    for i = 1, GetNumRaidMembers() do
        res_name = "raid" .. i;
        if (UnitHealth(res_name) < 2 and UnitHealth("player") >= 2 and
            btp_check_dist(res_name, 1)) then
            resurrectionName = res_name;
        end
    end

    if (not UnitAffectingCombat("player") and resurrectionName ~= nil and
        UnitPower("player")/UnitPowerMax("player") > BTP_SHAM_THRESH_MANA and
        btp_cast_spell_on_target("Ancestral Spirit", resurrectionName)) then
		FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    return false;
end
