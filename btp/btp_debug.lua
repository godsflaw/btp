BTP_DISPLAY_DEBUG_BOX = 0;
-- used to track debug messages
BTP_DEBUG_MESSAGES = {};


function btp_debug_load()
    print ("debug laoded");
end

function btp_debug(msg)
    local match_debug = btp_config_get("MATCH_DEBUG");
    if (match_debug == nil or not match_debug) then return false; end;

    local callstack = debugstack(2, 1, 0)
    if (not callstack or callstack == nil) then callstack = "none"; end
    -- this is not perfect but i'm to lazy to figure out why its not always working correctly
    local file, line, function_name = string.match(callstack, "%[string \"@Interface/AddOns/(.+)\"%]:(%d+): in function [`<](.-)['>]")
    if (not file or file == nil) then file = "-"; end;
    if (not line or line == nil) then line = "-"; end;
    if (not function_name or function_name == nil) then function_name = "-"; end;

    local output = file .. ":" .. line .. ":"  .. function_name .. " - " .. msg;
    if (strmatch(output, match_debug)) then
        -- stopped printing since it was too verbose and vanished too quickly.
        -- print(msg);
        table.insert(BTP_DEBUG_MESSAGES, file .. ":" .. line .. ":"  .. function_name .. " - " .. msg);
        if (file == '-') then table.insert(BTP_DEBUG_MESSAGES, "MISS: " .. callstack); end;
        if (#BTP_DEBUG_MESSAGES > 1000) then
            table.remove(BTP_DEBUG_MESSAGES, 1);
        end
    end
end


function btp_debug_old(msg)
    local match_debug = btp_config_get("MATCH_DEBUG");
    if (match_debug == nil or not match_debug) then return false; end
    if (strmatch(msg, match_debug)) then
        -- stopped printing since it was too verbose and vanished too quickly.
        -- print(msg);
        table.insert(BTP_DEBUG_MESSAGES, msg);
        if (#BTP_DEBUG_MESSAGES > 2000) then
            table.remove(BTP_DEBUG_MESSAGES, 1);
        end
    end
end

function print_sorted_table(data, sortByIndex)
    -- only ever open the box once, could modify this to append
    if (BTP_DISPLAY_DEBUG_BOX > 0) then
        btp_frame_debug("DISPLAY_DEBUG_BOX: called " .. BTP_DISPLAY_DEBUG_BOX)
        return;
    end
    BTP_DISPLAY_DEBUG_BOX = BTP_DISPLAY_DEBUG_BOX + 1

    -- Create a Frame
    local frame = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate")
    frame:SetSize(800, 500) -- Set the size of the frame
    frame:SetPoint("CENTER") -- Position the frame at the center of the screen
    frame:SetBackdrop({
        bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
        edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 8, right = 8, top = 8, bottom = 8 }
    })

    -- Create a ScrollFrame
    local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
    scrollFrame:SetSize(760, 460) -- Set the size of the scroll frame
    scrollFrame:SetPoint("CENTER") -- Position the scroll frame at the center of the frame

    -- Create an EditBox
    local editBox = CreateFrame("EditBox", nil, scrollFrame)
    editBox:SetMultiLine(true)
    editBox:SetFontObject(GameFontNormal) -- Set the font
    editBox:SetWidth(scrollFrame:GetWidth())
    editBox:SetMaxLetters(99999)

    -- Create a Close Button
    local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
    closeButton:SetScript("OnClick", function()
        frame:Hide()
        editBox:SetText("");
        BTP_DISPLAY_DEBUG_BOX = 0;
    end)

    -- Set the ScrollFrame's child to be the EditBox
    scrollFrame:SetScrollChild(editBox)

    -- Create a table to store the keys
    local keys = {}
    for key in pairs(data) do 
        table.insert(keys, key)
    end
    if sortByIndex then
        table.sort(keys)
    else
        -- Sort the keys based on the values in fuckBlizMapping
        table.sort(keys, function(a, b) return data[a] < data[b] end)
    end
    -- Print the key-value pairs in sorted order
    for _, key in ipairs(keys) do
        editBox:Insert(tostring(data[key]) .. " val: " .. key .."\n")
    end
end

function btp_print_nearby_nameplates()
    for nextPlayer in btp_iterate_nearby_players() do
        print("NamePlate: " .. UnitName(nextPlayer) .. " - " .. nextPlayer);
    end
end

function btp_debug_print_spellbooks(spell)
    print_sorted_table(btp_build_valid_spellbook(BOOKTYPE_SPELL));
    print_sorted_table(btp_build_valid_spellbook(BOOKTYPE_PET));
end

-- i cant figure out a better way to do this
local BTP_SPELL_LEVEL_MAX = { };
function btp_validate_heal_spell_rank()
    for spellName, spellRanks in pairs(BTP_SPELL_LEVEL_REQ) do
        btp_frame_debug("Checking " .. spellName);
        for rank = 1, #spellRanks do
            local spellRankName = spellName .. "(Rank " .. rank .. ")";
            btp_frame_debug("Checking " .. spellRankName);
            if (btp_cast_spell_on_target(spellRankName, "player")) then
                BTP_SPELL_LEVEL_MAX[spellRankName] = true;
                btp_fram_debug("Rank " .. rank .. " of " .. spellName .. " is available")
            else
                break;
            end
        end
    end
    print_sorted_table(BTP_SPELL_LEVEL_MAX);
end

