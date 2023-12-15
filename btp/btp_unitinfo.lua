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
-- You should not need to change anything below this line.
--

-- the unit info for "player"
BTP_PLAYER_INFO = {};

BTP_UNITINFO_USE_CACHE = true;
-- BTP_PLAYER_INFO = btp_unitinfo_get("player");
-- Create an empty table to store the ordered player info
BTP_UNITINFO_PRIORITY_ORDER = {}
BTP_UNITINFO = {}


function btp_unitinfo_load()
    btp_frame_debug("unitinfo loaded");
end

function btp_unitinfo_print_all()
    local output = {}
    local sortedKeys = {}

    for unit in pairs(BTP_UNITINFO) do
        table.insert(sortedKeys, unit)
    end

    table.sort(sortedKeys)

    for _, unit in ipairs(sortedKeys) do
        local info = BTP_UNITINFO[unit]
        local infoStr = "Unit: " .. unit
        for key, value in pairs(info) do
            infoStr = infoStr .. ", " .. key .. ": " .. tostring(value)
        end
        table.insert(output, infoStr)
    end

    print_sorted_table(output)
end

-- used to loop over just the values of the table
function btp_unitinfo_value_iterator(t)
    local key = nil
    return function()
        key, value = next(t, key)
        return value
    end
end

-- used to loop over just the unitinfo keys
function btp_unitinfo_key_iterator(t)
    local key = nil
    return function()
        key = next(t, key)
        return key
    end
end

-- gives you key, value
function btp_unitinfo_iterator()
    return pairs(BTP_UNITINFO)
end

-- used to update unit info for all friendly targets
function btp_unitinfo_update()
    -- never run in combat since it should be unessary
    if (btp_unit_in_combat("player")) then return false; end
    for nextPlay in btp_iterate_friendly_targets() do
        unit = btp_unitinfo_get(nextPlay);
    end
end

function btp_unitinfo_purge(interval)
    local currentTime = GetTime()
    for key, unit in pairs(BTP_UNITINFO) do
        if currentTime - unit.updated > interval then
            btp_debug("btp_unitinfo_purge - purging: " .. key .. " after " .. interval)
            BTP_UNITINFO[key] = nil
        end
    end
end

-- Function to get unit info
-- TODO: make get_unitinfo(unit | unit_name) both work
-- it should be keyed by both. Not every unitinfo will have a unit_id
-- since in ROAMING mode the target may not be in any party
function btp_unitinfo_get(unit)
    
    -- only run if the unit exists
    if (not UnitExists(unit)) then return false; end

    -- make sure we are passed a unit not a name
    if (not btp_is_unitid(unit)) then
        btp_debug("btp_unitinfo_get - passed a non-valid unit: " .. unit)
        return false;
    end

    -- only track players, perhsps we will want NPC's in the future
    if (not UnitPlayerControlled(unit)) then return false; end

    local unit_name = UnitName(unit);
    local unit_in_combat = btp_unit_in_combat(unit);
    local player_in_combat = btp_unit_in_combat("player");

    -- use cache if enabled and if we and the target are not in combat
    if (BTP_UNITINFO_USE_CACHE and
        BTP_UNITINFO[unit_name] and
        not player_in_combat and
        not unit_in_combat) then
        local record_age = GetTime() - BTP_UNITINFO[unit_name].updated;
        -- never use data older than 1 second
        if (record_age < 10) then
            btp_debug("get_unitinfo - using cached info for " .. unit_name);
            return BTP_UNITINFO[unit_name];
        end
    end

    -- check if the unit already exits
    -- Add the unit info to the BTP_UNITS dictionary
    local unit_health = UnitHealth(unit);
    local unit_health_max = UnitHealthMax(unit);
    local unit_percent = unit_health/unit_health_max;
    local unit_class = UnitClass(unit);
    local unit_priority = 100;
    local unit_type = function() 
        if (UnitIsPlayer(unit)) then return "player"; end
        if (UnitIsBattlePet(unit)) then return "pet"; end
        return "unknown";
    end;

    -- always prioritize ourself
    if (unit == "player") then unit_priority = 100; end
    if (pcount) then
        -- Loop over priority and subtract the priority index from unit_priority
        for index, priority in ipairs(PRIORITY_G) do
            unit_priority = unit_priority - index
        end
    end
    for index, class in ipairs(BTP_BASIC_PRIORITIES) do
        if class == unit_class then
            unit_priority = unit_priority - index
            break
        end
    end

    -- always set pet to lowest priority, should only ever get HOTs
    if (unit_type == "pet") then unit_priority = 1; end

    local unit_is_party = btp_is_party_unit(unit) or false;
    btp_debug("btp_get_info - adding.. " .. unit_name);
    BTP_UNITINFO[unit_name] = {
        updated = GetTime(),
        name = unit_name,
        class = unit_class,
        health = unit_health,
        heahth_max = unit_health_max,
        health_percent = unit_percent,
        in_combat = unit_in_combat,
        type = unit_type,
        party_unit = unit_is_party,
        -- this would call a recursive loop since it callse get_unitinfo
        -- priority = btp_check_heal_priority(unit),
        threat = UnitThreatSituation(unit),
        connected = UnitIsConnected(unit),
        level = UnitLevel(unit)
    }
    return BTP_UNITINFO[unit_name];
end

---
--- unused
---

function btp_check_heal_priority(unit)
    local unitinfo = btp_unitinfo_get(unit);

    local priority = 0;
    -- we are always the highest priority
    if (btp_unit_is_player(unitinfo)) then return 1; end
    -- now check if we set a priority list
    for i = 1, pcount do
        if (unit == priority[i]) then
            return i;
        end
    end
    if (pcount) then priority = pcount + 1; end

    -- take a stab at priority if we dont have defined list
    local unitClass = UnitClass(unit)
    for i, class in ipairs(BTP_BASIC_PRIORITIES) do
        if class == unitClass then
            priority = i
            break
        end
    end

    return priority
end

function btp_unitinfo_get_priority(unitinfo)
    if (unitinfo == nil) then return nil; end
    if (btp_unitinfo_needs_crit(unitinfo)) then return unitinfo; end
    for next_unit in BTP_UNITINFO do
        -- if the unit is not in combat then not a high priority
        if (not next_unit.in_combat) then return next_unit; end
        -- if the unit is critically low on health they are a priority
        if (next_unit.health_percent < 35) then return next_unit; end
    end
    return unitinfo;
end



function btp_unitinfo_needs_small(unitinfo)
    if (unitinfo.health_percent < 98) then return true; end
    return false;
end

function btp_unitinfo_needs_medium(unitinfo)
    if (unitinfo.health_percent < 85) then return true; end
    return false;
end

function btp_unitinfo_needs_large(unitinfo)
    if (unitinfo.health_percent < 65) then return true; end
    return false;
end

function btp_unitinfo_needs_crit(unitinfo)
    local health_percent = unitinfo.health_percent
    if (health_percent < 35) then return true; end
    return false;
end

function btp_unitinfo_get_by_name(unit_name)
    for _, next_unit in pairs(BTP_UNITINFO) do
        if (next_unit.name == unit_name) then return next_unit; end
    end
    return nil;
end

