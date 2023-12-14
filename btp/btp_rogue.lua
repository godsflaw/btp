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

ROGUE_THRESH=.45;

function btp_rogue_initialize()
    btp_frame_debug("Rogue INIT");

    SlashCmdList["ROGUEH"] = rogue_heal;
    SLASH_ROGUEH1 = "/rh";
    SlashCmdList["ROGUER"] = rogue_roach;
    SLASH_ROGUER1 = "/rr";
    SlashCmdList["ROGUED"] = rogue_dps;
    SLASH_ROGUED1 = "/rd";
end

function rogue_heal()
    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    ProphetKeyBindings();

    hasBandage, bandageBag, bandageSlot = btp_get_item("Bandage");

    playerHealthRatio =  UnitHealth("player")/UnitHealthMax("player");

    --
    -- Bandage Debuff check
    --
    hasBandageDebuff, myBandageDebuff,
    numBandageDebuff = btp_check_debuff("Recently Bandaged", "player");

    if (SelfHeal(ROGUE_THRESH, 0)) then
        --
        -- doing a self heal here (heathstones, potions, etc)
        --
        return true;
    elseif (not UnitAffectingCombat("player") and
            hasBandage and not hasBandageDebuff and
            playerHealthRatio < ROGUE_THRESH) then
            lastBandage = GetTime();
            FuckBlizzardTargetUnitContainer("player");
            FuckBlizUseContainerItem(bandageBag, bandageSlot);
            return true;
    end
end

function rogue_roach()
    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    ProphetKeyBindings();

    if (btp_free_action()) then
        return true;
    end

    hasDummy, dummyBag, dummySlot = btp_get_item("Target Dummy");
    hasSwift, swiftBag, swiftSlot = btp_get_item("Swiftness Potion");

    playerHealthRatio =  UnitHealth("player")/UnitHealthMax("player");

    -- Sprint
    hasSprint, mySprint, numSprint, expSprint = btp_check_buff(
        "Sprint",
        "player"
    );

    if (rogue_heal()) then
        --
        -- doing a self heal here (heathstones, potions, etc)
        --
        return true;
    elseif (btp_cast_spell("Sprint")) then
        return true;
    elseif (playerHealthRatio <= .75 and btp_cast_spell("Evasion")) then
        return true;
    elseif (UnitAffectingCombat("player") and btp_cast_spell("Gouge")) then
        return true;
    elseif (not UnitAffectingCombat("player") and btp_cast_spell("Stealth")) then
        return true;
    elseif (UnitAffectingCombat("player") and not hasSprint and hasSwift) then
        FuckBlizUseContainerItem(swiftBag, swiftSlot);
        return true;
    elseif (UnitAffectingCombat("player") and hasDummy) then
        FuckBlizUseContainerItem(dummyBag, dummySlot);
        return true;
    end
end

function rogue_dps()
    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    ProphetKeyBindings();

    if (btp_free_action()) then
        return true;
    end

    --
    -- buff checks
    --

    --
    -- Slice and Dice
    --
    hasSlice, mySlice, numSlice, expSlice = btp_check_buff(
        "Slice and Dice",
        "player"
    );


    --
    -- debuff checks
    --

    --
    -- Expose Armor
    --
    hasExpose, myExpose, numExpose, expExpose = btp_check_debuff(
        "Expose Armor",
        "target"
    );

    comboPoints = GetComboPoints("player", "target");
    playerHealthRatio =  UnitHealth("player")/UnitHealthMax("player");
    targetHealthRatio =  UnitHealth("target")/UnitHealthMax("target");

    if (SelfHeal(ROGUE_THRESH, 0)) then
        --
        -- doing a self heal here (heathstones, potions, etc)
        --
        return true;
    elseif ((btp_is_casting("target") or btp_is_channeling("target")) and
            btp_cast_spell("Kick")) then
        return true;
    elseif ((btp_is_casting("target") or btp_is_channeling("target")) and
            btp_cast_spell("Gouge")) then
        return true;
    elseif (btp_check_dist("target", 3) and
            UnitThreatSituation("player", "target") ~= nil and
            UnitThreatSituation("player", "target") > 0 and
            btp_cast_spell("Feint")) then
        return true;
    elseif (playerHealthRatio <= .75 and btp_cast_spell("Evasion")) then
        return true;
    elseif (playerHealthRatio > .80 and btp_cast_spell("Blood Fury")) then
        return true;
    elseif (playerHealthRatio < .70 and btp_cast_spell("Berserking")) then
        return true;
    elseif (IsStealthed() and 
           (UnitClassification("target") == "normal" or
            UnitClassification("target") == "trivial" or
            UnitClassification("target") == "minus" or
            UnitCreatureType("target") == "Elemental") and
            btp_cast_spell("Backstab")) then
        return true;
    elseif (IsStealthed() and
            btp_cast_spell("Garrote")) then
        return true;
    elseif (comboPoints > 4 and btp_cast_spell("Eviscerate")) then
        return true;
    elseif (comboPoints == 5 and targetHealthRatio < .30 and
            btp_cast_spell("Eviscerate")) then
        return true;
    elseif (comboPoints == 4 and targetHealthRatio < .25 and
            btp_cast_spell("Eviscerate")) then
        return true;
    elseif (comboPoints == 3 and targetHealthRatio < .20 and
            btp_cast_spell("Eviscerate")) then
        return true;
    elseif (comboPoints == 2 and targetHealthRatio < .15 and
            btp_cast_spell("Eviscerate")) then
        return true;
    elseif (comboPoints == 1 and targetHealthRatio < .10 and
            btp_cast_spell("Eviscerate")) then
        return true;
    elseif (comboPoints > 0 and not hasSlice and
            btp_cast_spell("Slice and Dice")) then
        return true;
    elseif (comboPoints > 0 and not myExpose and
            btp_cast_spell("Expose Armor")) then
        return true;
    elseif (comboPoints < 5 and UnitPower("player", T_ENERGY) > 50 and
            btp_cast_spell("Sinister Strike")) then
        return true;
    end

    return true;
end
