-- btp_frame.lua
--
-- This file is part of BTP.
-- 
-- BTP is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.

-- BTP is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with BTP.  If not, see <http://www.gnu.org/licenses/>.
-- 

-- Globals
cur_xpos_g = 0;
cur_ypos_g = 0;
fr_width_g = 75;
fr_height_g = 20;

function btp_frame_debug(msg)
	btp_debug("btp_frame_debug: " .. msg);
	DEFAULT_CHAT_FRAME:AddMessage(msg);
	UIErrorsFrame:AddMessage(msg, 1.0,1.0, 0, 1, 10);
end


function btp_next_cord()
	local curx;
	local cury;
	curx = cur_xpos_g;
	cury = cur_ypos_g;

	cur_xpos_g = cur_xpos_g + fr_width_g;
	-- btp_frame_debug("xpos: " .. curx .. " ypos: " .. cury);
	return curx, cury;
end

function btp_frame_init()
        btp_frame_set_color_hex("IT", "000011");
        btp_frame_set_color_hex("IA", "000022");
        btp_frame_set_color_hex("IPT", "000033");
        btp_frame_set_color_hex("CT", "000044");
        btp_frame_set_color_hex("CA", "000055");
        btp_frame_set_color_hex("CPT", "000066");
        btp_frame_set_color_hex("AT", "000077");
        btp_frame_set_color_hex("AA", "000088");
        btp_frame_set_color_hex("APT", "000099");
        btp_frame_set_color_hex("PT", "0000AA");
        btp_frame_set_color_hex("MA", "0000BB");
        btp_frame_set_color_hex("PA", "0000CC");
        btp_frame_set_color_hex("MP", "0000DD");
        btp_frame_set_color_hex("PPT", "0000EE");
end

function btp_frame_onload(self)
	local curx;
	local cury;
	local curw;
	local curh;
	curw = fr_width_g;
	curh = fr_height_g;

	btp_frame_debug("btp_frame: OnLoad");

	SLASH_BTP_FRAME1 = "/btp_frame";
	SLASH_BTP_FINIT1 = "/btp_finit";
	SLASH_BTP_DBG1 = "/btp_dbg";

	SlashCmdList["BTP_FRAME"] = function(cmdstr)
		-- btp_frame_debug("cmdstr: " .. cmdstr);
		btp_frame_runcmd(cmdstr);
	end;

	SlashCmdList["BTP_FINIT"] = btp_frame_init;

	SlashCmdList["BTP_DBG"] = function(cmdstr)
		-- btp_frame_debug(cmdstr);
	end;

	curx, cury = btp_next_cord();
	btp_frame_create("IT", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("IA", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("IPT", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("CT", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("CA", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("CPT", curx, cury, curw, curh);
                             
	curx, cury = btp_next_cord();
        btp_frame_create("AT", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("AA", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("APT", curx, cury, curw, curh);
                             
	curx, cury = btp_next_cord();
        btp_frame_create("PT", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("MA", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("PA", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("MP", curx, cury, curw, curh);

	curx, cury = btp_next_cord();
        btp_frame_create("PPT", curx, cury, curw, curh);
end

function footothebar()
	local curx;
	local cury;
end

function btp_frame_print_usage(cmdstr)
	--btp_frame_debug("/pk [0-9] [arg1 ... argn]");
end

function btp_frame_toggle(fname)
	local full_name = "btp_frame_" .. fname;
	local frame = getglobal(full_name)
	--btp_frame_debug(full_name);
	if(frame) then
		if(frame:IsVisible()) then
			frame:Hide();
		else
			frame:Show();
		end
	end
end

function btp_frame_onclick(arg1)
	id = this:GetID();
	--btp_frame_debug("btp_frame: onclick: " .. this:GetName() .. " ID: " .. id .. " Button: " .. arg1);
end

function btp_frame_runcmd(cmdstr)
	local args = explode(" ", cmdstr);
	local cmdnum = args[1];

	for argn,arg in pairs(args) do
		--btp_frame_debug("arg" .. argn .. ":" .. arg);
	end

	if(cmdnum == "1") then
		btp_frame_runcmd_1(args);
	elseif(cmdnum == "2") then
		btp_frame_runcmd_2(args);
	elseif(cmdnum == "3") then
		btp_frame_runcmd_3(args);
	elseif(cmdnum == "4") then
		btp_frame_runcmd_4(args);
	elseif(cmdnum == "5") then
		btp_frame_runcmd_5(args);
	elseif(cmdnum == "6") then
		btp_frame_runcmd_6(args);
	elseif(cmdnum == "7") then
		btp_frame_runcmd_7(args);
	elseif(cmdnum == "8") then
		btp_frame_runcmd_8(args);
	elseif(cmdnum == "9") then
		btp_frame_runcmd_9(args);
	elseif(cmdnum == "0") then
		btp_frame_runcmd_0(args);
	end

end

function btp_frame_create(arg_fname, curx, cury, curw, curh)
	local fname = "btp_frame_" .. arg_fname;
	-- btp_frame_debug("btp_frame_create: " .. fname .. " curx: " .. curx .. " cury: " .. cury .. " curw: " .. curw .. " curh: " .. curh);

	-- local f = CreateFrame("FRAME",fname,UIParent);
	local f = CreateFrame("FRAME", fname, UIParent, BackdropTemplateMixin and "BackdropTemplate");
	f:SetWidth(curw); f:SetHeight(curh);
	f:SetPoint("TOPLEFT",UIParent, "TOPLEFT", curx, cury);
	f:SetBackdrop({
		bgFile = "Interface\\Addons\\btp\\white16x16", tile = true, tileSize = 16,
		edgeFile = "Interface\\Addons\\btp\\white16x16", edgeSize = 1,
		insets = {left = 1, right = 1, top = 1, bottom = 1},
	});
	f:SetBackdropBorderColor(0,0,0,0);
	f:SetBackdropColor(0,0,0,1);
	
	local fs = f:CreateFontString("$parentText","ARTWORK","GameFontNormal");
	fs:SetAllPoints();
	--fs:SetText(arg_fname);
end

function btp_frame_create_pos(arg_fname, curx, cury, curw, curh)
	local fname = "btp_frame_" .. arg_fname;
	-- btp_frame_debug("btp_frame_create: " .. fname .. " curx: " .. curx .. " cury: " .. cury .. " curw: " .. curw .. " curh: " .. curh);

	local f = CreateFrame("FRAME", fname, UIParent, BackdropTemplateMixin and "BackdropTemplate");
	f:SetWidth(curw); f:SetHeight(curh);
	f:SetPoint("CENTER",UIParent, "CENTER", curx, cury);
	f:SetBackdrop({
		bgFile = "Interface\\Addons\\btp\\white16x16", tile = true, tileSize = 16,
		edgeFile = "Interface\\Addons\\btp\\white16x16", edgeSize = 1,
		insets = {left = 1, right = 1, top = 1, bottom = 1},
	});
	f:SetBackdropBorderColor(0,0,0,0);
	f:SetBackdropColor(0,0,0,1);
	
	local fs = f:CreateFontString("$parentText","ARTWORK","GameFontNormal");
	fs:SetAllPoints();
	--fs:SetText(arg_fname);
end



function btp_frame_set_color(fname, red, green, blue)
	local full_name = "btp_frame_" .. fname;
	--btp_frame_debug("btp_frame_set_color: " .. full_name ..
        --                " = " .. red .. " " .. " " .. green .. " " .. blue);
	local frame = getglobal(full_name)
        if (frame and red and green and blue) then
	    frame:SetBackdropColor(red,green,blue);
        end
end

function btp_frame_set_color_hex(fname, hex)
        if (fname and hex) then
	    local rhex, ghex, bhex = string.sub(hex, 1, 2),
                                     string.sub(hex, 3, 4),
                                     string.sub(hex, 5, 6);
	    btp_frame_set_color(fname, tonumber(rhex, 16)/255,
                                       tonumber(ghex, 16)/255,
                                       tonumber(bhex, 16)/255);
        end
end

function btp_frame_set_text(fname, data)
	local full_name = "btp_frame_" .. fname;
	--btp_frame_debug("btp_frame_set_text: " .. full_name);
	local frame = getglobal(full_name)
	--frame:SetText(data);
end


-- create frame fname
function btp_frame_runcmd_1(args)
	--btp_frame_debug("btp_frame_runcmd_1");
	btp_frame_create(args[2], args[3], args[4], args[5], args[6]);
end

function btp_frame_runcmd_2(args)
	--btp_frame_debug("btp_frame_runcmd_2");
	--btp_frame_debug("toggle frame: " .. args[2]);
	btp_frame_toggle(args[2]);
end
function btp_frame_runcmd_3(args)
	--btp_frame_debug("btp_frame_runcmd_3");
	btp_frame_set_color(args[2], args[3], args[4], args[5]);
end
function btp_frame_runcmd_4(args)
	--btp_frame_debug("btp_frame_runcmd_4");
	btp_frame_set_color_hex(args[2], args[3]);
	
end
function btp_frame_runcmd_5(args)
	-- DOES NOT WORK YET
	--btp_frame_debug("btp_frame_runcmd_5");
	btp_frame_set_text(args[2], args[3]);
end
function btp_frame_runcmd_6(args)
	--btp_frame_debug("btp_frame_runcmd_6");
	btp_frame_init();
end
function btp_frame_runcmd_7(args)
	--btp_frame_debug("btp_frame_runcmd_7");
	--btp_frame_debug(args);
end
function btp_frame_runcmd_8(args)
	--btp_frame_debug("btp_frame_runcmd_8");
end
function btp_frame_runcmd_9(args)
	--btp_frame_debug("btp_frame_runcmd_9");
end
function btp_frame_runcmd_0(args)
	--btp_frame_debug("btp_frame_runcmd_0");
end

function explode(div,str)
	if (div=='') then return false end
	local pos,arr = 0,{};
	for st,sp in function() return string.find(str,div,pos,true) end do
		table.insert(arr,string.sub(str,pos,st-1))
		pos = sp + 1
	end
	table.insert(arr,string.sub(str,pos))
	return arr
end
