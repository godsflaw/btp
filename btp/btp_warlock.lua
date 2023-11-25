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

--
-- These are fairly well tested and should not need to be changed.
--
MANA_THRESH = .3;
HEALTH_THRESH = .45;
HEALTH_SCALAR = .3;

--
-- MAX_DEST is how many destruction spells you have to cycle through.
-- Again this count it from 0 - 2, which is a total of 3.  There may be
-- more to cycle through as bliz adds more spells.
--
MAX_DEST = 4;

--
-- BASE_SHARDS is the number of shards the code will try to maintain before
-- it uses your spells that require shards to cast (soul fire and shadow burn).
-- And NUM_SHARDS is the max amount of shards you would like to keep at any
-- one time.
BASE_SHARDS = 2;
NUM_SHARDS = 5;

--
-- WARLOCK_LAST_PET is the name of the last pet the warlock was using.
-- This variable is used as a seed to some demonology code.  Imp should
-- be fine here, but if you want to, you can make this your bestest pet. 
--
WARLOCK_LAST_PET = "Summon Imp";

--
-- WARLOCK_ARMOR should be set to the name of the spell "Demon Skin" or
-- "Demon Skin" that the warlock currently has.  I could automate this,
-- but I am lazy.
--
WARLOCK_ARMOR = "Demon Skin";

--
-- This is the default armor to use when buffing.  Since only one can
-- be used at a time you should use the /wt option to change this.
--
DEFAULT_ARMOR = "Demon Skin";

--
-- If you do not have WARLOCK_ARCANE_R, WARLOCK_FIRE_R, WARLOCK_NATURE_R,
-- WARLOCK_FROST_R, or WARLOCK_SHADOW_R rings then you sould change each of
-- these to the following.
-- WARLOCK_ARCANE_R = WARLOCK_DEF0_R;
-- WARLOCK_FIRE_R = WARLOCK_DEF0_R;
-- WARLOCK_NATURE_R = WARLOCK_DEF0_R;
-- WARLOCK_FROST_R = WARLOCK_DEF0_R;
-- WARLOCK_SHADOW_R = WARLOCK_DEF0_R;
--
-- WARLOCK_DEF0_R = "Seal of the Exorcist";
WARLOCK_DEF0_R = "Spectral Band of Innervation";
WARLOCK_DEF1_R = "Violet Signet";
WARLOCK_ARCANE_R = WARLOCK_DEF1_R;
WARLOCK_FIRE_R = WARLOCK_DEF1_R;
WARLOCK_NATURE_R = WARLOCK_DEF1_R;
WARLOCK_FROST_R = WARLOCK_DEF1_R;
WARLOCK_SHADOW_R = WARLOCK_DEF1_R;

-- WARLOCK_ARCANE_R = "Sodalite Band of Arcane Protection";
-- WARLOCK_FIRE_R = "Jasper Link of Fire Resistance";
-- WARLOCK_NATURE_R = "Jasper Link of Nature Resistance";
-- WARLOCK_FROST_R = "Jasper Link of Frost Resistance";
-- WARLOCK_SHADOW_R = "Peridot Circle of Shadow Resistance";

--
-- If you would like to turn ring switching code off you can
-- set this to true or false for a default.  false = on true = off.
-- A value of true will turn ring switching off.
--
LockRingsOff = true;

--
-- YOU CAN STOP HERE!  THERE IS NOTHING LEFT FOR YOU TO CHANGE.
--
destCount = 0;
onlyShadow = false;
onlyFire = false;

lastShadowBurn = 0;
lastDrainLife = 0;
lastDrainMana = 0;
lastDrainSoul = 0;

--
-- This is a hash for each spell, the [0] index for the second dimension
-- indicates how log the effect lasts.  The other indexes are how much
-- base damage that spell does by rank.
--
btp_dmg_array                         = { };
btp_dmg_array["Drain Soul"]           = { };
btp_dmg_array["Drain Soul"]["Rank 1"] = 55;
btp_dmg_array["Drain Soul"]["Rank 2"] = 155;
btp_dmg_array["Drain Soul"]["Rank 3"] = 295;
btp_dmg_array["Drain Soul"]["Rank 4"] = 455;
btp_dmg_array["Drain Soul"]["Rank 5"] = 620;
btp_dmg_array["Drain Soul"]["Rank 6"] = 710*4;

function btp_warlock_initialize()
    btp_frame_debug("Warlock INIT");

    SlashCmdList["WARLOKB"] = WarlockBuff;
    SlashCmdList["WARLOKP"] = WarlockPrimary;
    SlashCmdList["WARLOKI"] = WarlockInst;
    SlashCmdList["WARLOKD"] = WarlockDest;
    SlashCmdList["WARLOKS"] = WarlockShadowToggle;
    SlashCmdList["WARLOKF"] = WarlockFireToggle;
    SlashCmdList["WARLOKC"] = WarlockCC;
    SlashCmdList["WARLOKT"] = WarlockToggleArmor;
    SLASH_WARLOKB1 = "/wb";
    SLASH_WARLOKP1 = "/wp";
    SLASH_WARLOKI1 = "/wi";
    SLASH_WARLOKD1 = "/wd";
    SLASH_WARLOKS1 = "/ws";
    SLASH_WARLOKF1 = "/wf";
    SLASH_WARLOKC1 = "/wc";
    SLASH_WARLOKT1 = "/wt";

    cb_array["Immolate"]            = btp_cb_warlock_immolate;
    cb_array["Soul Fire"]           = btp_cb_warlock_soulfire;
    cb_array["Drain Life"]          = btp_cb_warlock_drainlife;
    cb_array["Drain Mana"]          = btp_cb_warlock_drainmana;
    cb_array["Drain Soul"]          = btp_cb_warlock_drainsoul;
end

function btp_cb_warlock_immolate()
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
    elseif (cast_spell ~= "Immolate") then
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
    -- Immolation check
    --
    hasImmolation, myImmolation,
    numImmolation = btp_check_debuff("Immolation", current_cb_target);

    if (myImmolation) then
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

function btp_cb_warlock_soulfire()
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
    elseif (cast_spell ~= "Soul Fire") then
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

    if (btp_check_dist(current_cb_target, 3) and
        UnitPlayerControlled(current_cb_target) and
       (cast_start_time - GetTime()) > 1.5) then
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

function btp_cb_warlock_drainlife()
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
    if ((GetTime() - lastDrainLife) <= 1) then
        return true;
    elseif (channel_spell == nil) then
        return false;
    elseif (channel_spell ~= "Drain Life") then
        --
        -- Well we are not casting our spell, so we can clear the callback.
        --
        current_cb = nil;
        return false;
    elseif (btp_has_absorb_shield(current_cb_target)) then
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

function btp_cb_warlock_drainmana()
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
    if ((GetTime() - lastDrainMana) <= 1) then
        return true;
    elseif (channel_spell == nil) then
        return false;
    elseif (channel_spell ~= "Drain Mana") then
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

function btp_cb_warlock_drainsoul()
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
    if ((GetTime() - lastDrainSoul) <= 1) then
        return true;
    elseif (channel_spell == nil) then
        return false;
    elseif (channel_spell ~= "Drain Soul") then
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

function WarlockToggleArmor()
    if (DEFAULT_ARMOR == "Fel Armor") then
        DEFAULT_ARMOR = WARLOCK_ARMOR;
        btp_frame_debug("WARLOCK -- Default armor is now " ..
                              DEFAULT_ARMOR .. ".");
    else
        DEFAULT_ARMOR = "Fel Armor";
        btp_frame_debug("WARLOCK -- Default armor is now " ..
                              DEFAULT_ARMOR .. ".");
    end
end

function WarlockCC()
    SendAddonMessage("BTP", "btpcc", "GUILD");
    btp_cc();
    return true;
end

function WarlockShadowToggle()
    if (onlyShadow) then
        onlyShadow = false;
        btp_frame_debug("WARLOCK -- Now casting fire spells again.");
    else
        onlyShadow = true;
        btp_frame_debug("WARLOCK -- Now casting only shadow spells.");
    end
end

function WarlockFireToggle()
    if (onlyFire) then
        onlyFire = false;
        btp_frame_debug("WARLOCK -- Now casting shadow spells again.");
    else
        onlyFire = true;
        btp_frame_debug("WARLOCK -- Now casting only fire spells.");
    end
end

function WarlockBuff()
    noArmor    = true;
    noSoulLink = true;
    noInvis    = true;
    noWater    = true;
    nextPlayer = "player";

    ProphetKeyBindings();
    WarlockSetPet();

    --
    -- Check player first
    --

    --
    -- Demon Skin Check
    --
    hasDemonArmor, myDemonArmor,
    numDemonArmor, expDemonArmor = btp_check_buff(DEFAULT_ARMOR, "player");

    --
    -- Soul Link Check
    --
    hasSoulLink, mySoulLink,
    numSoulLink = btp_check_buff("Soul Link", "player");

    --
    -- Phase Shift Link Check
    --
    hasPhaseShift, myPhaseShift,
    numPhaseShift = btp_check_buff("Phase Shift", "pet");

    --
    -- Fel Armor Check
    --
    hasFelArmor, myFelArmor,
    numFelArmor = btp_check_buff("Fel Armour", "player");

    --
    -- Invisibility Check
    --
    hasInvis, myInvis,
    numInvis = btp_check_buff("Detect Invisibility", "player");

    --
    -- Unending Breath Check
    --
    hasWater, myWater,
    numWater = btp_check_buff("Unending Breath", "player");

    if (hasDemonArmor or hasFelArmor) then
        noArmor = false;
    end

    if (hasSoulLink or hasPhaseShift) then
        noSoulLink = false;
    end

    if (hasInvis) then
        noInvis = false;
    end

    if (hasWater) then
        noWater = false;
    end

    if (noArmor and btp_cast_spell(DEFAULT_ARMOR)) then
        return true;
    end

    if (noSoulLink and UnitHealth("pet") > 1 and
        btp_cast_spell("Soul Link")) then
        return true;
    end

    if (noInvis and
        btp_cast_spell_on_target("Detect Invisibility", "player")) then
        return true;
    end

    if (noWater and
        btp_cast_spell_on_target("Unending Breath", "player")) then
        return true;
    end

    --
    -- Check group second
    --
    for nextPlayer in btp_iterate_group_members() do
        noWater = true;
        noInvis = true;

        if (UnitHealth(nextPlayer) >= 2 and btp_check_dist(nextPlayer, 1)) then
            --
            -- Invisibility Check
            --
            hasInvis, myInvis,
            numInvis = btp_check_buff("Detect Invisibility", nextPlayer);

            --
            -- Unending Breath Check
            --
            hasWater, myWater,
            numWater = btp_check_buff("Unending Breath", nextPlayer);

            if (hasInvis) then
                noInvis = false;
            end

            if (hasWater) then
                noWater = false;
            end

            if (noInvis and
                btp_cast_spell_on_target("Detect Invisibility", nextPlayer)) then
                return true;
            end

            if (noWater and
                btp_cast_spell_on_target("Unending Breath", nextPlayer)) then
                return true;
            end
        end
    end

   --
   -- Invisibility Check
   --
   hasInvis, myInvis,
   numInvis = btp_check_buff("Detect Invisibility", "target");

   --
   -- Unending Breath Check
   --
   hasWater, myWater,
   numWater = btp_check_buff("Unending Breath", "target");

   if (not hasInvis and UnitIsPlayer("target") and
       btp_cast_spell_on_target("Detect Detect Invisibility", "target")) then
       return true;
   end

   if (not hasWater and UnitIsPlayer("target") and
       btp_cast_spell_on_target("Unending Breath", "target")) then
       return true;
   end
end

function WarlockPrimary()
    hasMyCurse = false;
    elementsCount = 0;

    if (UnitIsPlayer("target") and btp_has_magic_immune_shield("target")) then
        return false;
    end

    for nextPlayer in btp_iterate_group_members() do
       if (btp_check_dist(nextPlayer, 1)) then
           --
           -- Shadow Form Check
           --
           hasShadowForm, myShadowForm,
           numShadowForm = btp_check_buff("Shadowform", nextPlayer);

           if (hasShadowForm) then
               elementsCount = elementsCount + 1;
           end

           if (UnitClass(nextPlayer) == "Mage") then
               elementsCount = elementsCount + 1;
           end
       end
    end

    if (elementsCount > 0) then
        elementsCount = elementsCount + 1;
    end

    --
    -- Charmed
    --    
    hasCharm, myCharm,
    numCharm = btp_check_debuff("MindSteal", "pettarget");

    --
    -- Curse of Tounges
    --    
    hasCurseTounges, myCurseTounges,
    numCurseTounges = btp_check_debuff("Curse of Tounges", "target");

    --
    -- Curse of Elements
    --    
    hasCurseElements, myCurseElements,
    numCurseElements = btp_check_debuff("Chill Touch", "target");

    --
    -- Curse of Weakness
    --    
    hasCurseWeakness, myCurseWeakness,
    numCurseWeakness, expCurseWeakness = btp_check_debuff("Curse of Weakness", "target");

    --
    -- Curse of Agony
    --    
    hasCurseAgony, myCurseAgony,
    numCurseAgony = btp_check_debuff("Curse of Agony", "target");

    --
    -- Curse of Doom
    --    
    hasCurseDoom, myCurseDoom,
    numCurseDoom = btp_check_debuff("Curse of Doom", "target");

    --
    -- Curse of Rec
    --    
    hasCurseRec, myCurseRec,
    numCurseRec = btp_check_debuff("Curse of Recklessness", "target");

    --
    -- Curse of Exaust
    --    
    hasCurseExhaust, myCurseExhaust,
    numCurseExhaust = btp_check_debuff("Curst of Exhaustion", "target");

    if (myCurseTounges or myCurseElements or myCurseWeakness or
        myCurseAgony or myCurseDoom or myCurseRec or myCurseExhaust) then
        hasMyCurse = true;
    end

    ProphetKeyBindings();
    WarlockSetPet();

    if (UnitPlayerControlled("target")) then
        if (UnitFactionGroup("player") ~= UnitFactionGroup("target") and
            UnitLevel("target") >= (UnitLevel("player") - 5) and
           ((UnitClass("target") == "Warrior") or
             DrinkPotion())) then
            --
            -- Just Move On
            --
        elseif (not hasCurseTounges and btp_can_cast("Curse of Tongues") and
               (UnitClass("target") == "Shaman")) then
            if (not hasMyCurse and
                btp_cast_spell("Curse of Tongues")) then
                FuckBlizzardAttackTarget();

                if (not myCharm) then
                    FuckBlizzardPetAttack();
                end

                return true;
            end
        elseif ((UnitClass("target") == "Warrior" or
                 UnitClass("target") == "Paladin" or
                 UnitClass("target") == "Rogue") and
                not hasCurseExhaust and
                btp_can_cast("Curse of Exhaustion")) then
            if (not hasMyCurse and
                btp_cast_spell("Curse of Exhaustion")) then

                if (UnitClass("target") ~= "Rogue") then
                    FuckBlizzardAttackTarget();
                end

                if (not myCharm) then
                    FuckBlizzardPetAttack();
                end

                return true;
            end
        else
            if (not hasMyCurse and btp_cast_spell("Curse of Agony")) then

                if (UnitClass("target") ~= "Rogue") then
                    FuckBlizzardAttackTarget();
                end

                if (not myCharm) then
                    FuckBlizzardPetAttack();
                end

                return true;
            end
        end
    else
        if (UnitHealth("target")/UnitHealthMax("target") <= .20 and
            not hasCurseRec and
            UnitClassification("target") ~= "worldboss" and
            UnitCreatureType("target") == "Humanoid" and
            btp_cast_spell("Curse of Recklessness")) then
            return true;
        else
            if (not hasMyCurse and not hasCurseElements and
                elementsCount > 2 and
                btp_cast_spell("Curse of the Elements")) then
                FuckBlizzardAttackTarget();

                if (not myCharm) then
                    FuckBlizzardPetAttack();
                end

                return true;
            elseif (not hasMyCurse and
                    not hasCurseTounges and UnitPower("target") > 0 and
                    UnitPowerType("target") == 0 and
                    btp_cast_spell("Curse of Tongues")) then
                FuckBlizzardAttackTarget();

                if (not myCharm) then
                    FuckBlizzardPetAttack();
                end

                return true;
            elseif (not hasMyCurse and (
                    UnitClassification("target") == "normal" or
                    UnitClassification("target") == "trivial" or
                    UnitClassification("target") == "minus") and 
                    btp_cast_spell("Curse of Agony")) then
                FuckBlizzardAttackTarget();

                if (not myCharm) then
                    FuckBlizzardPetAttack();
                end

                return true;
            elseif (not hasMyCurse and btp_cast_spell("Curse of Weakness")) then
                FuckBlizzardAttackTarget();

                if (not myCharm) then
                    FuckBlizzardPetAttack();
                end

                return true;
            end
        end
    end

    return false;
end

function WarlockInst()
    if (UnitIsPlayer("target") and btp_has_magic_immune_shield("target")) then
        return false;
    end

    --
    -- Corruption Debuff check
    --
    hasCorruptionDebuff, myCorruptionDebuff,
    numCorruptionDebuff = btp_check_debuff("Corruption", "target");

    if (not myCorruptionDebuff and
        btp_cast_spell("Corruption")) then
        return true;
    end

    return false;
end

function WarlockDest()
    normal_cast = false;
    pet_cast = true;
    shardCount = 0;
    spellLock = false;
    hasInfernalStone = false;
    nextPlayer = "player";
    castConflag = false;

    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    if (UnitLevel("player") > 59) then
        LOWEST_SHARD = math_round((.20 * UnitLevel("player"))) - 4;
        MEDIUM_SHARD = math_round(LOWEST_SHARD/2);
    else
        LOWEST_SHARD = math_round((.20 * UnitLevel("player")));
        MEDIUM_SHARD = math_round(LOWEST_SHARD/2);
    end

    RequestBattlefieldScoreData();

    for bag=0,4 do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot)) then
          if (string.find(C_Container.GetContainerItemLink(bag,slot), "Soul Shard")) then
              shardCount = shardCount + 1;
          end

          if (string.find(C_Container.GetContainerItemLink(bag,slot),
                          "Infernal Stone")) then
              hasInfernalStone = true;
          end
        end
      end
    end

    --
    -- check buffs
    --

       --
    -- Soul Link Check
    --
    hasSoulLink, mySoulLink,
    numSoulLink = btp_check_buff("Soul Link", "player");

    --
    -- Phase Shift Link Check
    --
    hasPhaseShift, myPhaseShift,
    numPhaseShift = btp_check_buff("Phase Shift", "pet");

    -- Fel Domination check
    hasFelDomination, myFelDomination,
    numFelDomination = btp_check_buff("Fel Domination", "player");

    -- Nightfall check
    hasNightfall, myNightfall,
    numNightfall = btp_check_buff("Nightfall", "player");

    -- Demonic Sacrifice Check
    hasDemonicSacrifice, myDemonicSacrifice,
    numDemonicSacrifice = btp_check_buff("Demonic Sacrifice", "player");

    --
    -- check target debuffs
    --

    -- Immolation check
    hasImmolation, myImmolation,
    numImmolation = btp_check_debuff("Immolate", "target");

    if (hasSoulLink or hasPhaseShift) then
        noSoulLink = false;
    end

    ProphetKeyBindings();
    WarlockSetPet();

    if (btp_free_action()) then
        return true;
    end

    --
    -- Pet Code
    --
    if (UnitHealth("pet") > 1 and
        (btp_is_casting("target") or btp_is_channeling("target")) and
        not (UnitIsPlayer("target") and btp_has_immune_shield("target")) and
        btp_cast_spell_alt("Spell Lock")) then
        spellLock = true;
        pet_cast = true;
    elseif (UnitHealth("player")/UnitHealthMax("player") <= HEALTH_THRESH/2 and
            UnitHealth("pet") > 1 and btp_cast_spell_alt("Sacrifice")) then
        pet_cast = true;
    end

    --
    -- short circuit if the target is immune
    --
    if (UnitIsPlayer("target") and btp_has_immune_shield("target")) then
        if (SelfHeal(HEALTH_THRESH, MANA_THRESH/5)) then
            --
            -- healing self with healthstones, potions, etc
            --
            return true;
        end

        return false;
    end

    --
    -- Warlock Code
    --
    if (not onlyFire and not btp_has_magic_absorb_shield("target") and
        UnitHealth("player")/UnitHealthMax("player") <= HEALTH_THRESH and
        btp_cast_spell("Death Coil")) then
        return true;
    elseif (SelfHeal(HEALTH_THRESH, MANA_THRESH/5)) then
        --
        -- healing self with healthstones, potions, etc
        --
        return true;
    elseif (not onlyShadow and myImmolation and (castConflag or
           (UnitHealth("target")/UnitHealthMax("target") < .25 and
            UnitPlayerControlled("target"))) and
            btp_cast_spell("Conflagrate")) then
        return true;
    elseif (not onlyFire and hasNightfall and
            btp_cast_spell("Shadow Bolt")) then
        return true;
    elseif (not onlyFire and not spellLock and 
            not btp_has_magic_absorb_shield("target") and
            UnitHealth("player") < UnitHealthMax("player") and
           (btp_is_casting("target") or btp_is_channeling("target")) and
            UnitPlayerControlled("target") and 
            btp_cast_spell_alt("Death Coil")) then
        return true;
    elseif (not onlyFire and UnitHealth("player") < UnitHealthMax("player") and
            not btp_has_magic_absorb_shield("target") and
            btp_check_dist("target", 3) and
           (UnitClass("target") == "Warrior" or
            UnitClass("target") == "Rogue" or
            UnitClass("target") == "Druid" or
            UnitClass("target") == "Paladin") and
            UnitPlayerControlled("target") and 
           btp_cast_spell("Death Coil")) then
        return true;
    elseif ((not PetHasActionBar() or UnitHealth("pet") < 2) and
            hasFelDomination and not hasDemonicSacrifice and
            shardCount > 0 and btp_cast_spell(WARLOCK_LAST_PET)) then
        return true;
    elseif (not onlyFire and shardCount < NUM_SHARDS and
            not UnitIsTrivial("target") and
            UnitHealth("target") <= btp_spell_damage("Drain Soul") and
            UnitHealth("target")/UnitHealthMax("target") < .25 and
            UnitFactionGroup("player") ~= UnitFactionGroup("target") and
            btp_cast_spell("Drain Soul")) then
        lastDrainSoul = GetTime();
        return true;
    elseif (noSoulLink and UnitHealth("pet") > 1 and
            btp_cast_spell_on_target("Soul Link", "player")) then
        return true;
    elseif ((not PetHasActionBar() or UnitHealth("pet") < 2) and
            not hasDemonicSacrifice and
            btp_cast_spell("Fel Domination")) then
        return true;
    elseif (not hasDemonicSacrifice and UnitHealth("pet") > 1 and
            UnitHealth("pet")/UnitHealthMax("pet") < HEALTH_THRESH/3 and
            not hasDemonicSacrifice and
            btp_cast_spell("Demonic Sacrifice")) then
        return true;
    elseif (not onlyShadow and not onlyFire and btp_check_dist("target", 3) and
            btp_cast_spell("Shadowflame")) then
        return true;
    elseif (not onlyFire and not btp_has_magic_absorb_shield("target") and
            UnitHealth("player")/UnitHealthMax("player") <= HEALTH_THRESH and
            btp_cast_spell("Drain Life")) then
        lastDrainLife = GetTime();
        return true;
    elseif ((not PetHasActionBar() or UnitHealth("pet") < 2) and
            IsActiveBattlefieldArena() == nil and
            hasInfernalStone and not pvpBot and
            not hasDemonicSacrifice and
            btp_cast_spell("Inferno")) then
        return true;
    elseif (not onlyShadow and not myImmolation and
            btp_cast_spell("Immolate")) then
        return true;
    elseif (not onlyShadow and hasBackdraft and numBackdraft < 3 and
           ((shardCount > BASE_SHARDS and not UnitIsTrivial("target")) or
           (UnitPlayerControlled("target") and
            not btp_check_dist("target", 3))) and
            btp_cast_spell("Soul Fire")) then
        return true;
    elseif (not onlyShadow and ((hasBackdraft and numBackdraft < 2) or
            hasMoltenCore or hasEmpoweredImp or
           (hasFireWeak and (numFireWeak > 4))) and myImmolation and
            btp_cast_spell("Incinerate")) then
        return true;
    elseif (not onlyFire and ((hasBackdraft and numBackdraft < 1) or
            hasEmpoweredImp or hasShadowWeak or
           (hasBlackPlague and (numBlackPlague > 4))) and
            btp_cast_spell("Shadow Bolt")) then
        return true;
    elseif (not onlyShadow and (hasMoltenCore or hasEmpoweredImp or
           (hasBackdraft and numBackdraft < 1) or
           (hasFireWeak and (numFireWeak > 4))) and
           ((btp_can_cast("Soulshatter") and
            not UnitPlayerControlled("target")) or
            UnitPlayerControlled("target")) and
            btp_cast_spell("Searing Pain")) then
        return true;
    else
        if (destCount == 0 and not onlyShadow and
            btp_check_dist("target", 4) and not btp_check_dist("target", 3) and
           (shardCount > BASE_SHARDS) and not UnitPlayerControlled("target") and
            btp_cast_spell("Soul Fire")) then
            normal_cast = true;
        elseif (destCount == 1 and not UnitPlayerControlled("target") and
                not onlyFire and btp_cast_spell("Shadow Bolt")) then
            normal_cast = true;
        elseif (destCount == 2 and not onlyShadow and myImmolation and
                not UnitPlayerControlled("target") and
                btp_cast_spell("Incinerate")) then
            normal_cast = true;
        elseif (destCount == 3 and not onlyFire and not hasEradication and
                WarlockPrimary()) then
            normal_cast = true;
        elseif (destCount == 4 and not onlyFire and not hasEradication and
                WarlockInst()) then
            normal_cast = true;
        elseif (not onlyShadow and ((btp_can_cast("Soulshatter") and
                not UnitPlayerControlled("target")) or
                UnitPlayerControlled("target")) and
                btp_cast_spell("Searing Pain")) then
            normal_cast = true;
        elseif (not onlyShadow and myImmolation and
                not UnitPlayerControlled("target") and
                btp_cast_spell("Incinerate")) then
            normal_cast = true;
        elseif (not onlyFire and not UnitPlayerControlled("target") and
                btp_cast_spell("Shadow Bolt")) then
            normal_cast = true;
        elseif (not onlyFire and btp_cast_spell("Shadow Bolt")) then
            normal_cast = true;
        elseif (UnitHealth("pet") > 1 and UnitPower("pet") > 500 and
                btp_cast_spell("Dark Pact")) then
            normal_cast = true;
        elseif (UnitHealth("player")/UnitHealthMax("player") > HEALTH_THRESH and
                btp_cast_spell("Life Tap")) then
            normal_cast = true;
        elseif (not onlyFire and UnitPowerType("target") == 0 and
                UnitPower("target") > 500 and btp_cast_spell("Drain Mana")) then
            lastDrainMana = GetTime();
            normal_cast = true;
        elseif (UnitHealth("player")/UnitHealthMax("player") < HEALTH_THRESH and
                UnitPower("player")/UnitPowerMax("player") < MANA_THRESH/5) then

            if (btp_cast_spell("Shoot")) then
                normal_cast = true;
            end
        end

        if (destCount >= MAX_DEST) then
            destCount = 0;
        else
            destCount = destCount + 1;
        end
    end

    if (pet_cast or normal_cast) then
        return true;
    else
        return false;
    end
end

--
-- return true or false if the given pet is the warlock's current pet.
--
function WarlockPet(pet)
    if (pet == "Imp" and UnitHealth("pet") > 2 and
        btp_spell_known("Firebolt")) then
        WARLOCK_LAST_PET = "Summon Imp";
        return true;
    elseif (pet == "Voidwalker" and UnitHealth("pet") > 2 and
            btp_spell_known("Torment")) then
        WARLOCK_LAST_PET = "Summon Voidwalker";
        return true;
    elseif (pet == "Succubus" and UnitHealth("pet") > 2 and
            btp_spell_known("Lash of Pain")) then
        WARLOCK_LAST_PET = "Summon Succubus";
        return true;
    elseif (pet == "Felhunter" and UnitHealth("pet") > 2 and
            btp_spell_known("Shadow Bite")) then
        WARLOCK_LAST_PET = "Summon Felhunter";
        return true;
    elseif (pet == "Felguard" and UnitHealth("pet") > 2 and
            btp_spell_known("Anguish")) then
        WARLOCK_LAST_PET = "Summon Felguard";
        return true;
    end

    return false;
end


function WarlockSetPet()
    WarlockPet("Imp");
    WarlockPet("Voidwalker");
    WarlockPet("Succubus");
    WarlockPet("Felhunter");
    WarlockPet("Felguard");
end
