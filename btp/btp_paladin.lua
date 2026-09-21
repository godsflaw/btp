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
PALADIN_MANA_THRESH = .3;
PALADIN_HEALTH_THRESH = .3;
PALADIN_PULL_SPELL = "Avenger's Shield";
PALADIN_GRIND = false;

-- Events
function btp_mage_bot_OnEvent(this, event, arg1, arg2, arg3, arg4, ...)
	if event=="TRADE_SHOW" then
		-- btp_frame_debug("TRADE_SHOW");
		btp_test();
	elseif(event == "TRADE_REQUEST") then
		-- btp_frame_debug("TRADE_REQUEST " .. arg1);
	elseif(event == "CHAT_MSG_WHISPER") then
		if(not dontBeg) then
			btp_mage_waterbreak_start(arg1, arg2, arg3, arg4, arg5, arg6)
		end
	elseif(event == "TRADE_CLOSED") then
		WATERBREAK_USER = "";
	end
end

local frame = CreateFrame("Frame", "btp_mage_bot_Frame");
frame:SetScript("OnEvent", btp_mage_bot_OnEvent);
frame:RegisterEvent("TRADE_SHOW");
frame:RegisterEvent("TRADE_REQUEST");
frame:RegisterEvent("TRADE_CLOSED");
frame:RegisterEvent("CHAT_MSG_WHISPER");


function btp_paladin_initialize()
	btp_frame_debug("Paladin INIT");

	SlashCmdList["PALDPS"] = btp_pal_dps;
	SLASH_PALDPS1 = "/paldps";
	SlashCmdList["PALRET"] = btp_pal_ret;
	SLASH_PALRET1 = "/palret";

	SlashCmdList["PALTANK"] = function()
		btp_pal_tank_new(false);
	end
	SLASH_PALTANK1 = "/pt";

	SlashCmdList["PALTANKAOE"] = function()
		btp_pal_tank_new(true);
	end

	SLASH_PALTANKAOE1 = "/ptaoe";

	SlashCmdList["PALHEAL"] = btp_pal_heal;
	SLASH_PALHEAL1 = "/palheal";
	SlashCmdList["PALSHIELD"] = btp_pal_shield;
	SLASH_PALSHIELD1 = "/palshield";
	SlashCmdList["PALBUF"] = btp_pal_buf;
	SLASH_PALBUF1 = "/palbuf";
	SlashCmdList["BTPTEST"] = btp_test;
	SLASH_BTPTEST1 = "/btptest";
	SLASH_BTPCMD1 = "/btpcmd";
	SlashCmdList["BTPCMD"] = function(cmdstr)
		--btp_frame_debug("cmdstr: " .. cmdstr);
		btp_cmd(cmdstr);
	end

	SLASH_MAGEDPS1 = "/mdps";
	SlashCmdList["MAGEDPS"] = btp_mage_dps;


 	btp_init_spells();
	-- setup paladin configs
	btp_pal_config_init()
end



BTP_PAL_THRESH_CRIT=.35
BTP_PAL_THRESH_LARGE=.48
BTP_PAL_THRESH_MEDIUM=.80
BTP_PAL_THRESH_SMALL=.90
BTP_PAL_THRESH_SHIELD = .30;

-- The defined types for config structures
TYPE_PERCENT = 1;
TYPE_INT = 2;
TYPS_STRING = 3;
TYPS_BOOL = 4;

CONFIG_PALADIN = { };
CONFIG_THRESH = { };
CONFIG_SPELLS = { };
CONFIG_CMDS = { };
CONFIG = { };


--
-- Our addon/slash commands
--
CONFIG_CMDS["GENRAL"] = { };
CONFIG_CMDS["GENRAL"]["spell_toggle"] = { };
CONFIG_CMDS["GENRAL"]["spell_toggle"]["HELP"] = "Toggles the usage of a spell";
CONFIG_CMDS["GENRAL"]["spell_cast"] = { };
CONFIG_CMDS["GENRAL"]["spell_cast"]["HELP"] = "Cast a spell";
CONFIG_CMDS["GENRAL"]["set_thresh"] = { };
CONFIG_CMDS["GENRAL"]["set_thresh"]["HELP"] = "Set a threshold";
CONFIG_CMDS["GENRAL"]["set_opt"] = { };
CONFIG_CMDS["GENRAL"]["set_opt"]["HELP"] = "Set a threshold";

CONFIG_CMDS["GENRAL"]["frame_test"] = { };
CONFIG_CMDS["GENRAL"]["frame_test"]["HELP"] = "TESTING";

CONFIG_CMDS["GENRAL"]["cast_spell"] = { };
CONFIG_CMDS["GENRAL"]["cast_spell"]["HELP"] = "TESTING";
-- Store our Paladin thresholds
CONFIG_THRESH_PAL = { };
CONFIG_THRESH_PAL["SMALL"] = { };
CONFIG_THRESH_PAL["SMALL"]["VAL"] = .94;
CONFIG_THRESH_PAL["SMALL"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["SMALL"]["DESC"] = "Small heal threshold";
CONFIG_THRESH_PAL["MEDIUM"] = { };
CONFIG_THRESH_PAL["MEDIUM"]["VAL"] = .80;
CONFIG_THRESH_PAL["MEDIUM"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["MEDIUM"]["DESC"] = "Medium heal threshold";
CONFIG_THRESH_PAL["LARGE"] = { };
CONFIG_THRESH_PAL["LARGE"]["VAL"] = .62;
CONFIG_THRESH_PAL["LARGE"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["LARGE"]["DESC"] = "Small heal threshold";
CONFIG_THRESH_PAL["CRIT"] = { };
CONFIG_THRESH_PAL["CRIT"]["VAL"] = .23;
CONFIG_THRESH_PAL["CRIT"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["CRIT"]["DESC"] = "Small heal threshold";
CONFIG_THRESH_PAL["SHIELD"] = { };
CONFIG_THRESH_PAL["SHIELD"]["VAL"] = .29;
CONFIG_THRESH_PAL["SHIELD"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["SHIELD"]["DESC"] = "Shield threshold";
CONFIG_THRESH_PAL["MANALOW"] = { };
CONFIG_THRESH_PAL["MANALOW"]["VAL"] = .29;
CONFIG_THRESH_PAL["MANALOW"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["MANALOW"]["DESC"] = "When mana is low";
CONFIG_THRESH_PAL["MANABUFF"] = { };
CONFIG_THRESH_PAL["MANABUFF"]["VAL"] = .50;
CONFIG_THRESH_PAL["MANABUFF"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["MANABUFF"]["DESC"] = "Will not buff if mana is bellow";
CONFIG_THRESH_PAL["MANAPOTION"] = { };
CONFIG_THRESH_PAL["MANAPOTION"]["VAL"] = .29;
CONFIG_THRESH_PAL["MANAPOTION"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["MANAPOTION"]["DESC"] = "When to drink a mana pot";
CONFIG_THRESH_PAL["HEALTHPOTION"] = { };
CONFIG_THRESH_PAL["HEALTHPOTION"]["VAL"] = .29;
CONFIG_THRESH_PAL["HEALTHPOTION"]["TYPE"] = TYPE_PERCENT;
CONFIG_THRESH_PAL["HEALTHPOTION"]["DESC"] = "When to drink a health pot/stone";


function btp_thresh_update()

	if(not CONFIG["THRESH"] or CONFIG["THRESH"] ~= nil) then
		btp_frame_debug("Paladin Thresholds not set");
	end

	BTP_PAL_THRESH_CRIT=    CONFIG["THRESH"]["CRIT"];
	BTP_PAL_THRESH_LARGE=   CONFIG["THRESH"]["LARGE"];
	BTP_PAL_THRESH_MEDIUM=  CONFIG["THRESH"]["MEDIUM"];
	BTP_PAL_THRESH_SMALL=   CONFIG["THRESH"]["SMALL"];
	BTP_PAL_THRESH_SHIELD = CONFIG["THRESH"]["SHIELD"];

end



-- dump out config arrays
function btp_config_dump()
end

-- set the global config options to use the paladins config
function btp_pal_config_init()
	CONFIG["THRESH"] = { };
	CONFIG["THRESH"] = CONFIG_THRESH_PAL;
	CONFIG["OPTS"] = { };
	CONFIG["OPTS"] = CONFIG_OPTS_PAL;
	CONFIG["SPELLS"] = { };
	CONFIG["SPELLS"] = CONFIG_SPELLS;
end

-- set a threshold and return the result
-- cmdstr must be in the format "<THRESHNAME> <PERCENT>"
function btp_set_thresh(cmdstr)
	local args = explode(" ", cmdstr);

	if(args[1] == nil or args[2] == nil) then
		btp_frame_debug("btp_set_thresh: arguments missing");
		return false;
	end

	if(CONFIG["THRESH"][args[1]] == nil) then
		btp_frame_debug("btp_set_thresh: " .. args[1] .. " unknown threshold");
		return false;
	end

	CONFIG["THRESH"][args[1]]["VAL"] = 0 + args[2];
	btp_frame_debug("btp_set_thresh: updated " .. args[1] .. " to " .. args[2]);

	BTP_PAL_THRESH_CRIT=    CONFIG["THRESH"]["CRIT"]["VAL"];
	BTP_PAL_THRESH_LARGE=   CONFIG["THRESH"]["LARGE"]["VAL"];
	BTP_PAL_THRESH_MEDIUM=  CONFIG["THRESH"]["MEDIUM"]["VAL"];
	BTP_PAL_THRESH_SMALL=   CONFIG["THRESH"]["SMALL"]["VAL"];
	BTP_PAL_THRESH_SHIELD = CONFIG["THRESH"]["SHIELD"]["VAL"];

	-- btp_frame_debug("humm: " .. BTP_PAL_THRESH_CRIT);

	return CONFIG["THRESH"][args[1]];
end


function btp_addon_cast_spell(cmdstr)
	if(cmdstr == nil) then 
		btp_frame_debug("btp_cmd: no cmdstr given");
		return false;
	end

	-- get the target
	-- local target, spell = btp_shift(" ", cmdstr);

	-- try to cast the spell
	doAddonCmd = true;
	if(doAssistUnit and doAssistUnitFor) then
		target = doAssistUnit .. "target";
		target_name = UnitName(target);
		if(target_name) then
			btp_frame_debug("Casting: " .. cmdstr .. " on: " .. UnitName(target) .. 
				" for: " .. doAssistUnitFor);
		end
		if(btp_cast_spell_on_target(cmdstr, target)) then return true; end
	end

	return false
end

function btp_cmd(cmdstr)
	-- local args = explode(" ", cmdstr);
	local run_cmd = nil;
	if(cmdstr == nil) then 
		btp_frame_debug("btp_cmd: no cmdstr given");
		return false;
	end

    args="";
	local cmd, args = btp_shift(" ", cmdstr);
    if(not cmd ) then 
        return false;
    end
	btp_frame_debug("cmd: " .. cmd .. " args: " .. args);

	if(cmd == nill) then
		btp_debug("btp_cmd: cmd name not passed in");
		return false;
	end
	--
	-- check various cmd arrays to see if it's a valid command
	run_cmd = CONFIG_CMDS["GENRAL"][cmd];

	if(run_cmd == nil) then
		btp_frame_debug("btp_cmd: '" .. cmd .. "' not a valid command");
		return false;
	end

	if(cmd == "spell_toggle") then
		return btp_spell_toggle(args);
	elseif(cmd == "set_thresh") then
		return btp_set_thresh(args);
	elseif(cmd == "set_opt") then
		return btp_set_opt(args);
	elseif(cmd == "cast_spell") then
		return btp_addon_cast_spell(args);
	elseif(cmd == "frame_test") then
		return btp_frame_test(args);
	end
end

function btp_shift(div, str)
	if (div=='') then return false end
	local pos = 0;
	local val;
	local left;
	st, sp = string.find(str, div, pos, true);
    if(st and sp) then
	val = string.sub(str, pos, st-1);
	left = string.sub(str, st+1);
	-- btp_frame_debug(val .. " -> " .. left);
	return val, left;
    end
    return false;
end

function btp_dump_casting_info(unit)
    if (not unit) then unit = "player"; end;

    local spell, rank, displayName, icon, startTime, endTime, 
          isTradeSkill, castID, interrupt = UnitCastingInfo(unit);

    if (spell ~= nil) then

        if (displayName == nil) then dispalyName = "NONE"; end
        if (rank == nil) then rank = "NONE"; end
        if (icon == nil) then icon = "NONE"; end
        if (startTime == nil) then startTime = "NONE"; end
        if (endTime == nil) then endTime = "NONE"; end

        btp_frame_debug("spell: " .. spell .. " rank: " .. rank .. 
                        " disp: " .. displayName .. " icon: " .. icon ..
			" start: " .. startTime .. 
                        " end: " .. endTime);
        return true;
    end
    btp_frame_debug(UnitName(unit) .. " not casting");
    return false;
end

function btp_dump_casting_info_short(unit)
    local spell, _, _, _, _, endTime = UnitCastingInfo(unit);
    if spell then 
        local finish = endTime/1000 - GetTime()
        ChatFrame1:AddMessage(spell .. ' will be finished casting in ' .. finish .. ' seconds.')
    end
end

function btp_test()
    if(btp_priest_is_pws()) then
        btp_frame_debug("renew IS GO");
    else
        btp_frame_debug("renew IS BUST");
    end
    -- btp_bot_aoe();
	-- btp_trade_item("Conjured Glacier Water", "Banmii");
	-- if(CursorHasItem()) then
		-- btp_frame_debug("hello");
		-- DropItemOnUnit("target");
	-- end
	-- btp_pal_config_init();
--  	btp_frame_debug("printing spells");
--  	for key, value in pairs (CONFIG_SPELLS) do
--  		if(key ~= nil and value ~= nil) then
--  			if(value) then
-- 				val="true";
--  			else
--  				val="false";
--  			end
--  			btp_frame_debug("key: " .. key .. " val: " .. val);
--  		end
--  	end
--  	btp_shift(" ", "one two three four");
end;

-- toggle a spell in CONFIG_SPELLS to true/false
-- it will return the result
function btp_spell_toggle(sname)
	local val;
	if(CONFIG_SPELLS[sname] ~= nil) then
		if(CONFIG_SPELLS[sname]) then
			CONFIG_SPELLS[sname] = false;
			val = "false";
		else
			CONFIG_SPELLS[sname] = true;
			val = "true";
		end
	else
		btp_frame_debug("btp_spell_toggle: " .. sname .. " not found!");
		return false;
	end
	btp_frame_debug("btp_spell_toggle: " .. sname .. " -> " .. val);
	return CONFIG_SPELLS[sname];
end

function btp_init_spells()
	local i = 1;

	btp_frame_debug("init spells");

	repeat
		spell, rank= GetSpellBookItemName(i, BOOKTYPE_SPELL)
		
		if(spell ~= nil and rank ~= nil) then
			if(CONFIG_SPELLS[spell] == nil) then
				CONFIG_SPELLS[spell] = true;
			end
		end
		i = i + 1;
	until (not spell)

	i = 1;
	repeat
		spell, rank = GetSpellBookItemName(i, BOOKTYPE_PET)
		if(spell ~= nil and rank ~= nil) then
			if(CONFIG_SPELLS[spell] == nil) then
				CONFIG_SPELLS[spell] = true;
			end
		end
		i = i + 1;
	until (not spell)
end

































function btp_pal_heal()
	if(pvpBot) then
		return btp_pal_heal_pvp();
	end

	if(btp_pal_heal_std()) then
		return true;
	-- else
		--return btp_priest_resurrection();
	end
	return false;
end

function btp_pal_heal_pvp()
	-- init
	ProphetKeyBindings();

	-- Check if we are hurt badly we do small heals 
	-- on ourselves last. otherwise we would just about
	-- constantly be healing ourselves.
	local cur_health = UnitHealth("player");
	local cur_health_max = UnitHealthMax("player");
	local cur_class = UnitClass("player");
	
	-- Check if we should shield ourself
	if(cur_health/cur_health_max <= BTP_PAL_THRESH_CRIT) then
		if(btp_cast_spell("Divine Shield")) then 
			return true; 
		end
	end
	-- Check if anyone needs to be shielded
	if(btp_pal_shield()) then return true; end

	if(not btp_pal_isconcentration()) then
		if(btp_cast_spell("Concentration Aura")) then
			return true;
		end
	end
	-- If someone needs a heal we need to stop moving
	if(pvpBot) then
		cur_player = btp_health_status(BTP_PAL_THRESH_SMALL);
		if((cur_health/cur_health_max <= BTP_PAL_THRESH_LARGE or
			cur_player ~= false)) then
			-- make sure we stay close to our followPlayer
			-- we also want to stop if we need to heal ourself
			if(btp_check_dist(followPlayer, 2) or 
				(cur_health/cur_health_max <= BTP_PAL_THRESH_LARGE)) then
				-- stop moving
				if(cur_player == false) then 
					uname = "Dirne";
				else
					uname = UnitName(cur_player);
				end
		    		-- btp_frame_debug("STOP Moving: " .. uname);
				stopMoving = true;
				FuckBlizzardMove("TURNLEFT");
			end
		elseif(stopMoving) then
			-- if we have stoped moving check if we can start again
			cur_player = btp_health_status(BTP_PAL_THRESH_SMALL);
			if((cur_health/cur_health_max >= BTP_PAL_THRESH_LARGE) and
			    not cur_player) then
			    	-- btp_frame_debug("START Moving");
				stopMoving = false;
			end
		end
	end

	-- always keep this up if we can
	if(btp_cast_spell("Divine Favor")) then 
		return true; 
	end

	-- if we are getting low on mana fix it
	mana_level = UnitPower("player")/UnitPowerMax("player");
	if(UnitAffectingCombat("player") and mana_level < .4) then
		if(btp_cast_spell("Divine Illumination")) then
			return true;
		end
	end

	
	-- Check ourself for crit heal
	if(cur_health/cur_health_max <= BTP_PAL_THRESH_CRIT and
	   cur_health >= 5) then
		-- btp_frame_debug("Crit Heal: " .. "Dirne");

		if(btp_cast_spell("Holy Shock")) then 
			return true; 
		end
		if(btp_cast_spell_on_target("Flash of Light", "player")) then 
			return true; 
		end
	end

	-- check ourself for large heals
	if(cur_health/cur_health_max <= BTP_PAL_THRESH_LARGE and
	   cur_health >= 5) then
		-- btp_frame_debug("Large Heal: " .. "Dirne");
		if(btp_cast_spell_on_target("Holy Light", "player")) then 
			return true; 
		end
	end

	-- check group for crit heals
	cur_player = btp_health_status(BTP_PAL_THRESH_CRIT);
	if(cur_player ~= false) then
		-- btp_frame_debug("Crit Heal: " .. cur_player);

		mana_level = UnitPower("player")/UnitPowerMax("player");
		if(mana_level < .2) then
			if(btp_cast_spell("Lay on Hands")) then 
				return true; 
			end
		end

		if(btp_cast_spell("Holy Shock")) then 
			return true; 
		end

		if(btp_cast_spell_on_target("Flash of Light", cur_player)) then 
			return true; 
		end
	end

	-- Check group for large heals
	cur_player = btp_health_status(BTP_PAL_THRESH_LARGE);
	if(cur_player ~= false) then
		-- btp_frame_debug("Large Heal: " .. cur_player);
		if(btp_cast_spell_on_target("Holy Light", cur_player)) then 
			return true; 
		end
	end

	
	-- Check for medium heals
	cur_player = btp_health_status(BTP_PAL_THRESH_MEDIUM);
	if(cur_player ~= false) then
		-- btp_frame_debug("Medium Heal: " .. cur_player);
		if(btp_cast_spell_on_target("Flash of Light", cur_player)) then 
			return true; 
		end
	end

	-- Check for small heals
	cur_player = btp_health_status(BTP_PAL_THRESH_SMALL);
	if(cur_player ~= false) then
		-- btp_frame_debug("Small Heal: " .. cur_player);
		if(btp_cast_spell_on_target("Flash of Light", cur_player)) then 
			return true; 
		end
	end

	if(BTP_Decursive()) then
		return true;
	end

	if(not UnitAffectingCombat("player")) then
		return btp_pal_buf();
	end

end

function btp_pal_dps()
	--
	-- bind our keys if needed
	ProphetKeyBindings();
	
	-- Call chris's potion code
        if (SelfHeal(PALADIN_HEALTH_THRESH/2, PALADIN_MANA_THRESH/3)) then
            -- 
            -- We are doing a self heal (healthstones, potions, etc)
            --
            return true;
        end

	if(btp_cast_spell("Holy Shield")) then return true; end

	-- Get our mana level
	mana_level = UnitPower("player")/UnitPowerMax("player");
	-- Get our health level
	health_level = UnitHealth("player")/UnitHealthMax("player");

	-- Since we are tanking always check our health first
	if(health_level < (BTP_PAL_THRESH_SHIELD)) then
		if(btp_cast_spell("Divine Shield")) then 
			return true; 
		end
		if(btp_cast_spell("Blessing of Protection")) then 
			return true; 
		end
	end

	if(btp_pal_shield() == true) then return true; end

	-- Set our Aura if need be
	if(not btp_pal_isshadow() and
	   not btp_pal_isfrost() and
	   not btp_pal_isfire() and
	   not btp_pal_isconcentration() and
	   not btp_pal_isdevotion() and
	   not btp_pal_isretribution() and
	   not btp_pal_issanctity()) then
		if(btp_cast_spell("Concentration Aura")) then
			return true;
		end
	end

	-- If we are low on mana then throw on mana wisdom blessing
	if(not btp_pal_isbok() and
	   not btp_pal_isbow() and
	   not btp_pal_isbos() and
	   not btp_pal_isbom() and
	   not btp_pal_isbof() and
	   not btp_pal_isbop()) then
		if(mana_level < PALADIN_MANA_THRESH) then
			if(btp_cast_spell("Blessing of Wisdom")) then
				return true;
			end
		else
			if(btp_cast_spell("Blessing of Kings")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Wisdom")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Might")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Sanctuary")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Sanctuary")) then
				return true;
			end
		end
	end

	if(btp_cast_spell("Holy Shock")) then return true; end

	if((UnitHealth("target")/UnitHealthMax("target")) < .2) then
		if(btp_cast_spell("Hammer of Wrath")) then return true; end
	end

	if(UnitCreatureType("target")=="Undead" or UnitCreatureType("target")=="Demon") then
		if(btp_cast_spell("Exorcism")) then return true; end
	end

 	if(btp_cast_spell("Consecration")) then return true; end
	--
	-- if the target does not have SOC then use it
	if( not btp_pal_issow() and not btp_check_debuff("HolySmite", "target")
		and not btp_pal_issoc()
		and not btp_pal_issoj()) then
		if(btp_cast_spell("Seal of the Crusader")) then return true; end
	end

-- btp_frame_debug("yo");
	-- I will likely need to make this configurable
	-- I may also want to add code so that if i have one
	-- of the others on it will not cast this.
	if(not btp_pal_issor() and not btp_pal_issow() and not btp_pal_issob()
		and not btp_pal_issoc() and not btp_pal_issoj()) then
		return btp_cast_spell("Seal of Righteousness");
	end

	-- I call Judgment as soon as possible notice that i do
	-- it last so that if any other spell is on cooldown it
	-- will use that first
--	if(btp_pal_issow() and not btp_pal_is_target_sow() or
--	   btp_pal_issor() and mana_level < PALADIN_MANA_THRESH
--	   ) then
--		-- do not judge seal
--	else
--	end

-- btp_frame_debug("here");
	if(btp_cast_spell("Judgement of Light")) then return true; end
-- btp_frame_debug("there");

	if(btp_pal_is_target_soc() and btp_pal_issoc()) then
		if(btp_cast_spell("Seal of Righteousness")) then return true; end
	end
	
	-- I need to figure out how to call this once only

	return true;


end

function btp_pal_heal_std()
	-- init
	ProphetKeyBindings();

	-- Check if we are hurt badly we do small heals 
	-- on ourselves last. otherwise we would just about
	-- constantly be healing ourselves.
	local cur_health = UnitHealth("player");
	local cur_health_max = UnitHealthMax("player");
	local cur_class = UnitClass("player");
	--
	-- Check if anyone needs to be shielded
	if(btp_pal_shield()) then return true; end

	if(cur_health/cur_health_max <= BTP_PAL_THRESH_CRIT and
	   cur_health >= 5) then
		FuckBlizzardTargetUnit("player");
		-- if(btp_cast_spell("Holy Shock")) then 
		-- 	return true; 
		-- end
		if(btp_cast_spell("Flash of Light")) then 
			return true; 
		end
	end
	if(cur_health/cur_health_max <= BTP_PAL_THRESH_LARGE and
	   cur_health >= 5) then
		FuckBlizzardTargetUnit("player");
		if(btp_cast_spell("Holy Light")) then 
			return true; 
		end
	end


	-- Check our Party and Raid groups now
	
	if(BTP_Decursive()) then
		return true;
	end
	
	-- Check for critical heals and use a fast heal
	cur_player = btp_health_status(BTP_PAL_THRESH_CRIT);
	if(cur_health/cur_health_max <= BTP_PAL_THRESH_CRIT and
	   cur_health >= 5) then
		FuckBlizzardTargetUnit(cur_player);
		if(btp_cast_spell("Holy Shock")) then 
			return true; 
		end
		if(btp_cast_spell("Flash of Light")) then 
			return true; 
		end
	end

	-- Check for large heals
	cur_player = btp_health_status(BTP_PAL_THRESH_LARGE);
	if(cur_player ~= false) then
		-- btp_frame_debug("Large Heal: " .. cur_player);
		FuckBlizzardTargetUnit(cur_player);
		if(btp_cast_spell("Holy Light")) then return true; end
	end

	
	-- Check for medium heals
	cur_player = btp_health_status(BTP_PAL_THRESH_MEDIUM);
	if(cur_player ~= false) then
		-- btp_frame_debug("Medium Heal: " .. cur_player);
		FuckBlizzardTargetUnit(cur_player);
		-- if(btp_cast_spell("Holy Shock")) then 
		-- 	return true; 
		-- end
		if(btp_cast_spell("Flash of Light")) then 
			return true; 
		end
	end

	-- Check for small heals last
	-- XXX will want to change this likely use a lower lvl
	-- cur_player = btp_health_status(BTP_PAL_THRESH_SMALL);
	-- if(cur_player ~= false) then

		-- FuckBlizzardTargetUnit(cur_player);
		-- btp_frame_debug("Small Heal: " .. cur_player);
		-- if(btp_cast_spell("Flash of Light")) then 
		-- 	return true; 
		-- end
	-- end

	-- go back to healing self
	if(cur_health/cur_health_max <= BTP_PAL_THRESH_LARGE and
	   cur_health >= 5) then
		FuckBlizzardTargetUnit("player");
		if(btp_cast_spell("Holy Shock")) then 
			return true; 
		end
		if(btp_cast_spell("Flash of Light")) then 
			return true; 
		end
	end

	if(cur_health/cur_health_max <= BTP_PAL_THRESH_LARGE and
	   cur_health >= 5) then
		FuckBlizzardTargetUnit("player");
		if(btp_cast_spell("Holy Light")) then return true; end
	end

	if(cur_health/cur_health_max <= BTP_PAL_THRESH_MEDIUM and
	   cur_health >= 5) then
		FuckBlizzardTargetUnit("player");
		-- if(btp_cast_spell("Holy Shock")) then 
		-- 	return true; 
		-- end
		if(btp_cast_spell("Flash of Light")) then 
			return true; 
		end
	end

	-- we will want to change this
	if(cur_health/cur_health_max <= BTP_PAL_THRESH_SMALL and
	   cur_health >= 5) then
		FuckBlizzardTargetUnit("player");
		-- will likely want to down grade this to a lower lvl
		if(btp_cast_spell("Flash of Light")) then 
			return true; 
		end
	end

	if(BTP_Decursive()) then
		return true;
	end

	-- if(not UnitAffectingCombat("player")) then
	-- 	return btp_pal_buf();
	-- end
end


function btp_pal_buf()
	for i = 1, GetNumPartyMembers() do
		nextPlayer = "party" .. i;
		cur_class = UnitClass(nextPlayer);
		if(btp_check_dist(nextPlayer, 1) and
		   not btp_pal_isbok(nextPlayer) and 
		   not btp_pal_isbow(nextPlayer) and
		   not btp_pal_isbom(nextPlayer) and 
		   not btp_pal_isbol(nextPlayer) and
		   not btp_pal_isbos(nextPlayer) and
		   not btp_pal_isbof(nextPlayer)) then
			if((cur_class == "Warrior" or
		   	    cur_class == "Druid" or
		   	    cur_class == "Shaman" or
			    (cur_class == "Warlock" and pvpBot) or
			    (cur_class == "Mage" and pvpBot))) then
				if(not pvpBot and btp_cast_spell_on_target("Greater Blessing of Kings", nextPlayer)) then return true; end
				if(btp_cast_spell_on_target("Blessing of Kings", nextPlayer)) then return true; end
			elseif((cur_class == "Rouge" or
		       	        cur_class == "Hunter")) then
				if(not pvpBot and btp_cast_spell_on_target("Greater Blessing of Kings", nextPlayer)) then return true; end
				if(btp_cast_spell_on_target("Blessing of Kings", nextPlayer)) then return true; end
			elseif((cur_class == "Priest" or
				cur_class == "Paladin")) then
				if(not pvpBot and btp_cast_spell_on_target("Greater Blessing of Wisdom", nextPlayer)) then return true; end
				if(btp_cast_spell_on_target("Blessing of Wisdom", nextPlayer)) then return true; end
			else
				if(not pvpBot and btp_cast_spell_on_target("Greater Blessing of Kings", nextPlayer)) then return true; end
				if(btp_cast_spell_on_target("Blessing of Kings", nextPlayer)) then return true; end
			end
		end

	end
	for i = 1, GetNumRaidMembers() do
		nextPlayer = "raid" .. i;
		cur_class = UnitClass(nextPlayer);
		if(btp_check_dist(nextPlayer, 1) and
		   not btp_pal_isbok(nextPlayer) and 
		   not btp_pal_isbow(nextPlayer) and
		   not btp_pal_isbom(nextPlayer) and 
		   not btp_pal_isbol(nextPlayer) and
		   not btp_pal_isbos(nextPlayer) and
		   not btp_pal_isbof(nextPlayer)) then
			if((cur_class == "Warrior" or
		   	    cur_class == "Druid" or
		   	    cur_class == "Shaman" or
			    (cur_class == "Warlock" and pvpBot) or
			    (cur_class == "Mage" and pvpBot))) then
				if(not pvpBot and btp_cast_spell_on_target("Greater Blessing of Kings", nextPlayer)) then return true; end
				if(btp_cast_spell_on_target("Blessing of Kings", nextPlayer)) then return true; end
			elseif((cur_class == "Rouge" or
		       	        cur_class == "Hunter")) then
				if(not pvpBot and btp_cast_spell_on_target("Greater Blessing of Kings", nextPlayer)) then return true; end
				if(btp_cast_spell_on_target("Blessing of Kings", nextPlayer)) then return true; end
			elseif((cur_class == "Priest" or
				cur_class == "Paladin")) then
				if(not pvpBot and btp_cast_spell_on_target("Greater Blessing of Wisdom", nextPlayer)) then return true; end
				if(btp_cast_spell_on_target("Blessing of Wisdom", nextPlayer)) then return true; end
			else
				if(not pvpBot and btp_cast_spell_on_target("Greater Blessing of Kings", nextPlayer)) then return true; end
				if(btp_cast_spell_on_target("Blessing of Kings", nextPlayer)) then return true; end
			end
		end
	end
	return false;
end


function btp_pal_shield()
	for i = 1, GetNumPartyMembers() do
		local cur_player = "party" .. i;
		local cur_health = UnitHealth(cur_player);
		local cur_health_max = UnitHealthMax(cur_player);
		local cur_class = UnitClass(cur_player);

		if(cur_health/cur_health_max <= BTP_PAL_THRESH_SHIELD and
		   cur_health >= 5 and btp_check_dist(cur_player, 1)) then
			if(not pvpBot and 
				(cur_class == "Warrior" or
				 cur_class == "Paladin" or
				 cur_class == "Druid")) then
				-- do nothing
				-- btp_frame_debug("Not shielding Tanking class");
			elseif(cur_class ~= "Warrior" and
				cur_class ~= "Paladin" and
				cur_class ~= "Druid") then
				-- We have a class that needs a shield
				-- btp_frame_debug("Shield bitches: " .. UnitName(cur_player));
				if(btp_cast_spell_on_target("Blessing of Protection", cur_player))then
					return true;
				end
			end
		end
	end
	for i = 1, GetNumRaidMembers() do
		local cur_player = "raid" .. i;
		local cur_health = UnitHealth(cur_player);
		local cur_health_max = UnitHealthMax(cur_player);
		local cur_class = UnitClass(cur_player);

		if(cur_health/cur_health_max <= BTP_PAL_THRESH_SHIELD and
		   cur_health >= 5 and btp_check_dist(cur_player, 1)) then
			if(not pvpBot and 
				(cur_class == "Warrior" or
				 cur_class == "Paladin")) then
				-- do nothing
				-- btp_frame_debug("Not shielding Tanking class");
			else
				-- We have a class that needs a shield
				-- btp_frame_debug("Shield bitches: " .. UnitName(cur_player));
				if(btp_cast_spell_on_target("Blessing of Protection", cur_player))then
					return true;
				end
			end
		end
	end
	return false;
end

-- this function is used to request that any bots you have in 
-- your party help with aoe. This is usefull for farming etc.
function btp_bot_aoe()
	SendAddonMessage("BTP", "cast_spell Arcane Explosion", "WHISPER", "Waterbreak");
	SendAddonMessage("BTP", "cast_spell Frost Nova", "WHISPER", "Waterbreak");
	SendAddonMessage("BTP", "cast_spell Arcane Barrage", "WHISPER", "Waterbreak");
end

-- this function will assist "unit" in what ever dps mode a bot
-- might have
function btp_bot_dps(unit)
end

-- this function will cast any finishing moves that bots in
-- the party may have
function btp_bot_kill(unit)
end

function btp_pal_ret()

	-- bind our keys if needed
	ProphetKeyBindings();
	
	-- Call chris's potion code
        if (SelfHeal(PALADIN_HEALTH_THRESH/2, PALADIN_MANA_THRESH/3)) then
            -- 
            -- We are doing a self heal (healthstones, potions, etc)
            --
            return true;
        end

	if(btp_cast_spell("Holy Shield")) then return true; end

	-- Get our mana level
	mana_level = UnitPower("player")/UnitPowerMax("player");
	-- Get our health level
	health_level = UnitHealth("player")/UnitHealthMax("player");

	-- Since we are NOT tanking Shield ourself early
	if(health_level < .50 and UnitAffectingCombat("player")) then
		-- if forbarance is not up try our shields first
		if(not btp_check_debuff("Holy_RemoveCurse", "player")) then
			if(btp_cast_spell("Divine Shield")) then 
				return true; 
			elseif(btp_cast_spell("Divine Protection")) then 
				return true;
			elseif(btp_cast_spell("Hand of Protection")) then
				return true;
			end
		end
	end

	-- Loh if need be
	if(health_level < (BTP_PAL_THRESH_SHIELD)) then
		if(btp_cast_spell("Lay on Hands")) then 
			return true; 
		end
	end

	if(btp_pal_shield() == true) then return true; end

	-- Set our Aura if need be
	if(not btp_pal_isshadow() and
	   not btp_pal_isfrost() and
	   not btp_pal_isfire() and
	   not btp_pal_isconcentration() and
	   not btp_pal_isdevotion() and
	   not btp_pal_isretribution()) then
		if(btp_cast_spell("Retribution Aura")) then
			return true;
		end
	end

	-- If we are low on mana then throw on mana wisdom blessing
	if(not btp_pal_isbok() and
	   not btp_pal_isbow() and
	   not btp_pal_isbos() and
	   not btp_pal_isbom() and
	   not btp_pal_isbof() and
	   not btp_pal_isbop()) then
		if(mana_level < PALADIN_MANA_THRESH) then
			if(btp_cast_spell("Blessing of Wisdom", "player")) then
				return true;
			end
		else
			if(btp_cast_spell("Blessing of Might")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Kings")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Sanctuary")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Sanctuary")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Wisdom")) then
				return true;
			end
		end
	end


    -- if banmii is with shadow word death
	SendAddonMessage("BTP", "cast_spell Shadow Word: Death", "WHISPER", "Banmii");

	if((UnitHealth("target")/UnitHealthMax("target")) < .20) then
		if(btp_cast_spell("Hammer of Wrath")) then return true; end
	end

	-- check if our target is casting a spell and try to interupt
	local spell_cast, _, _, _, _, endTime = UnitCastingInfo("target")
	if(spell_cast ~= nil) then
		if(btp_cast_spell_on_target("Arcane Torrent", unit)) then return true; end
		if(btp_cast_spell_on_target("Hammer of Justice", unit)) then return true; end
	end

	if(btp_pal_issor() or btp_pal_issow() or btp_pal_issob()
		or btp_pal_issoc() or btp_pal_issoj() or btp_pal_issocmd()) then
		if(btp_cast_spell("Judgement of Justice")) then return true; end
	end

	-- Uber undead/demon tanking
	if(UnitCreatureType("target")=="Undead" or UnitCreatureType("target")=="Demon") then
		if(btp_cast_spell("Exorcism")) then return true; end
		if(btp_cast_spell("Holy Wrath")) then return true; end
	end

	-- I will likely need to make this configurable
	-- I may also want to add code so that if i have one
	-- of the others on it will not cast this.
	if(not btp_pal_issor() and not btp_pal_issow() and not btp_pal_issob()
		and not btp_pal_issoc() and not btp_pal_issoj() and not btp_pal_issocmd()) then
		return btp_cast_spell("Seal of Blood");
	end

	-- if art of war is up heal ourself if we need it
	if(btp_pal_isaow() and health_level < .75) then
		if(btp_cast_spell("Flash of Light")) then return true; end
	end

	if(btp_cast_spell("Hammer of Justice")) then return true; end
	if(btp_cast_spell("Avenging Wrath")) then return true; end
	if(btp_cast_spell("Crusader Strike")) then return true; end
	if(btp_cast_spell("Divine Storm")) then return true; end
 	if(btp_cast_spell("Consecration")) then return true; end
	if(btp_cast_spell("Hand of Freedom")) then return true; end

	return true;

end

function btp_pal_tank_new(tank_aoe)

	-- default to no aoe
	if(tank_aoe == nil) then tank_aoe=false; end

	-- bind our keys if needed
	ProphetKeyBindings();


	
	-- Call chris's potion code
        if (SelfHeal(PALADIN_HEALTH_THRESH/2, PALADIN_MANA_THRESH/3)) then
            -- 
            -- We are doing a self heal (healthstones, potions, etc)
            --
            return true;
        end

	-- Get our mana level
	mana_level = UnitPower("player")/UnitPowerMax("player");
	-- Get our health level
	health_level = UnitHealth("player")/UnitHealthMax("player");

	-- Since we are tanking always check our health first
	if(health_level < (BTP_PAL_THRESH_SHIELD)) then
		if(btp_cast_spell("Lay on Hands")) then 
			return true; 
		end
	end


	-- Always make sure we have our Fury on
	if(not btp_pal_isfury() and not pvpBot) then
		return btp_cast_spell("Righteous Fury");
	end

	-- keep Holy SHield up always
	if(btp_cast_spell("Holy Shield")) then return true; end

	-- reduce our damage if we can
	if(health_level < .50) then
		if(btp_cast_spell("Divine Protection")) then 
			return true; 
		end
	end
	
	-- use hammer of wrath if target is nearly dead
	if((UnitHealth("target")/UnitHealthMax("target")) < .20) then
		if(btp_cast_spell("Hammer of Wrath")) then return true; end
	end
	
	-- check if our target is casting a spell and try to interupt
	local spell_cast, _, _, _, _, endTime = UnitCastingInfo("target");
	if(spell_cast ~= nil) then
		if(btp_cast_spell("Arcane Torrent")) then return true; end
		if(btp_cast_spell("Hammer of Justice")) then return true; end
	end

	-- Set our Aura if need be
	if(not btp_pal_isshadow() and
	   not btp_pal_isfrost() and
	   not btp_pal_isfire() and
	   not btp_pal_isconcentration() and
	   not btp_pal_isdevotion() and
	   not btp_pal_isretribution()) then
		if(btp_cast_spell("Retribution Aura")) then
			return true;
		end
	end

	-- If we are low on mana then throw on mana wisdom blessing
	if(not btp_pal_isbos() and not btp_pal_isbok()) then
			if(btp_cast_spell("Blessing of Sanctuary")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Kings")) then
				return true;
			end
	end

	-- Uber undead/demon tanking
	if(UnitCreatureType("target")=="Undead" or UnitCreatureType("target")=="Demon") then
		if(btp_cast_spell("Exorcism")) then return true; end
		if(tank_aoe) then
			if(btp_cast_spell("Holy Wrath")) then return true; end
		end
	end

	if(not btp_pal_hassealactive()) then
		if(btp_cast_spell("Seal of Corruption")) then return true; end
	end

	if(tank_aoe) then
		if(btp_cast_spell("Avenger's Shield")) then 
 			return true; 
 		end
 		if(btp_cast_spell("Hammer of the Righteous")) then return true; end
 		if(btp_cast_spell("Consecration")) then return true; end
	end
	if(btp_cast_spell("Judgement of Wisdom")) then return true; end
end

function btp_pal_tank()
	--
	-- bind our keys if needed
	ProphetKeyBindings();
	
	-- Call chris's potion code
        if (SelfHeal(PALADIN_HEALTH_THRESH/2, PALADIN_MANA_THRESH/3)) then
            -- 
            -- We are doing a self heal (healthstones, potions, etc)
            --
            return true;
        end


	-- Get our mana level
	mana_level = UnitPower("player")/UnitPowerMax("player");
	-- Get our health level
	health_level = UnitHealth("player")/UnitHealthMax("player");

	-- Since we are tanking always check our health first
	if(health_level < (BTP_PAL_THRESH_SHIELD)) then
		if(pvpBot and btp_cast_spell("Divine Shield")) then 
			return true; 
		end
		-- if(btp_cast_spell("Holy Light")) then return true; end
	end

	if(btp_pal_shield() == true) then return true; end

	-- Set our Aura if need be
	if(not btp_pal_isshadow() and
	   not btp_pal_isfrost() and
	   not btp_pal_isfire() and
	   not btp_pal_isconcentration() and
	   not btp_pal_isdevotion() and
	   not btp_pal_isretribution()) then
		if(btp_cast_spell("Retribution Aura")) then
			return true;
		end
	end

	-- If we are low on mana then throw on mana wisdom blessing
	if(not btp_pal_isbok() and
	   not btp_pal_isbow() and
	   not btp_pal_isbos() and
	   not btp_pal_isbof() and
	   not btp_pal_isbop()) then
		if(mana_level < PALADIN_MANA_THRESH) then
			if(btp_cast_spell("Blessing of Wisdom")) then
				return true;
			end
		else
			if(btp_cast_spell("Blessing of Kings")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Sanctuary")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Sanctuary")) then
				return true;
			end
			if(btp_cast_spell("Blessing of Wisdom")) then
				return true;
			end
		end
	end
	if(not UnitIsUnit("targettarget", "player")) then
		agro = UnitName("targettarget");
		if(agro) then
			-- btp_frame_debug(agro .. " Stole agro!");
			--FuckBlizzardTargetUnit("targettarget");
			--if(btp_cast_spell("Righteous Defense")) then return end;
			--FuckBlizzardTargetUnit("playertarget");
			-- return;
		end
	end


	if(UnitCreatureType("target")=="Undead" or UnitCreatureType("target")=="Demon") then
		if(btp_cast_spell("Exorcism")) then return true; end
	end
	-- -- if(not UnitIsUnit("targettarget", "player") -- 	and UnitName("targettarget") ~= nil) then -- 	FuckBlizzardTargetUnit(UnitName("targettarget")); -- 	-- btp_frame_debug("Righteous Defense: " .. UnitName("targettarget")); -- 	-- if(btp_cast_spell("Righteous Defense")) then -- 	-- 	return; -- 	-- end -- end -- Check our mana level again and if we need more -- put on seal of wisdom 
	-- if the target does not have SOC then use it
	if(not pvpBot and mana_level > (PALADIN_MANA_THRESH * 2) and 
	   not btp_check_debuff("HolySmite", "target")and
	   not btp_pal_issoc() and not PALADIN_GRIND) then
		if(btp_cast_spell("Seal of the Crusader")) then return; end
	end


	mana_level = UnitPower("player")/UnitPowerMax("player");
	if(pvpBot and not btp_pal_issoj() 
		and not btp_check_debuff("SealOfWrath", target)) then
		return btp_cast_spell("Seal of Justice");
	elseif(((mana_level < PALADIN_MANA_THRESH) 
		and not btp_pal_issow() and not btp_pal_issoc()
		and not btp_pal_issoj()
		and not btp_pal_issor())
		or (PALADIN_GRIND and not btp_pal_issow() and not btp_pal_issoj()
		and not btp_check_debuff("RighteousnessAura", target))) then
		return btp_cast_spell("Seal of Wisdom");
	end

	-- Always make sure we have our Fury on
	if(not btp_pal_isfury() and not pvpBot) then
		return btp_cast_spell("Righteous Fury");
	end

	-- I will likely need to make this configurable
	-- I may also want to add code so that if i have one
	-- of the others on it will not cast this.
	if(not btp_pal_issor() and not btp_pal_issow() 
		and not btp_pal_issoc() and not btp_pal_issoj()) then
		return btp_cast_spell("Seal of Righteousness");
	end

	if((UnitHealth("target")/UnitHealthMax("target")) < .2) then
		if(btp_cast_spell("Hammer of Wrath")) then return true; end
	end

	if(btp_cast_spell("Holy Shock")) then
		FuckBlizzardAttackTarget(); 
		return true;
	end

	if(btp_cast_spell("Avenger's Shield")) then 
 		return true; 
 	end

 	if(btp_cast_spell("Consecration")) then return true; end

	-- I call Judgment as soon as possible notice that i do
	-- it last so that if any other spell is on cooldown it
	-- will use that first
	if(btp_pal_issow() and not btp_pal_is_target_sow() or
	   btp_pal_issor() and mana_level < PALADIN_MANA_THRESH
	   ) then
		-- do not judge seal
	else
		if(btp_cast_spell("Judgement")) then return true; end
	end
	
	-- I need to figure out how to call this once only

	return true;
end

-- Buffs
function btp_pal_isfury(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfFury", unit)) then return true; end
	return false;
end

-- Seals
function btp_pal_issor(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("ThunderBolt", unit)) then return true; end
	return false;
end

function btp_pal_issob(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfBlood", unit)) then return true; end
	return false;
end

function btp_pal_issow(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("RighteousnessAura", unit)) then return true; end
	return false;
end

function btp_pal_is_target_sow(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_debuff("RighteousnessAura", unit)) then return true; end
	return false;
end

function btp_pal_issoc(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("HolySmite", unit)) then return true; end
	return false;
end

function btp_pal_issov(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfVengeance", unit)) then return true; end
	return false;
end



function btp_pal_is_target_soc(unit)
	if(not unit) then  unit = "target"; end
	if(btp_check_debuff("HolySmite", unit)) then return true; end
	return false;
end


function btp_pal_issoj(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfWrath", unit)) then return true; end
	return false;
end

function btp_pal_issocmd(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("InnerRage", unit)) then return true; end
	return false;
end


function btp_pal_hassealactive()
	if(btp_pal_issoc() or btp_pal_issov() or btp_pal_issoj() or
		btp_pal_issob() or btp_pal_issow() or btp_pal_issor()) then
		return true;
	end
	return false;
end


-- Blessings
function btp_pal_isbow(unit) -- Wisdom
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfWisdom", unit)) then return true; end
	if(btp_check_buff("GreaterBlessingofWisdom", unit)) then return true; end
	return false;
end

function btp_pal_isbos(unit) -- Sanctuary
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("LightningShield", unit)) then return true; end
	if(btp_check_buff("GreaterBlessingofSanctuary", unit)) then return true; end
	return false;
end

function btp_pal_isbok(unit) -- Kings
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("MageArmor", unit)) then return true; end
	if(btp_check_buff("GreaterBlessingofKings", unit)) then return true; end
	return false;
end

function btp_pal_isbom(unit) -- Might
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("FistOfJustice", unit)) then return true; end
	if(btp_check_buff("GreaterBlessingofMight", unit)) then return true; end
	return false;
end

function btp_pal_isbol(unit) -- Light
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("PrayerOfHealing02", unit)) then return true; end
	if(btp_check_buff("GreaterBlessingofLight", unit)) then return true; end
	return false;
end

function btp_pal_isbof(unit) -- Freedom
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfValor", unit)) then return true; end
	return false;
end

function btp_pal_isbop(unit) -- protection
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfValor", unit)) then return true; end
	return false;
end

function btp_pal_isbop(unit) -- protection
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfValor", unit)) then return true; end
	return false;
end


-- Auras

function btp_pal_isdevotion(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("DevotionAura", unit)) then return true; end
	return false;
end

function btp_pal_isretribution(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("AuraOfLight", unit)) then return true; end
	return false;
end

function btp_pal_issanctity(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("Holy_MindVision", unit)) then return true; end
	return false;
end

function btp_pal_isaow(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("ArtofWar", unit)) then return true; end
	return false;
end

function btp_pal_isconcentration(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("MindSooth", unit)) then return true; end
	return false;
end

function btp_pal_isshadow(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfKings", unit)) then return true; end
	return false;
end

function btp_pal_isfrost(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("WizardMark", unit)) then return true; end
	return false;
end

function btp_pal_isfire(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("SealOfFire", unit)) then return true; end
	return false;
end




-- NEW GENERAL STUFF
--
--

function btp_genral_msg_cmd()
end

function btp_is_guildmate(pname)
	GuildRoster();
	for i = 0, GetNumGuildMembers(true) do
		name, rank, rankIndex, level, class, zone, note, officernote,
		online, status = GetGuildRosterInfo(i);
		if(name and string.lower(pname) == string.lower(name)) then
			return true;
		end
	end
	return false;
end



