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

function btp_mage_initialize()
    btp_frame_debug("Mage INIT");

	SLASH_MAGEDPS1 = "/mdps";
	SlashCmdList["MAGEDPS"] = btp_mage_dps;

end

local frame = CreateFrame("Frame", "btp_mage_bot_Frame");
frame:SetScript("OnEvent", btp_mage_bot_OnEvent);
frame:RegisterEvent("TRADE_SHOW");
frame:RegisterEvent("TRADE_REQUEST");
frame:RegisterEvent("TRADE_CLOSED");
frame:RegisterEvent("CHAT_MSG_WHISPER");


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

-- MAGE stuff mage
function btp_mage_dps(unit)
	return btp_mage_dps_frost(unit);
	-- return btp_mage_dps_arcane(unit);
end

function btp_mage_dps_arcane(unit)
-- HEALTH THRESH
-- when to start using mana shield
BTP_MAGE_THRESH_MANASHIELD = .80

-- MANA THRESH
-- when to cast evocate
BTP_MAGE_THRESH_EVOCATE = .60;
-- when to stop using manashield
BTP_MAGE_THRESH_NO_MANASHIELD = .50
-- when to stop using iceshield
BTP_MAGE_THRESH_NO_ICEBARRIER = .01
	
	-- bind our keys if needed
	ProphetKeyBindings();

	-- setup a default unit
	if(not unit or unit == nil or unit == "") then  
		unit = "target"; 
	end

	-- Get our mana level
	mana_level = UnitPower("player")/UnitPowerMax("player");
	-- Get our health level
	health_level = UnitHealth("player")/UnitHealthMax("player");

	-- if we are low on mana evocate or use mana emrald
	if(mana_level < BTP_MAGE_THRESH_EVOCATE and 
	    UnitAffectingCombat("player")) then
	        -- First try to use Mana Gems
		-- if(btp_use_item("Mana Emerald")) then return true; end
		-- if(btp_cast_spell("Evocation"))then return true; end
	end

	-- check if our target is casting a spell
	if(UnitAffectingCombat("player")) then
		local spell_cast, _, _, _, _, endTime = UnitCastingInfo("target")
		if(spell_cast ~= nil) then
			if(btp_cast_spell_on_target("Counterspell", unit)) then return true; end
		end
		
		-- buff up a bit more if we can
		if(btp_cast_spell("Icy Veins")) then return true; end
	end

	-- put up our shields
	if(mana_level > BTP_MAGE_THRESH_NO_MANASHIELD and
	 not btp_mage_is_manashield("player")) then
		if(btp_cast_spell("Mana Shield"))then return true; end
	end
	
	-- check our buffs
	if(not UnitAffectingCombat("player")) then
		if(not btp_mage_is_arcaneintellect("player")) then
			if(btp_cast_spell("Arcane Intellect"))then return true; end
		end

		if(not btp_mage_is_icearmor("player")) then
			if(btp_cast_spell("Ice Armor"))then return true; end
		end

		-- if(btp_mage_buff()) then return true; end
	end


	
	if(btp_cast_spell_on_target("Arcane Power", unit))then return true; end
	if(btp_cast_spell_on_target("Arcane Barrage", unit))then return true; end
	if(not btp_mage_is_slow(unit)) then 
		if(btp_cast_spell_on_target("Slow", unit))then return true; end
	end
	-- Cast POM if we have it
	if(btp_cast_spell_on_target("Presence of Mind", unit))then return true; end
	if(btp_mage_is_pom()) then
		-- instant and crit very nice
		if(btp_cast_spell_on_target("Arcane Blast", unit))then return true; end
	end

	if(btp_mage_is_shortmb()) then
		if(btp_cast_spell_on_target("Arcane Missiles", unit))then return true; end
	end

	if(btp_cast_spell_on_target("Fire Blast", unit))then return true; end

	if(mana_level < .30) then 
		if(btp_mage_use_mana_emerald()) then return true; end
	end

end

function btp_mage_use_mana_emerald()
	for bag=0,4 do
		for slot=1,C_Container.GetContainerNumSlots(bag) do
			if (C_Container.GetContainerItemLink(bag,slot)) then
				if (string.find(C_Container.GetContainerItemLink(bag,slot), "Mana Emerald")) then
					start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
					if (duration - (GetTime() - start) <= 0) then
						FuckBlizUseContainerItem(bag, slot)
						return true;
					end
					break;
				end
			end
		end
	end
	return false;
end

function btp_mage_dps_frost(unit)
	--
    -- HEALTH THRESH
    -- when to start using mana shield
    BTP_MAGE_THRESH_MANASHIELD = .80
    -- when to use ice barrier
    BTP_MAGE_THRESH_ICEBARRIER = .9

    -- MANA THRESH
    -- when to cast evocate
    BTP_MAGE_THRESH_EVOCATE = .60;
    -- when to stop using manashield
    BTP_MAGE_THRESH_NO_MANASHIELD = .50
    -- when to stop using iceshield
    BTP_MAGE_THRESH_NO_ICEBARRIER = .01
	
	-- bind our keys if needed
	ProphetKeyBindings();

	-- setup a default unit
	if(not unit or unit == nil or unit == "") then  
		unit = "target"; 
	end
	-- btp_frame_debug("attacking unit: " .. unit);

	-- Get our mana level
	mana_level = UnitPower("player")/UnitPowerMax("player");
	-- Get our health level
	health_level = UnitHealth("player")/UnitHealthMax("player");

    -- if we are almost dead ice block to try and stay alive
    if(health_level < .25) then
        if(btp_cast_spell("Ice Block")) then return true; end
    end

	-- check if our target is casting a spell
	if(UnitAffectingCombat(unit)) then
		local spell_cast, _, _, _, _, endTime = UnitCastingInfo("target")
		if(spell_cast ~= nil) then
			if(btp_cast_spell_on_target("Counterspell", unit)) then return true; end
		end
		
		-- buff up a bit more if we can
		if(btp_cast_spell("Icy Veins")) then return true; end
	end

    -- only Evocation when not in combat
	if(not UnitAffectingCombat(unit)) then
	    if(mana_level < BTP_MAGE_THRESH_EVOCATE and 
	        UnitAffectingCombat(unit)) then
		    if(btp_cast_spell("Evocation"))then return true; end
        end
	end

	if(mana_level > BTP_MAGE_THRESH_NO_ICEBARRIER and
	   -- health_level < BTP_MAGE_THRESH_ICEBARRIER and
	    not btp_mage_is_icebarrier(unit)) then
		if(btp_cast_spell("Ice Barrier"))then return true; end
	end

	-- check our buffs
	if(not UnitAffectingCombat(unit)) then
		if(not btp_mage_is_arcaneintellect("player")) then
			if(btp_cast_spell("Arcane Intellect"))then return true; end
		end

		if(not btp_mage_is_icearmor("player")) then
			if(btp_cast_spell("Ice Armor"))then return true; end
		end

		if(btp_mage_buff()) then return true; end
	end

    -- 
	if(mana_level < .30) then 
		if(btp_mage_use_mana_emerald()) then return true; end
	end

	--
	-- start our combat sequence
	--
	
	-- if they are frozen try to kill them quick
	if(btp_mage_is_frozen(unit)) then 
		-- btp_frame_debug("target frozen");
		if(btp_cast_spell_on_target("Deep Freeze", unit)) then return true; end
		if(btp_cast_spell_on_target("Ice Lance", unit)) then return true; end
	end

    -- if we can cast Freeze then cast cold snap so we can get a 
    -- water elm back asap
    if(btp_get_spell_id_pet("Freeze")) then
		if(btp_cast_spell("Cold Snap")) then return true; end
    end

	-- if we have brain freeze cast fireball asap
	if(btp_mage_is_brain_freez()) then
		if(btp_cast_spell_on_target("Fireball", unit)) then return true; end
	end

	-- if(UnitAffectingCombat("player") and mana_level < .75) then
	if(UnitAffectingCombat(unit)) then
		if(btp_cast_spell_on_target("Summon Water Elemental", unit))then return true; end
	end

	-- check if they are up close
	if(btp_check_dist(unit, 3)) then
		if(btp_cast_spell_on_target("Frost Nova", unit))then return true; end
		if(btp_cast_spell_on_target("Fire Blast", unit))then return true; end
		-- if(btp_cast_spell_on_target("Cone of Cold", unit))then return true; end
		-- if(btp_cast_spell_on_target("Blink", unit))then return true; end
		if(btp_cast_spell_on_target("Arcane Explosion", unit))then return true; end
	end


	-- check if they are medium close
	if(btp_check_dist(unit, 2)) then
		if(btp_cast_spell_on_target("Ice Lance", unit))then return true; end
		if(btp_cast_spell_on_target("Fire Blast", unit))then return true; end
	end
	
	if(btp_check_dist(unit, 1)) then
		if(btp_cast_spell_on_target("Ice Lance", unit))then return true; end
		-- if(btp_cast_spell_on_target("Frostbolt", unit))then return true; end
	end

	return false;
end

function btp_mage_buff()
	for i = 1, GetNumPartyMembers() do
		nextPlayer = "party" .. i;
		cur_class = UnitClass(nextPlayer);
        -- btp_frame_debug("np: " .. nextPlayer);
		if(btp_check_dist(nextPlayer, 1) and not btp_mage_is_arcaneintellect(nextPlayer)) then
			if(btp_cast_spell_on_target("Arcane Intellect", nextPlayer))then return true; end
		end
	end
	for i = 1, GetNumRaidMembers() do
		nextPlayer = "raid" .. i;
		cur_class = UnitClass(nextPlayer);
		if(btp_check_dist(nextPlayer, 1) and not btp_mage_is_arcaneintellect(nextPlayer)) then
			if(btp_cast_spell_on_target("Arcane Brilliance", nextPlayer))then return true; end
			if(btp_cast_spell_on_target("Arcane Intellect", nextPlayer))then return true; end
		end
	end
	return false;
end

function btp_mage_is_manashield(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("DetectLesserInvisibility", unit)) then return true; end
	return false;
end

function btp_mage_is_arcanepotency(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("ArcanePotency", unit)) then return true; end
	return false;
end

function btp_mage_is_icearmor(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("FrostArmor02", unit)) then return true; end
	return false;
end

function btp_mage_is_magearmor(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("MageArmor", unit)) then return true; end
	return false;
end

function btp_mage_is_brain_freez(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("BrainFreeze", unit)) then return true; end
	return false;
end

function btp_mage_is_icebarrier(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("Ice_Lament", unit)) then return true; end
	return false;
end

function btp_mage_is_arcaneintellect(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("ArcaneIntellect", unit)) then return true; end
	if(btp_check_buff("MagicalSentry", unit)) then return true; end
	return false;
end

function btp_mage_is_frostward(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("FrostWard", unit)) then return true; end
	return false;
end

function btp_mage_is_frozen(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_debuff("Frost_FrostNova", unit)) then return true; end
	return false;
end

function btp_mage_is_slow(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_debuff("Nature_Slow", unit)) then return true; end
	return false;
end

function btp_mage_is_pom(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("EnchantArmor", unit)) then return true; end
	return false;
end

function btp_mage_is_shortmb(unit)
	if(not unit) then  unit = "player"; end
	if(btp_check_buff("MissileBarrage", unit)) then return true; end
	return false;
end


-- txt that waterbot will say
waterbot_txt    = { "Whisper me for free food/water",
                    "Free food and water, just msg me and i will open trade",
                    "Need a drink/food? Msg me i can help",
                    "Sick of paying for food/water. Just pay me a visit ill hook you up. Chat me up" };
WATERBREAK_MAX_BEG_INDEX = 4;

-- this function will turn waterbreak in to a water vendor
function btp_mage_waterbreak()
	if ((GetTime() - lastBeg) >= 120) then
		lastBeg = GetTime();
		i = math.random(WATERBREAK_MAX_BEG_INDEX);
		SendChatMessage(waterbot_txt[i], "SAY", nil);
	end

	if(not btp_mage_is_arcaneintellect("target") and UnitName("target") ~= nil) then
		if(btp_cast_spell_on_target("Arcane Intellect", "target")) then return true; end
	end

	if(btp_cnt_item("Conjured Glacier Water") < 8) then
		if(btp_cast_spell("Conjure Water")) then return true; end;
	end

	if(btp_cnt_item("Conjured Croissant") < 8) then
		if(btp_cast_spell("Conjure Food")) then return true; end;
	end
	targetOnMount = true;
	return false;
end

function btp_mage_waterbreak_start(arg1, arg2, arg3, arg4, arg5, arg6)
	if(btp_check_dist(followPlayer, 2) and not DPS_MODE_ON) then
		btp_target_map(arg2);
		WATERBREAK_USER = arg2;
		WATERBREAK_CMD = arg1;
	end


end

-- this only does stacks does not count num items in stack
function btp_cnt_item(item)
	cnt = 0;
	for bag=0,4 do
		for slot=1, C_Container.GetContainerNumSlots(bag) do
			cur_item = C_Container.GetContainerItemLink(bag, slot);
			if(cur_item) then
				if(string.find(cur_item, item)) then
					cnt = cnt + 1;
				end
			end
		end
	end
	return cnt;
end

-- function btp_mage_waterbreak_trade(arg1, arg2, arg3, arg4, arg5, arg6)
function btp_mage_waterbreak_trade(unit)
	-- btp_frame_debug("1: " .. arg1 .. " 2: " .. arg2 .. " 3: " .. arg3);
-- 	if(string.find(string.lower(arg1), "water")) then
-- 		btp_target_map(t_name)

--		cur_class = UnitClass(unit);
--

		btp_trade_item("Conjured Glacier Water", unit, 2);
		btp_trade_item("Conjured Croissant", unit, 2);


--		if(UnitPowerType(unit) == "Mana" or cur_class == "Druid") then
--		end


		-- TradeItem(btp_trade_item("Conjured Glacier Water"), arg2);
-- 	end
end

function btp_trade_item(item, unit, num)
-- function btp_trade_item(item)

	if(not num) then
		num = 1;
	end

	cnt = 0;
	for bag=0,4 do
		for slot=1, C_Container.GetContainerNumSlots(bag) do
			cur_item = C_Container.GetContainerItemLink(bag, slot);
			if(cur_item) then
				if(string.find(cur_item, item)) then
					cnt = cnt + 1;
 					-- btp_frame_debug("btp_trade_item: found " .. cur_item .. " bag: " .. bag .. " slot: " .. slot);
 					PickupContainerItem(bag, slot);
 
 					if(CursorHasItem()) then
 						DropItemOnUnit("target");
 					end
					if(cnt >= num) then
						return true;
					end
				else
					-- btp_frame_debug("btp_trade_item: list-" .. cur_item);
				end
			end
		end
	end
	btp_frame_debug("btp_trade_item: " .. item .. " not found!");
	return false;
end





function btp_target_map(t_name)
    if (t_map == nil) then
        t_map = CreateFrame("Button", "m_target", nil,
                            "SecureActionButtonTemplate");
        t_map:RegisterForClicks("AnyUp");                 
    end

    t_map:SetAttribute("type", "macro");
    t_map:SetAttribute("macrotext", "/targetexact " ..  t_name ..  "\n");
    SetBindingClick("ALT-CTRL-SHIFT-9", "m_target");
    fuckBlizMapping["WATERBREAK"] = "ALT-CTRL-SHIFT-9";
    FuckBlizzardByName("WATERBREAK");
end




