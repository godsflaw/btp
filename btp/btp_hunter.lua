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

lastHunterPetFollow = 0;
lastHunterPetFeed = 0;
lastHunterMendPet = 0;
lastHunterTrap = 0;

function btp_hunter_initialize()
    btp_frame_debug("Hunter INIT");

	SlashCmdList["HUNTERBOW"] = btp_hunter_bow;
	SLASH_HUNTERBOW1 = "/hb";
	SlashCmdList["HUNTERMELE"] = btp_hunter_mele;
	SLASH_HUNTERMELE1 = "/hm";
	SlashCmdList["HUNTERBOT"] = btp_hunter_bot;
	SLASH_HUNTERBOT1 = "/hbot";
end

function btp_hunter_bot()
	ProphetKeyBindings();

	if((UnitHealth("pet")/UnitHealthMax("pet")) <= .6 and
		((GetTime() - lastHunterMendPet) >= 5)) then
		if(btp_cast_spell("Mend Pet")) then 
				lastHunterMendPet = GetTime();
				return true; 
		end
	end
	if ((GetTime() - lastHunterPetFollow) >= 8) then
		-- btp_frame_debug("PetFollow");
		lastHunterPetFollow = GetTime();
	    btp_frame_set_color_hex("IT", "787878");
		return;
	end

	local happiness, damagePercentage, loyaltyRate = GetPetHappiness()
	if(((GetTime() - lastHunterPetFeed) >= 30) and happiness ~= 3) then
		-- btp_frame_debug("Feeding Pet");
		lastHunterPetFeed = GetTime();
		btp_frame_set_color_hex("IT", "565656");
		return;
	end

	if(UnitAffectingCombat("player") or UnitAffectingCombat("pet")) then
		if(btp_cast_spell("Explosive Trap")) then return true; end
		if(btp_cast_spell("Bestial Wrath")) then return true; end
		if(btp_cast_spell("Intimidation")) then return true; end
	end
end

function btp_hunter_bow()
	ProphetKeyBindings();

	btp_hunter_pet_attack()

	if(btp_cast_spell("Frost Trap")) then return true; end

	if(not btp_hunter_marked()) then
		btp_cast_spell("Hunter's Mark");
	end


	if(btp_check_dist("target", 3)) then
		if(not btp_is_slowed()) then
			if(btp_cast_spell("Wing Clip")) then return true; end
		end
		if(btp_cast_spell("Raptor Strike")) then return true; end
		if(btp_cast_spell("Mongoose Bite")) then return true; end

		if(not btp_hunter_monkey()) then 
			btp_cast_spell("Aspect of the Monkey");
		end


	else

	if(not btp_is_slowed()) then
		btp_cast_spell("Concussive Shot")
	end

	if(not btp_hunter_scorpid()) then
		if( not btp_hunter_viper() and not
			btp_hunter_serpent() and
			(UnitPower("target") > 10)) then
			if(btp_cast_spell("Viper Sting")) then return true; end
		elseif(not btp_hunter_serpent() and not
			btp_hunter_viper()) then
			if(btp_cast_spell("Serpent Sting")) then return true; end
		end
	end

	if(not btp_hunter_hawk()) then 
		btp_cast_spell("Aspect of the Hawk");
	end

	if(btp_cast_spell("Arcane Shot")) then return true; end
	if(btp_cast_spell("Rapid Fire")) then return true; end

	if(btp_cast_spell("Bestial Wrath")) then return true; end
	if(btp_cast_spell("Intimidation")) then return true; end
	end

	return false;
end

function btp_hunter_mele()
	if(btp_check_dist("target", 3)) then
		-- btp_frame_debug("Interact");
	end
end

function btp_hunter_pet_attack()
	if(not btp_is_cc()) then
		FuckBlizzardPetAttack();
		return true;
	end
	return false;
end

function btp_hunter_marked()
	return btp_check_debuf("Sniper");
end

function btp_hunter_hawk()
	if(btp_check_player_buff("RavenForm")) then
		-- btp_frame_debug("Hawk Active");
		return true
	end
	return false
end

function btp_hunter_monkey()
	if(btp_check_player_buff("Monkey")) then return true; end
	return false
end

function btp_hunter_scorpid(unit)
	return btp_check_debuff("Ability_Hunter_CriticalShot");
end

function btp_hunter_viper(unit)
	return btp_check_debuff("Ability_Hunter_AimedShot");
end

function btp_hunter_serpent(unit)
	return btp_check_debuff("Ability_Hunter_Quickshot");
end

function btp_hunter_marked(unit)
	return btp_check_debuff("Sniper");
end
