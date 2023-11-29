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

WARRIOR_THRESH   = .30;
W_RAGE_RETENTION = 0 + 5;

-- stance types
S_BATTLE  = 1;
S_DEFENSE = 2;
S_BESERK  = 3;

function btp_warrior_initialize()
    btp_frame_debug("warrior INIT");

    SlashCmdList["WARRIORH"] = warrior_heal;
    SLASH_WARRIORH1 = "/warriorheal";
    SlashCmdList["WARRIORR"] = warrior_roach;
    SLASH_WARRIORR1 = "/warriorroach";
    SlashCmdList["WARRIORD"] = warrior_dps;
    SLASH_WARRIORD1 = "/warriordps";
end

function warrior_heal()
    if (current_cb ~= nil and current_cb()) then
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

    --
    -- Bandage Debuff check
    --
    hasBandageDebuff, myBandageDebuff,
    numBandageDebuff, expBanadageDebuff = btp_check_debuff("Recently Bandaged", "player");

    playerHealthRatio =  UnitHealth("player")/UnitHealthMax("player");

    if (SelfHeal(WARRIOR_THRESH, 0)) then
        --
        -- doing a self heal here (heathstones, potions, etc)
        --
        return true;
    elseif (not UnitAffectingCombat("player") and
            playerHealthRatio < WARRIOR_THRESH and
            hasBandage and not hasBandageDebuff) then
            FuckBlizzardTargetUnitContainer("player");
            FuckBlizUseContainerItem(bandageBag, bandageSlot);
        return true;
    end
end

function warrior_roach()
    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    ProphetKeyBindings();

    -- get the stance
    stance = GetShapeshiftForm();

    -- Hamstring
    hasHamstring, myHamstring, numHamstring, expHamstring = btp_check_debuff(
        "Hamstring",
        "target"
    );

    playerHealthRatio =  UnitHealth("player")/UnitHealthMax("player");

    warrior_heal();

    --
    -- instant actions (these don't have a GCD)
    --
    if (UnitAffectingCombat("player") and stance ~= S_BATTLE and
        btp_cast_spell_alt("Battle Stance")) then
        -- for hamstring and other abilities while running
    end

    -- primary actions
    if (not hasHamstring and btp_cast_spell("Hamstring")) then
        return true;
    end
end

function warrior_dps()
    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    ProphetKeyBindings();

    -- get the stance
    stance = GetShapeshiftForm();

    --
    -- buffs
    --

    -- Battle Shout
    hasBattleShout, myBattleShout, numBattleShout, expBattleShout = btp_check_buff(
        "Battle Shout",
        "player"
    );

    --
    -- debuffs
    --

    -- Demoralizing Shout
    hasDemoShout, myDemoShout, numDemoShout, expDemoShout = btp_check_debuff(
        "Demoralizing Shout",
        "target"
    );

    -- Rend
    hasRend, myRend, numRend, expRend = btp_check_debuff(
        "Rend",
        "target"
    );

    -- Thunder Clap
    hasClap, myClap, numClap, expClap = btp_check_debuff(
        "Thunder Clap",
        "target"
    );

    -- Hamstring
    hasHamstring, myHamstring, numHamstring, expHamstring = btp_check_debuff(
        "Hamstring",
        "target"
    );

    -- Sunder Armor
    hasSunder, mySunder, numSunder, expSunder = btp_check_debuff(
        "Sunder Armor",
        "target"
    );

    playerHealthRatio =  UnitHealth("player")/UnitHealthMax("player");
    targetHealthRatio =  UnitHealth("target")/UnitHealthMax("target");

    rage = UnitPower("player", T_RAGE);

    --
    -- instant actions (these don't have a GCD)
    --
    warrior_heal();

    if (UnitAffectingCombat("player") and rage < 25 and
        playerHealthRatio > .50 and btp_cast_spell_alt("Bloodrage")) then
        -- pop bloodrage
    elseif (UnitAffectingCombat("player") and stance ~= S_BATTLE and
            rage < W_RAGE_RETENTION and playerHealthRatio > .50 and
            targetHealthRatio <= .20 and
            btp_cast_spell_alt("Battle Stance")) then
        -- swap stances for hamstring, execute, thunder clap, and overpower
    elseif (UnitAffectingCombat("player") and stance ~= S_DEFENSE and
            rage < W_RAGE_RETENTION and targetHealthRatio > .20 and
            btp_cast_spell_alt("Defensive Stance")) then
        -- swap stances taunting and tanking
    elseif (not UnitAffectingCombat("player") and stance ~= S_BATTLE and
            rage < W_RAGE_RETENTION and
            btp_cast_spell_alt("Battle Stance")) then
        -- swap stances out of combat for charge
    end

    if (SelfHeal(WARRIOR_THRESH, 0)) then
        return true;
    elseif ((btp_is_casting("target") or btp_is_channeling("target")) and
            btp_check_dist("target", 3) and btp_cast_spell("Shield Bash")) then
        return true;
    elseif (targetHealthRatio < .20 and btp_check_dist("target", 3) and
            btp_cast_spell("Execute")) then
        return true;
    elseif (btp_check_dist("target", 3) and
            UnitThreatSituation("player", "target") ~= nil and
            UnitThreatSituation("player", "target") < 3 and
            btp_cast_spell("Taunt")) then
        return true;
    elseif (btp_check_dist("target", 3) and
            UnitThreatSituation("player", "target") ~= nil and
            UnitThreatSituation("player", "target") < 3 and
            btp_cast_spell("Mocking Blow")) then
        return true;
    elseif (not mySunder and numSunder < 1 and btp_check_dist("target", 3) and
            btp_cast_spell("Sunder Armor")) then
        return true;
    elseif (playerHealthRatio < .60 and
            btp_cast_spell("Retaliation")) then
        return true;
    elseif (playerHealthRatio < .80 and
            btp_cast_spell("Shield Block")) then
        return true;
    elseif (btp_check_dist("target", 3) and
            btp_cast_spell("Shield Slam")) then
        return true;
    elseif (btp_check_dist("target", 3) and
            btp_cast_spell("Disarm")) then
        return true;
    elseif (btp_check_dist("target", 3) and
            btp_cast_spell("Bloodthirst")) then
        return true;
    elseif (btp_check_dist("target", 3) and
            btp_cast_spell("Revenge")) then
        return true;
    elseif (targetHealthRatio < .20 and not hasHamstring and
            btp_check_dist("target", 3) and btp_cast_spell("Hamstring")) then
        return true;
    elseif (not hasDemoShout and
            btp_cast_spell("Demoralizing Shout")) then
        return true;
    elseif (not hasBattleShout and
            btp_cast_spell("Battle Shout")) then
        return true;
    elseif (not myClap and btp_check_dist("target", 3) and
            btp_cast_spell("Thunder Clap")) then
        return true;
    elseif (rage > 15 and not myRend and btp_check_dist("target", 3) and
            UnitCreatureType("target") ~= "Elemental" and
            btp_cast_spell("Rend")) then
        return true;
    elseif (btp_check_dist("target", 3) and
            btp_cast_spell("Overpower")) then
        return true;
    elseif (mySunder and numSunder < 5 and btp_check_dist("target", 3) and
            btp_cast_spell("Sunder Armor")) then
        return true;
    elseif (rage > 70 and btp_check_dist("target", 3) and
            btp_cast_spell("Heroic Strike")) then
        return true;
    elseif (not UnitAffectingCombat("player") and
            btp_cast_spell("Charge")) then
        return true;
    end

    return true;
end