TYPE_BOOL = "bool";
TYPE_STRING = "string";
TYPE_INT = "int";

CONFIG_OPTS = { };
-- are we in debug mode
CONFIG_OPTS["DEBUG"] = { };
CONFIG_OPTS["DEBUG"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["DEBUG"]["VALUE"] = false;
CONFIG_OPTS["DEBUG"]["DESC"] = "PVP mode On/Off";

-- btp_debug will run print any msgs matching the pattern
CONFIG_OPTS["MATCH_DEBUG"] = { };
CONFIG_OPTS["MATCH_DEBUG"]["TYPE"] = TYPE_STRING;
CONFIG_OPTS["MATCH_DEBUG"]["VALUE"] = ".*";
CONFIG_OPTS["MATCH_DEBUG"]["DESC"] = "Pattern to match in btp_debug, default .*";

-- is the bot in pvpmode
CONFIG_OPTS["PVP"] = { };
CONFIG_OPTS["PVP"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["PVP"]["VALUE"] = true;
CONFIG_OPTS["PVP"]["DESC"] = "PVP mode On/Off";
-- should the bot heal people
CONFIG_OPTS["HEAL"] = { };
CONFIG_OPTS["HEAL"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["HEAL"]["VALUE"] = true;
CONFIG_OPTS["HEAL"]["DESC"] = "Healing On/Off";
-- should the bot buff people
CONFIG_OPTS["BUFF"] = { };
CONFIG_OPTS["BUFF"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["BUFF"]["VALUE"] = true;
CONFIG_OPTS["BUFF"]["DESC"] = "Buffing On/Off";
-- should the bot stop while casting a spell that chanels
CONFIG_OPTS["STOP"] = { };
CONFIG_OPTS["STOP"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["STOP"]["VALUE"] = true;
CONFIG_OPTS["STOP"]["DESC"] = "Stop while casting On/Off";
-- should the bot use potions
CONFIG_OPTS["POT"] = { };
CONFIG_OPTS["POT"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["POT"]["VALUE"] = true;
CONFIG_OPTS["POT"]["DESC"] = "Drink Potions On/Off";
-- should we only heal priority targets
CONFIG_OPTS["PRIORITY_ONLY"] = { };
CONFIG_OPTS["PRIORITY_ONLY"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["PRIORITY_ONLY"]["VALUE"] = false;
CONFIG_OPTS["PRIORITY_ONLY"]["DESC"] = "Only heal priority targets On/Off";
-- should we heal party pets
CONFIG_OPTS["HEAL_PETS"] = { };
CONFIG_OPTS["HEAL_PETS"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["HEAL_PETS"]["VALUE"] = true;
CONFIG_OPTS["HEAL_PETS"]["DESC"] = "Heal party pets On/Off";
-- who the bot should follow
CONFIG_OPTS["FOLLOW"] = { };
CONFIG_OPTS["FOLLOW"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["FOLLOW"]["VALUE"] = true;
CONFIG_OPTS["FOLLOW"]["DESC"] = "Auto follow mode";
-- who the bot should follow
CONFIG_OPTS["FOLLOW_GUILD"] = { };
CONFIG_OPTS["FOLLOW_GUILD"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["FOLLOW_GUILD"]["VALUE"] = true;
CONFIG_OPTS["FOLLOW_GUILD"]["DESC"] = "Auto follow guild members if higher priority is not around";
-- who the bot should follow
CONFIG_OPTS["FOLLOW_NAME"] = { };
CONFIG_OPTS["FOLLOW_NAME"]["TYPE"] = TYPE_STRING;
CONFIG_OPTS["FOLLOW_NAME"]["VALUE"] = false;
CONFIG_OPTS["FOLLOW_NAME"]["DESC"] = "Who to follow";
-- should the bot drink it's watter
CONFIG_OPTS["DRINK"] = { };
CONFIG_OPTS["DRINK"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["DRINK"]["VALUE"] = true;
CONFIG_OPTS["DRINK"]["DESC"] = "Drink Watter On/Off";
-- should we check distance when look for targets
CONFIG_OPTS["DISTANCE_CHECK"] = { };
CONFIG_OPTS["DISTANCE_CHECK"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["DISTANCE_CHECK"]["VALUE"] = true;
CONFIG_OPTS["DISTANCE_CHECK"]["DESC"] = "Distance Check On/Off";
-- the bot will attack your target when in combat
CONFIG_OPTS["DPS"] = { };
CONFIG_OPTS["DPS"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["DPS"]["VALUE"] = false;
CONFIG_OPTS["DPS"]["DESC"] = "DPS mode On/Off";
-- the bot will auto accept gourp invites and trades
CONFIG_OPTS["ACCEPT"] = { };
CONFIG_OPTS["ACCEPT"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["ACCEPT"]["VALUE"] = true;
CONFIG_OPTS["ACCEPT"]["DESC"] = "Auto Accept On/Off";
-- the bot will auto accept gourp invites and trades
CONFIG_OPTS["CASTING_STOP"] = { };
CONFIG_OPTS["CASTING_STOP"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["CASTING_STOP"]["VALUE"] = true;
CONFIG_OPTS["CASTING_STOP"]["DESC"] = "When a spell is cast that channels, stop moving. If disabled the bot will continue to move which breaks casting if its following a player.";
-- add a timeout for all casting callbacks just in case it gets stuck
CONFIG_OPTS["CB_TIMEOUT"] = { };
CONFIG_OPTS["CB_TIMEOUT"]["TYPE"] = TYPE_INT;
CONFIG_OPTS["CB_TIMEOUT"]["VALUE"] = 6;
CONFIG_OPTS["CB_TIMEOUT"]["DESC"] = "Timeout for all casting callbacks";
-- the bot will auto accept gourp invites and trades
CONFIG_OPTS["ROAMING"] = { };
CONFIG_OPTS["ROAMING"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["ROAMING"]["VALUE"] = false;
CONFIG_OPTS["ROAMING"]["DESC"] = "Roaming On/Off - if the bot is in roaming mode it will help/follow anyone it encounters";
-- the bot will auto accept gourp invites and trades
CONFIG_OPTS["FOLLOW_JUMP_INTERVAL"] = { };
CONFIG_OPTS["FOLLOW_JUMP_INTERVAL"]["TYPE"] = TYPE_INT
CONFIG_OPTS["FOLLOW_JUMP_INTERVAL"]["VALUE"] = 3;
CONFIG_OPTS["FOLLOW_JUMP_INTERVAL"]["DESC"] = "when following a player, the bot will jump every X seconds, if the bot starts to get further away";
-- the bot will conserve mana at this threshold
CONFIG_OPTS["MANA_LOW"] = { };
CONFIG_OPTS["MANA_LOW"]["TYPE"] = TYPE_INT;
CONFIG_OPTS["MANA_LOW"]["TYPE"] = TYPE_INT;
CONFIG_OPTS["MANA_LOW"]["VALUE"] = .45;
CONFIG_OPTS["MANA_LOW"]["DESC"] = "Bot threshold to stop dpsing and drink mana potions, if out of combat";

CONFIG_OPTS["USE_SPELL_CALLBACKS"] = { };
CONFIG_OPTS["USE_SPELL_CALLBACKS"]["TYPE"] = TYPE_BOOL;
CONFIG_OPTS["USE_SPELL_CALLBACKS"]["VALUE"] = true;
CONFIG_OPTS["USE_SPELL_CALLBACKS"]["DESC"] = "Use spell callbacks to stop moving or cancel casting";


function btp_config_load()
    print ("debug loaded");
end

-- check an option in CONFIG_OPTS
function btp_config_get(optname)
    if (optname == nil) then
        btp_frame_debug("btp_config_get: nil optname");
        return false;
    end
    if (CONFIG_OPTS[optname] == nil) then
        btp_frame_debug("Unknown option: " .. optname);
        return false;
    end
    if (CONFIG_OPTS[optname]["VALUE"] == nil) then
        btp_frame_debug("No value for option: " .. optname);
        return false;
    end 
    return CONFIG_OPTS[optname]["VALUE"];
end

-- TODO: make a slash command to set these
function btp_config_set(optname, value)
    -- make sure types look right first
    CONFIG_OPTS[optname]["VALUE"] = value;
end

function btp_print_config()
    -- Get and sort the option names
    local optnames = {}
    for optname in pairs(CONFIG_OPTS) do
        table.insert(optnames, optname)
    end
    table.sort(optnames)

    -- Print the options in alphabetical order
    for _, optname in ipairs(optnames) do
        local optvalue = CONFIG_OPTS[optname]
        print("Option name: " .. optname)
        for key, value in pairs(optvalue) do
            print("    " .. key .. ": " .. tostring(value))
        end
    end
end

-- creates a slash command for every CONFIG_OPTS /btpcfg_<key> <value_if_int_or_string>
-- bools are  toggled to
-- ints are set to the value
-- strings are set to the value
function create_config_opts_commands()
    for key, opt in pairs(CONFIG_OPTS) do
        local command = "BTPCFG_" .. string.upper(key)
        SlashCmdList[command] = function(msg)
            btp_frame_debug("BTPCFG_" .. string.upper(key) .. " " .. msg);
            btp_frame_debug("TYPE: " .. opt["TYPE"]);
            if opt["TYPE"] == TYPE_BOOL then
                opt["VALUE"] = not opt["VALUE"]
                print(key .. " toggled to: " .. tostring(opt["VALUE"]))
                btp_debug(key .. " toggled to: " .. tostring(opt["VALUE"]))
            elseif opt["TYPE"] == TYPE_INT then
                local new_value = tonumber(msg)
                if new_value then
                    opt["VALUE"] = new_value
                    print(key .. " updated to: " .. tostring(opt["VALUE"]))
                    btp_debug(key .. " updated to: " .. tostring(opt["VALUE"]))
                else
                    print("Invalid integer: " .. msg)
                    btp_debug("Invalid integer: " .. msg)
                end
            elseif opt["TYPE"] == TYPE_STRING then
                opt["VALUE"] = msg
                print(key .. " updated to: " .. tostring(opt["VALUE"]))
                btp_debug(key .. " updated to: " .. tostring(opt["VALUE"]))
            end
        end
        _G["SLASH_" .. command .. "1"] = "/btpcfg_" .. string.lower(key)
    end
end

-- WIP: works but i need to fix INT type data
function ShowConfigOptions()
    if _G["ConfigOptionsFrame"] then _G["ConfigOptionsFrame"]:Show(); return end
    local frame = CreateFrame("Frame", "ConfigOptionsFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(900, 900);
    frame:SetPoint("CENTER")

    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(860, 820);
    scrollFrame:SetPoint("TOP", 0, -30)
    local contentFrame = CreateFrame("Frame", nil, scrollFrame)
    contentFrame:SetSize(860, 820);
    scrollFrame:SetScrollChild(contentFrame)
    local yOffset = -10
    for optionName, optionData in pairs(CONFIG_OPTS) do
        local optionLabel = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        optionLabel:SetPoint("TOPLEFT", 10, yOffset)
        optionLabel:SetText(optionName)
    
        if optionData["TYPE"] == TYPE_BOOL then
            local checkbox = CreateFrame("CheckButton", nil, contentFrame, "ChatConfigCheckButtonTemplate")
            checkbox:SetPoint("TOPLEFT", 200, yOffset);
            checkbox:SetChecked(optionData["VALUE"]);
            checkbox:SetScript("OnClick", function(self)
                btp_config_set(optionName, self:GetChecked())
            end)
            yOffset = yOffset - 30;
        elseif optionData["TYPE"] == TYPE_INT then
            local editBox = CreateFrame("EditBox", nil, contentFrame, "InputBoxTemplate")
            editBox:SetPoint("TOPLEFT", 200, yOffset); editBox:SetSize(200, 30);
            local value = optionData["VALUE"]
            if value == nil then
                value = '0'
            end
            editBox:SetText(value);
            editBox:SetScript("OnEnterPressed", function(self)
                local text = self:GetText()
                btp_config_set(optionName, text == 'nil' and nil or tonumber(text))
                self:ClearFocus()
            end)
            yOffset = yOffset - 40
        elseif optionData["TYPE"] == TYPE_STRING then
            local editBox = CreateFrame("EditBox", nil, contentFrame, "InputBoxTemplate")
            editBox:SetPoint("TOPLEFT", 200, yOffset); editBox:SetSize(200, 30);
            local value = optionData["VALUE"]
            if value == nil then
                value = "nil"
            else
                value = tostring(value)
            end
            editBox:SetText(value)
            editBox:SetScript("OnEnterPressed", function(self)
                local text = self:GetText()
                btp_config_set(optionName, text == 'nil' and nil or text)
                self:ClearFocus()
            end)
            yOffset = yOffset - 40
        end
    end
    contentFrame:SetHeight(-yOffset + 10)
end


--[[

    UNUSED/TESTED

function ShowConfigOptions()
    if _G["ConfigOptionsFrame"] then _G["ConfigOptionsFrame"]:Show(); return end
    local frame = CreateFrame("Frame", "ConfigOptionsFrame", UIParent, "BasicFrameTemplateWithInset")
    frame:SetSize(900, 900);
    frame:SetPoint("CENTER")

    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(860, 820);
    scrollFrame:SetPoint("TOP", 0, -30)
    local contentFrame = CreateFrame("Frame", nil, scrollFrame)
    contentFrame:SetSize(860, 820);
    scrollFrame:SetScrollChild(contentFrame)
    local yOffset = -10
    local isOddRow = true

    for optionName, optionData in pairs(CONFIG_OPTS) do
        local bgColor = isOddRow and {0.2, 0.2, 0.2, 0.5} or {0.4, 0.4, 0.4, 0.5}
        if optionData["TYPE"] == TYPE_BOOL then
            local checkbox = CreateFrame("CheckButton", nil, contentFrame, "ChatConfigCheckButtonTemplate")
            checkbox:SetPoint("TOPLEFT", 10, yOffset);
            checkbox:SetChecked(optionData["VALUE"]);
            checkbox:SetScript("OnClick", function(self)
                btp_config_set(optionName, self:GetChecked())
            end)
            checkbox:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16})
            checkbox:SetBackdropColor(unpack(bgColor))
            yOffset = yOffset - 30;
        elseif optionData["TYPE"] == TYPE_INT then
            local editBox = CreateFrame("EditBox", nil, contentFrame, "InputBoxTemplate")
            editBox:SetPoint("TOPLEFT", 10, yOffset); editBox:SetSize(200, 30);
            local value = optionData["VALUE"]
            if value == nil then
                value = 0
            end
            editBox:SetText(tostring(value))
            editBox:SetScript("OnEnterPressed", function(self)
                local text = self:GetText()
                btp_config_set(optionName, text == 'nil' and nil or tonumber(text))
                self:ClearFocus()
            end)
            editBox:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16})
            editBox:SetBackdropColor(unpack(bgColor))
            yOffset = yOffset - 40
        elseif optionData["TYPE"] == TYPE_STRING then
            local editBox = CreateFrame("EditBox", nil, contentFrame, "InputBoxTemplate")
            editBox:SetPoint("TOPLEFT", 10, yOffset); editBox:SetSize(200, 30);
            local value = optionData["VALUE"]
            if value == nil then
                value = "nil"
            else
                value = tostring(value)
            end
            editBox:SetText(value)
            editBox:SetScript("OnEnterPressed", function(self)
                local text = self:GetText()
                btp_config_set(optionName, text == 'nil' and nil or text)
                self:ClearFocus()
            end)
            editBox:SetBackdrop({bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16})
            editBox:SetBackdropColor(unpack(bgColor))
            yOffset = yOffset - 40
        end
        isOddRow = not isOddRow
    end
    contentFrame:SetHeight(-yOffset + 10)
end

]]

