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
-- These are fairly well tested and should not need to be changed.
--
DR_THRESH = .45;
DR_SCALAR = .50;
DR_MANA = .3;

--
-- MAX_DRDEST is how many destruction spells you have to cycle through.
-- Again this count it from 0 - 3, which is a total of 4.  There may be
-- more to cycle through as bliz adds more spells.
--
MAX_DRDEST = 1;

--
-- YOU CAN STOP HERE!  THERE IS NOTHING LEFT FOR YOU TO CHANGE.
--
druidDestCount = 0;
memberIDDR = 1;
lastLBTarget = "player";

lastEntanglingRoots = 0;
lastNaturesGrasp = 0;
lastFaerieFire = 0;
lastTranquility = 0;

iTarget = UnitName("player");

function btp_druid_initialize()
    btp_frame_debug("Druid INIT");

    SlashCmdList["DRUIDB"] = druid_buff;
    SLASH_DRUIDB1 = "/db";
    SlashCmdList["DRUIDH"] = druid_heal;
    SLASH_DRUIDH1 = "/dh";
    SlashCmdList["DRUIDD"] = druid_dps;
    SLASH_DRUIDD1 = "/dd";
    SlashCmdList["DRUIDR"] = druid_roach;
    SLASH_DRUIDR1 = "/dr";

    cb_array["Regrowth"]           = btp_cb_druid_regrowth;
    cb_array["Healing Touch"]      = btp_cb_druid_healing_touch;
    cb_array["Nourish"]            = btp_cb_druid_nourish;
    cb_array["Tranquility"]        = btp_cb_druid_tranquility;
    cb_array["Rebirth"]            = btp_cb_druid_rebirth;
end

function druid_heal()
    hasBandage = false;
    bandageBag = 0;
    bandageSlot = 1;
    playerName = nil;
    tankName = nil;

    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    --
    -- We need to reset this here since a druid callback may have flipped it.
    -- Hmmm now that I think about this, this is hax!
    --
    stopMoving = false;

    --
    -- Innervate Buff Check
    --
    hasInnervate, myInnervate,
    numInnervate, expInnervate = btp_check_buff("Innervate", "player");

    --
    -- Innervate Buff Check
    --
    targetHasInnervate, targetMyInnervate,
    targetNumInnervate, targetExpInnervate = btp_check_buff(
        "Innervate", btp_name_to_unit(iTarget)
    );

    --
    -- Nature's Swiftness check
    --
    hasNaturesSwiftness, myNaturesSwiftness,
    numNaturesSwiftness, expNaturesSwiftness = btp_check_buff(
        "Nature's Swiftness", "player"
    );

    --
    -- Bandage Check check
    --
    hasBandageBuff, myBandageBuff,
    numBandageBuff, expBandageBuff = btp_check_buff("Bandage", bandageTarget);

    -- we're currently bandaging someone, so just return
    if (myBandageBuff) then
        return true;
    end

    ProphetKeyBindings();

    for bag=0,4 do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot)) then
          if (string.find(C_Container.GetContainerItemLink(bag,slot), "Bandage")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
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

    if (SelfHeal(DR_THRESH, DR_MANA/3)) then
        --
        -- doing a self heal here (healthstones, potions, etc)
        --
        return true;
    elseif (not targetHasInnervate and
            UnitAffectingCombat("player") and
            UnitPower(btp_name_to_unit(iTarget)) /
            UnitPowerMax(btp_name_to_unit(iTarget)) <= DR_MANA/3 and
            btp_cast_spell_on_target("Innervate",
            btp_name_to_unit(iTarget))) then
        FuckBlizzardTargetUnit("playertarget");
        return true;
    elseif (pvpBot and UnitAffectingCombat("player") and
            UnitHealth("player")/UnitHealthMax("player") <=
           (DR_THRESH + DR_SCALAR) and UnitHealth("player") > 1 and
            btp_cast_spell_alt("Barkskin")) then
        -- This has no GCD
    elseif (pvpBot and UnitAffectingCombat("player") and
            not btp_check_buff("Nature's Grasp", "player") and
            UnitHealth("player")/UnitHealthMax("player") <=
           (DR_THRESH + DR_SCALAR) and UnitHealth("player") > 1 and
            btp_cast_spell("Nature's Grasp")) then
        return true;
    end

    --
    -- This check is to make sure the tank always has lifebloom
    -- The hack here is to say we only want the priority list and
    -- show me all users at 100% health or lower.  This should always
    -- return our main tank or nothing if there is no list.
    --
    if (pcount > 0 and UnitAffectingCombat("player")) then
        if (PRIORITY_ONLY) then
            tankName, partyHurtCount, raidHurtCount,
            raidSubgroupHurtCount = btp_health_status(1);
        else
            PRIORITY_ONLY = true;
            tankName, partyHurtCount, raidHurtCount,
            raidSubgroupHurtCount = btp_health_status(1);
            PRIORITY_ONLY = false;
        end
    end

    -- if ((((GetTime() - lastDecurse) >= 5) or blockOnDecurse) and
    --     BTP_Decursive()) then
    --     lastDecurse = GetTime();
    --     return true;
    -- end

    --
    -- Check for large heals
    --
    playerName, partyHurtCount, raidHurtCount,
    raidSubgroupHurtCount = btp_health_status(DR_THRESH);

    if (playerName) then
        --
        -- Bandage Debuff check
        --
        hasBandageDebuff, myBandageDebuff,
        numBandageDebuff, expBanadageDebuff = btp_check_debuff("Recently Bandaged", playerName);

        --
        -- Rejuvination check
        --
        hasRejuvenation, myRejuvenation,
        numRejuvenation, expRejuvenation = btp_check_buff("Rejuvenation", playerName);

        --
        -- Regrowth check
        --
        hasRegrowth, myRegrowth,
        numRegrowth, expRegrowth = btp_check_buff("Regrowth", playerName);

        if ((myRejuvenation or myRegrowth) and UnitAffectingCombat("player") and
            btp_cast_spell_on_target_alt("Swiftmend", playerName)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif ((partyHurtCount > 1 or raidHurtCount > 1) and
                UnitAffectingCombat("player") and
                btp_cast_spell("Tranquility")) then

            if (not stopMoving and pvpBot) then
                stopMoving = true;
                FuckBlizzardMove("TURNLEFT");
            end

            lastTranquility = GetTime();
            return true;
        elseif (UnitAffectingCombat("player") and
               (btp_cast_spell_alt("Nature's Swiftness") or
                hasNaturesSwiftness) and
                btp_cast_spell_on_target("Healing Touch", playerName)) then

            if (not stopMoving and pvpBot) then
                stopMoving = true;
                FuckBlizzardMove("TURNLEFT");
            end

            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (not myRegrowth and
                btp_cast_spell_on_target("Regrowth", playerName)) then

            if (not stopMoving and pvpBot) then
                stopMoving = true;
                FuckBlizzardMove("TURNLEFT");
            end

            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (not myRejuvenation and
                btp_cast_spell_on_target("Rejuvenation", playerName)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (UnitAffectingCombat("player") and
                btp_cast_spell_on_target("Healing Touch", playerName)) then

            if (not stopMoving and pvpBot) then
                stopMoving = true;
                FuckBlizzardMove("TURNLEFT");
            end

            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (hasBandage and not hasBandageDebuff and
                UnitAffectingCombat("player") and
                UnitPower("player")/UnitPowerMax("player") <= DR_MANA/4) then
            lastBandage = GetTime();
            bandageTarget = playerName;
            FuckBlizzardTargetUnitContainer(playerName);
            FuckBlizUseContainerItem(bandageBag, bandageSlot);
            return true;
        end
    end

    --
    -- Check for Healing Over Time spells
    --
    if (btpRaidHeal) then
        btpRaidHeal = false;
        playerName, partyHurtCount, raidHurtCount, raidSubgroupHurtCount =
        btp_health_status(DR_THRESH+DR_SCALAR, btpRaidHeal);
        btpRaidHeal = true;
    else
        playerName, partyHurtCount, raidHurtCount, raidSubgroupHurtCount =
        btp_health_status(DR_THRESH+DR_SCALAR, btpRaidHeal);
    end

    --
    -- This should let us only heal people that _need_ to be healed when
    -- building up mana.  It will help keep us outside the 5 second rule
    -- and yield more healing over time.  In short, if we have an innervate
    -- up, then we will only heal people above DR_THRESH if they are tanking.
    --
    if (hasInnervate and not playerName) then
        return false;
    elseif (hasInnervate and playerName and
            UnitHealth(playerName)/UnitHealthMax(playerName) <=
            DR_THRESH + DR_SCALAR/2 and
            UnitThreatSituation(playerName) ~= nil and
            UnitThreatSituation(playerName) < 2) then
        return false;
    end

    if (playerName) then
        --
        -- Thorns check
        --
        hasThorns, myThorns,
        numThorns, expThorns = btp_check_buff("Thorns", nextPlayer);

        --
        -- Bandage Debuff check
        --
        hasBandageDebuff, myBandageDebuff,
        numBandageDebuff, expBanadageDebuff = btp_check_debuff("Recently Bandaged", playerName);

        --
        -- Rejuvination check
        --
        hasRejuvenation, myRejuvenation,
        numRejuvenation, expRejuvenation = btp_check_buff("Rejuvenation", playerName);

        --
        -- Regrowth check
        --
        hasRegrowth, myRegrowth,
        numRegrowth, expRegrowth = btp_check_buff("Regrowth", playerName);

        if ((partyHurtCount > 3 or raidHurtCount > 3) and
            UnitAffectingCombat("player") and btp_cast_spell("Tranquility")) then

            if (not stopMoving and pvpBot) then
                stopMoving = true;
                FuckBlizzardMove("TURNLEFT");
            end

            lastTranquility = GetTime();
            return true;
        elseif ((myRejuvenation or myRegrowth) and
                UnitAffectingCombat("player") and
                UnitHealth(playerName)/UnitHealthMax(playerName) <= 
                DR_THRESH + DR_SCALAR/2 and
                btp_cast_spell_on_target("Swiftmend", playerName)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (not myRejuvenation and
                (
                    (UnitThreatSituation(playerName) ~= nil and UnitThreatSituation(playerName) >= 1) or
                    UnitHealth(playerName)/UnitHealthMax(playerName) <= DR_THRESH + DR_SCALAR or
                    pvpBot
                ) and btp_cast_spell_on_target("Rejuvenation", playerName)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (UnitAffectingCombat("player") and not myRegrowth and
               (UnitHealth(playerName)/UnitHealthMax(playerName) <= (DR_THRESH + DR_SCALAR/2)) and
                btp_cast_spell_on_target("Regrowth", playerName)) then

            if (not stopMoving and pvpBot) then
                stopMoving = true;
                FuckBlizzardMove("TURNLEFT");
            end

            FuckBlizzardTargetUnit("playertarget");
            return true;
        end
    end

    -- if (BTP_Decursive()) then
    --     return true;
    -- end

    return false;
end

function druid_buff()
    noMarkOfWild = true;
    hasWild = false;
    treeCount = 0;
    goodToBuff = true;
    nextPlayer = "player";

    ProphetKeyBindings();

    for nextPlayer in btp_iterate_group_members() do
        if (UnitHealth(nextPlayer) < 4 or not btp_check_dist(nextPlayer, 1)) then
            goodToBuff = false;
            break;
        end
    end

    if (GetNumGroupMembers() == 0) then
        goodToBuff = false;
    end

    for bag=0,4 do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot)) then
          if (string.find(C_Container.GetContainerItemLink(bag,slot), "Wild")) then
              hasWild = true;
              break;
          end
        end
      end
    end

    --
    -- Mark of the Wild check
    --
    hasMark, myMark, numMark, expMark = btp_check_buff("Mark of the Wild", "player");

    --
    -- Gift of the Wild check
    --
    hasGift, myGift, numGift, expGift = btp_check_buff("Gift of the Wild", "player");

    --
    -- Thorns
    --
    hasThorns, myThorns, numThorns, expThorns = btp_check_buff("Thorns", "player");

    if (hasMark or hasGift) then
        noMarkOfWild = false;
    end

    if (noMarkOfWild and
        btp_cast_spell_on_target("Mark of the Wild", "player")) then
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (not hasThorns and
        btp_cast_spell_on_target("Thorns", "player")) then
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    for nextPlayer in btp_iterate_group_members() do
        noMarkOfWild = true;

        if (UnitHealth(nextPlayer) >= 5 and btp_check_dist(nextPlayer,1)) then
            --
            -- Mark of the Wild check
            --
            hasMark, myMark,
            numMark, expMark = btp_check_buff("Mark of the Wild", nextPlayer);

            --
            -- Gift of the Wild check
            --
            hasGift, myGift,
            numGift, expGift = btp_check_buff("Gift of the Wild", nextPlayer);

            --
            -- Thorns check
            --
            hasThorns, myThorns,
            numThorns, expThorns = btp_check_buff("Thorns", nextPlayer);

            --
            if (hasMark or hasGift) then
                noMarkOfWild = false;
            end

            if (hasWild and noMarkOfWild and goodToBuff and not pvpBot and
                btp_cast_spell_on_target("Gift of the Wild", nextPlayer)) then
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end

            if (noMarkOfWild and
                btp_cast_spell_on_target("Mark of the Wild", nextPlayer)) then
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end

            if (not hasThorns and
                btp_cast_spell_on_target("Thorns", nextPlayer)) then
                FuckBlizzardTargetUnit("playertarget");
                return true;
            end
        end
    end

    noMarkOfWild = true;

    --
    -- Mark of the Wild check
    --
    hasMark, myMark, numMark, expMark = btp_check_buff("Mark of the Wild", "target");

    --
    -- Gift of the Wild check
    --
    hasGift, myGift, numGift, expGift = btp_check_buff("Gift of the Wild", "target");

    --
    -- Thorns
    --
    hasThorns, myThorns, numThorns, expThorns = btp_check_buff("Thorns", "target");

    if (hasMark or hasGift) then
        noMarkOfWild = false;
    end

    if (noMarkOfWild and UnitIsPlayer("target") and
        btp_cast_spell_on_target("Mark of the Wild", "target")) then
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end

    if (not hasThorns and UnitIsPlayer("target") and
        btp_cast_spell_on_target("Thorns", "target")) then
        FuckBlizzardTargetUnit("playertarget");
        return true;
    end
end

function druid_dps()
    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    ProphetKeyBindings();

    --
    -- Moonfire check
    --
    hasMoonfire, myMoonfire,
    numMoonfire, expMoonFire = btp_check_debuff("Moonfire", "target");

    --
    -- Insect Swarm check
    --
    hasInsectSwarm, myInsectSwarm,
    numInsectSwarm, expInsectSwarm = btp_check_debuff("Insect Swarm", "target");

    --
    -- Entangling Roots check
    --
    hasEntanglingRoots, myEntanglingRoots,
    numEntanglingRoots, expEntanglingRoots = btp_check_debuff("Entangling Roots", "target");

    playerHealthRatio =  UnitHealth("player")/UnitHealthMax("player");
    targetHealthRatio =  UnitHealth("target")/UnitHealthMax("target");

    if (druid_heal()) then
        FuckBlizzardTargetUnit("playertarget");
        return true;
    elseif (not UnitAffectingCombat("player") and
            btp_cast_spell("Wrath")) then
        return true;
    elseif ((btp_is_casting("target") or btp_is_channeling("target")) and
            btp_check_dist("target", 3) and btp_cast_spell("War Stomp")) then
        return true;
    elseif (targetHealthRatio < .20 and not hasEntanglingRoots and
            UnitCreatureType("target") == "Humanoid" and
            btp_cast_spell("Entangling Roots")) then
        return true;
    elseif (not myInsectSwarm and btp_cast_spell("Insect Swarm")) then
        return true;
    elseif (not myMoonfire and btp_cast_spell("Moonfire")) then
        return true;
    elseif (playerHealthRatio == 1 and btp_cast_spell("Starfire")) then
        return true;
    elseif (btp_cast_spell("Wrath")) then
        return true;
    end

    return false;
end

function druid_roach()
    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    ProphetKeyBindings();

    --
    -- Nature's Swiftness check
    --
    hasNaturesSwiftness, myNaturesSwiftness,
    numNaturesSwiftness, expNaturesSwiftness = btp_check_buff(
        "Nature's Swiftness", "player"
    );

    --
    -- Rejuvination check
    --
    hasRejuvenation, myRejuvenation,
    numRejuvenation, expRejuvenation = btp_check_buff(
        "Rejuvenation", "player"
    );

    --
    -- Regrowth check
    --
    hasRegrowth, myRegrowth,
    numRegrowth, expRegrowth = btp_check_buff(
        "Regrowth", "player"
    );

    if (not myRejuvenation and
        btp_cast_spell_on_target("Rejuvenation", "player")) then
        FuckBlizzardTargetUnit("playertarget");
        return true;
    elseif ((myRejuvenation or myRegrowth) and
            UnitAffectingCombat("player") and
            UnitHealth("player")/UnitHealthMax("player") <= DR_THRESH + DR_SCALAR/2 and
            UnitHealth("player") > 1 and
            btp_cast_spell_on_target("Swiftmend", playerName)) then
            FuckBlizzardTargetUnit("playertarget");
    elseif (UnitAffectingCombat("player") and
            UnitHealth("player")/UnitHealthMax("player") <= DR_THRESH and
            UnitHealth("player") > 1 and
            (btp_cast_spell_alt("Nature's Swiftness") or hasNaturesSwiftness) and
            btp_cast_spell_on_target("Healing Touch", "player")) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
    elseif (UnitAffectingCombat("player") and
            not btp_check_buff("Nature's Grasp", "player") and
            UnitHealth("player")/UnitHealthMax("player") <= (DR_THRESH + DR_SCALAR) and
            UnitHealth("player") > 1 and
            btp_cast_spell("Nature's Grasp")) then
        return true;
    end

    -- just in case I can save a party member
    druid_heal();

    return false;
end

function btp_druid_boomkin()
    -- This is the same number for tree form
    return btp_druid_istree();
end

function btp_druid_istree()
    if (GetShapeshiftForm(true) == 5) then
        return true;
    else
        return false;
    end
end

function btp_druid_isbird()
    if (GetShapeshiftForm(true) == 6) then
        return true;
    else
        return false;
    end
end

function btp_cb_druid_regrowth()
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
    elseif (cast_spell ~= "Regrowth") then
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

    --
    -- Regrowth check
    --
    hasRegrowth, myRegrowth,
    numRegrowth, expRegrowth = btp_check_buff("Regrowth", current_cb_target);

    if ((myRegrowth and
         UnitHealth(current_cb_target)/UnitHealthMax(current_cb_target) >
         DR_THRESH) or UnitHealth(current_cb_target) < 2 or
       (((cast_start_time - GetTime()) <= 1) and
        UnitHealth(current_cb_target)/UnitHealthMax(current_cb_target) >
        DR_THRESH + DR_SCALAR/2)) then
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

function btp_cb_druid_healing_touch()
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
    elseif (cast_spell ~= "Healing Touch") then
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
        DR_THRESH + DR_SCALAR/2)) then
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

function btp_cb_druid_tranquility()
    --
    -- First we get the Casting and channel information about the player
    -- and use this to make sure the player is casting something.
    --
    channel_spell, channel_rank, channel_display_name, channel_icon,
    channel_start_time, channel_end_time,
    channel_is_trade_skill = UnitChannelInfo("player");

    --
    -- Since channel works a bit different, we can clear the callback if nil.
    -- We also clear the callback if it's not the spell we expect.
    --
    if ((GetTime() - lastTranquility) <= 1) then
        return true;
    elseif (channel_spell == nil) then
        return false;
    elseif (channel_spell ~= "Tranquility") then
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

    --
    -- As it turns out, this is a great way to stop other spells from
    -- clobbering the current channel.  No timers or buff detection.
    --
    return true;
end

function btp_cb_druid_rebirth()
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
    elseif (cast_spell ~= "Rebirth") then
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

    if (UnitHealth(current_cb_target) > 1 or
       (((cast_start_time - GetTime()) <= 1) and
        not btp_check_dist(current_cb_target, 1))) then
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

