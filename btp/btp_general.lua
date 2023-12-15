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

POTION_COOLDOWN    = 121;
DEF_TRINK_SLOT     = 13;
PRIMARY_TRINK_SLOT = 14;

--
-- Globals
--
MAX_BEG_INDEX    = 23;
MAX_EMOTE_INDEX  = 114;
MAX_CHATTER      = 11967;
MAX_ANOY_MESSAGE = 5;
PRIORITY_ONLY    = false;


-- used for mage waterbot
WATERBREAK_USER = "";
mageisDrinking = false;

--
-- Energy Types
--
T_MANA   = 0;
T_RAGE   = 1;
T_ENERGY = 3;
T_COMBO  = 4;

--
-- Ints and Floats
--
lastExcludeBroadcast= 0;
lastShadowProtect   = 0;
lastFireProtect     = 0;
lastHolyProtect     = 0;
lastNatureProtect   = 0;
lastArcaneProtect   = 0;
lastPhysicalProtect = 0;
lastMagicProtect    = 0;
lastFreeAction      = 0;
lastInvulnerability = 0;
lastStealthDetect   = 0;
lastPoisonProtect   = 0;
lastFrostProtect    = 0;
lastHearth          = 0;
lastSummon          = 0;
lastInviteRequest   = 0;
lastSelfHeal        = 0;
lastBG              = 0;
lastInParty         = 0;
lastDice            = 0;
lastBeg             = 0;
lastBuff            = 0;
lastRelease         = 0;
lastQuestTrade      = 0;
lastMountCheck      = 0;
lastMountTry        = 0;
lastBotWater        = 0;
lastBooze           = 0;
lastChatter         = 0;
lastBinding         = 0;
lastDecurse         = 0;
lastBandage         = 0;
lastBackup          = 0;
lastCoordCheck      = 0;
lastNodeScan        = 0;
lastX               = 0;
lastY               = 0;
herbX               = 0;
herbY               = 0;
envRes              = 0;
duration            = 0;
start               = 0;
pcount              = 0;
fecount             = 0;
targetCount         = 0;
chatterCount        = 0;
herbTimer           = 0;
lastStopMoving      = 0;
lastBreakCC         = 0;
lastFarmBGTime      = 0;
lastDefendFlags     = 0;
lastJumpFollow      = 0;
lastCheckAFK        = 0;
lastFollowTime      = 0;
instanceTime        = 0;

--
-- Strings
--
manualFollowName  = "no one";
whisperPlayer     = "no one";
chatterPlayer     = "no one";
bootyName         = "no one";
chatterMessage    = "none";
doAssistUnit      = "target";
DPS_ASSIST_TARGET = "party1target";
doAssistUnitFor   = "";
bandageTarget     = "target";
current_cb_target = "target";
lootMode          = "pass";
btnCC             = nil;
equipItem         = nil;
freeBag           = nil;
freeSlot          = nil;
tradeName         = nil;
lastZone          = nil;

--
-- Bools
--
manualFollow      = false;
pvpBot            = false;
farmBG            = false;
farmDungeon       = false;
reloadUI          = false;
dontHearth        = false;
dontRelease       = false;
dontPop           = false;
addonCmd          = false;
doWarstomp        = false;
doEntangleRoot    = false;
doTreeForm        = false;
doHibernate       = false;
doFaerieFire      = false;
doCyclone         = false;
doShackle         = false;
doPsychicScream   = false;
doShadowWordPain  = false;
doShadowfiend     = false;
doLightwell       = false;
doCC              = false;
forceDrink        = false;
blockOnDecurse    = false;
stopMoving        = false;
okayClick         = false;
bootyCall         = false;
newChatter        = false;
doTrade           = false;
dontCheckDist     = false;
btpRaidHeal       = false;
earthShieldManual = false;
btpFollow         = true;
botOff            = true;
dontBeg           = true;
funTrink          = false;
botSelfHeal       = true;
okayDrink         = false;
okayMount         = false;

--
-- Function Pointers
--
local btp_player_model         = nil;
local btp_player_model_facing  = nil;
current_cb                     = nil;

--
-- Hashes
--
bgStats         = { };
cb_array        = { };
party_status    = { };
fuckBlizMapping = { };
keyToColor      = { };
targetToColor   = { };
guild_members   = { };
anoyMessage     = { "Hey can you leave me alone?  I am busy.",
                    "Look, I don't feel like talking right now.",
                    "Enough, I just want to play.",
                    "Blah, please stop.  I am busy.",
                    "Well it's been fun, but I want to get back to the game." };
beg             = { "Got a Gold?",
                    "Can someone spare some change for a veteran of the " ..
                    "Third Great War?",
                    "Buffs for some change?  I need change!",
                    "Spare some change or a few greens, I have kids to feed?!?",
                    "Please help me!  I need some change to buy a meal!",
                    "FREE BUFFS! If you can make a donation, I need money " ..
                    "for a shelter tonight.",
                    "Can anyone spare some change for a poor vagabond?",
                    "Did I ever tell you the one about the alliance hooker " ..
                    "with the dysentery ...",  
                    "A ghost mushroom walks into an inn, and the innkeeper " ..
                    "says, 'We don't serve your kind here!'  The ghost " ..
                    "mushroom says, 'Why not?!? I'm a fun guy!'",
                    "My partner died and my dog left me, got some spare " ..
                    "change for someone down on their luck?",
                    "I'll let you touch me for some change.",
                    "I will dance for tips.",
                    "Spare some change?  I have to feed my pet!",
                    "I can cure ugly for a gold.",
                    "why lie?  I need money for a Jug of Bourbon.",
                    "Spare some change for a flight?  I am broke.",
                    "I see change in your financial future, give me a gold " ..
                    "and I will tell you more.",
                    "Buy me a drink?",
                    "I've got a bad case of flesh rot!  Can you spare " ..
                    "some change so I can see a witchdoctor?",
                    "Got some change so I can buy booze?",
                    "Spare some change for a good cause?",
                    "Hey!  You got some change?  My eye fell out and I " ..
                    "need to get it replaced.",
                    "BOO! haha, did that scare you.  How about a tip?" };
emote           = { "ANGRY", "BARK", "BASHFUL", "BEG", "BURP", "BITE",
                    "BLINK", "KISS", "BLUSH", "BONK", "BORED", "BOUNCE",
                    "BOW", "CACKLE", "CHUCKLE", "COLD", "COMFORT", "COMMEND",
                    "CONFUSED", "COUGH", "CRY", "CUDDLE", "CURTSEY", "DANCE",
                    "BONK", "THREATEN", "DRINK", "DROOL", "TALKEX", "FART",
                    "FIDGET", "FLIRT", "GAZE", "GIGGLE", "HAPPY", "GRIN",
                    "GROAN", "GROWL", "GUFFAW", "HAIL", "HAPPY", "HELLO",
                    "HUG", "INSULT", "INTRODUCE", "KISS", "LAUGH", "LICK",
                    "LOVE", "MASSAGE", "MOAN", "MOCK", "MOO", "MOON",
                    "NOSEPICK", "PAT", "PEER", "POKE", "POUNCE", "PRAISE",
                    "PRAY", "PURR", "PUZZLE", "RASP", "ROAR", "ROFL",
                    "RUDE", "SALUTE", "SEXY", "SHAKE", "SHIMMY", "DRINK",
                    "SHIVER", "SHY", "JOKE", "SLAP", "STINK", "SMILE",
                    "SMIRK", "SNICKER", "SNIFF", "SNUB", "CRY", "CUDDLE",
                    "TAP", "TEASE", "THANK", "THIRSTY", "TICKLE", "TRAIN",
                    "VIOLIN", "WAVE", "CRY", "WHINE", "WHISTLE", "WINK",
                    "YAWN", "DRINK", "DRINK", "DRINK", "KISS", "KISS",
                    "KISS", "KISS", "DANCE", "DANCE", "DANCE", "DANCE",
                    "DANCE", "BEG", "BEG", "BEG", "BEG", "BEG", "COWER" };


-- heal spell ranks and minimum target levels, might  want to add buffs to this as well?
local BTP_SPELL_LEVEL_REQ = {
    ["Lesser Heal"] = {1, 1, 1}, -- Ranks 1-3
    ["Renew"] = {1, 10, 14, 20, 26, 32, 38}, -- Ranks 1-7
    ["Heal"] = {10, 16, 22, 28, 34}, -- Ranks 1-4
    ["Flash Heal"] = {16, 20, 26, 32, 38, 44, 50, 56, 60}, -- Ranks 1-9
    ["Greater Heal"] = {34, 40, 46, 52, 58, 60}, -- Ranks 1-6
    ["Prayer of Healing"] = {25, 30, 40, 50, 60}, -- Ranks 1-5
    ["Power Word: Fortitude"] = {1, 12, 24, 36, 48, 60}, -- Ranks 1-6
    ["Shadow Protection"] = {30, 42, 56}, -- Ranks 1-3
    -- Add any other healing spells and their ranks as necessary

    ["Rejuvenation"] = {4, 10, 16, 22, 28, 34, 40, 46, 52, 58, 60}, -- Ranks 1-11
    ["Regrowth"] = {12, 18, 24, 30, 36, 44, 52, 60}, -- Ranks 1-8
    ["Healing Touch"] = {1, 8, 14, 20, 26, 32, 38, 44, 50, 56, 60}, -- Ranks 1-11
    ["Tranquility"] = {20, 30, 40, 50, 60}, -- Ranks 1-5
    ["Swiftmend"] = {60}, -- Talent spell, only one rank
    -- Include other relevant Druid healing spells and their ranks as necessary

    ["Healing Wave"] = {1, 6, 12, 18, 24, 32, 40, 48, 56, 60}, -- Ranks 1-10
    ["Lesser Healing Wave"] = {20, 28, 36, 44, 52, 60}, -- Ranks 1-6
    ["Chain Heal"] = {40, 46, 54, 61}, -- Ranks 1-4
    -- Include other relevant Shaman healing spells and their ranks as necessary
 
    ["Holy Light"] = {1, 6, 14, 22, 30, 38, 46, 54, 60}, -- Ranks 1-9
    ["Flash of Light"] = {20, 26, 34, 42, 50, 58}, -- Ranks 1-6
    -- Include other relevant Paladin healing spells and their ranks as necessary
}

-- heal spell minimum heal ammounts.
local BTP_SPELL_MIN_HEAL = {
    ["Lesser Heal"] = {46, 71, 135}, -- Ranks 1-3
    ["Renew"] = {45, 100, 175, 245, 315, 400, 510}, -- Ranks 1-7
    ["Heal"] = {295, 429, 566, 712}, -- Ranks 1-4
    ["Flash Heal"] = {202, 269, 339, 414, 534, 662, 828, 958, 1101}, -- Ranks 1-9
    ["Greater Heal"] = {924, 1178, 1470, 1813, 2234, 2396}, -- Ranks 1-6
    ["Prayer of Healing"] = {312, 458, 675, 939, 1246}, -- Ranks 1-5

    ["Rejuvenation"] = {32, 56, 116, 180, 244, 304, 388, 488, 608, 756, 888}, -- Ranks 1-11
    ["Regrowth"] = {93, 176, 255, 336, 425, 534, 672, 839}, -- Ranks 1-8
    ["Healing Touch"] = {37, 88, 195, 363, 572, 742, 936, 1199, 1516, 1890, 2267}, -- Ranks 1-11
    ["Tranquility"] = {294, 455, 608, 765, 945}, -- Ranks 1-5
    ["Swiftmend"] = {900}, -- Talent spell, depends on Rejuvenation or Regrowth

    ["Healing Wave"] = {34, 64, 129, 268, 376, 536, 740, 1017, 1361, 1620}, -- Ranks 1-10
    ["Lesser Healing Wave"] = {162, 247, 337, 458, 631, 832}, -- Ranks 1-6
    ["Chain Heal"] = {320, 405, 551, 734}, -- Ranks 1-4

    ["Holy Light"] = {41, 76, 159, 310, 491, 698, 945, 1246, 1590}, -- Ranks 1-9
    ["Flash of Light"] = {67, 102, 140, 182, 235, 292}, -- Ranks 1-6
}

local BTP_SPELL_MANA_COST = {
    ["Lesser Heal"] = {30, 45, 75}, -- Ranks 1-3
    ["Renew"] = {30, 65, 105, 140, 170, 205, 250}, -- Ranks 1-7
    ["Heal"] = {155, 205, 255, 305}, -- Ranks 1-4
    ["Flash Heal"] = {125, 155, 185, 215, 265, 315, 380, 410, 450}, -- Ranks 1-9
    ["Greater Heal"] = {370, 455, 545, 655, 750, 800}, -- Ranks 1-6
    ["Prayer of Healing"] = {410, 560, 770, 1030, 1250}, -- Ranks 1-5

    ["Rejuvenation"] = {25, 40, 75, 105, 135, 160, 195, 235, 280, 335, 360}, -- Ranks 1-11
    ["Regrowth"] = {120, 205, 280, 350, 420, 510, 615, 740}, -- Ranks 1-8
    ["Healing Touch"] = {25, 55, 110, 185, 270, 335, 405, 495, 600, 720, 800}, -- Ranks 1-11
    ["Tranquility"] = {125, 175, 250, 335, 405}, -- Ranks 1-5
    ["Swiftmend"] = {999}, -- Talent spell, depends on Rejuvenation or Regrowth TODO: figure this out

    ["Healing Wave"] = {25, 45, 80, 155, 200, 265, 340, 440, 560, 620}, -- Ranks 1-10
    ["Lesser Healing Wave"] = {105, 145, 185, 200, 265, 340}, -- Ranks 1-6
    ["Chain Heal"] = {260, 315, 405, 540}, -- Ranks 1-4

    ["Holy Light"] = {35, 60, 110, 190, 275, 365, 465, 580, 660}, -- Ranks 1-9
    ["Flash of Light"] = {35, 50, 70, 90, 115, 140}, -- Ranks 1-6
}

-- these should be set per class in the init method
-- look at btp_priest_initalize() for an example.
BTP_CLASS_CALLBACKS = {};


function btp_macro_remove_heal_ranks()
    btp_frame_debug("btp_macro_remove_heal_ranks()");
    for spellName, spellRanks in pairs(BTP_SPELL_LEVEL_REQ) do
        for rank = 1, #spellRanks do
            local macroName = spellName .. "Rank" .. rank;
            if GetMacroInfo(macroName) then
                btp_frame_debug("Deleting macro: " .. macroName);
                DeleteMacro(macroName)
            end
        end
    end
end

function btp_general_initialize()
    btp_frame_debug("btp_general_initialize()");
    btp_macro_remove_heal_ranks();
    create_config_opts_commands();
    i       = 1;
    r       = 1;
    g       = 1;
    b       = 2;
    key     = "CTRL-";
    hex     = { "00","11","22","33","44","55","66","77","88","99","AA","BB",
                "CC","DD", "EE","FF" };
    letters = { "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O",
                "P","Q","R","S","T","U","V","W","X","Y","Z","`","-","=","[",
                "]",";","'",",",".","/","1","2","3","4","5","6","7","8",
                "9" };
    SlashCmdList["BTPDEBUG"] = function() print_sorted_table(BTP_DEBUG_MESSAGES, true); BTP_DEBUG_MESSAGES = {}; end
    SLASH_BTPDEBUG1 = "/btpdebug";
    SlashCmdList["BTPSOPT"] = function(msg)
        local args = {}
        for word in msg:gmatch("%S+") do table.insert(args, word) end
        if #args == 2 then
            btp_config_set(args[1], args[2])
        else
            print("Usage: /btpsopt <option> <value>")
        end
    end
    SLASH_BTPSOPT1 = "/btpsopt";
    SlashCmdList["BTPCC"] = btp_cc;
    SLASH_BTPCC1 = "/btpcc";
    SlashCmdList["FREEA"] = btp_free_action;
    SLASH_FREEA1 = "/fa";
    SlashCmdList["GENB"] = PrintBuffs;
    SLASH_GENB1 = "/printbuffs";
    SlashCmdList["BOT"] = btp_bot;
    SLASH_BOT1 = "/btpbot";
    SlashCmdList["BOTNEW"] = btp_helper_go;
    SLASH_BOTNEW1 = "/btpbotnew";
    SlashCmdList["BTPKEYMAP"] = function() btp_bind_keys(); print_sorted_table(fuckBlizMapping); end;
    SLASH_BTPKEYMAP1 = "/btpkeymap";

    SlashCmdList["BTPSTOP"] = BTP_Stop;
    SLASH_BTPSTOP1 = "/btpstop";
    SlashCmdList["BTPSTART"] = BTP_Start;
    SLASH_BTPSTART1 = "/btpstart";
    SlashCmdList["BTPFOL"] = BTP_Follow;
    SLASH_BTPFOL1 = "/btpfollow";
    SlashCmdList["BTPINV"] = BTP_Innervate;
    SLASH_BTPINV1 = "/btpinnervate";
    SlashCmdList["BTPPVP"] = BTP_Pvp;
    SLASH_BTPPVP1 = "/btppvp";
    SlashCmdList["BTPFARMBG"] = BTP_Farm_BG;
    SLASH_BTPFARMBG1 = "/btpfarmbg";
    SlashCmdList["BTPFARMDUNGEON"] = BTP_Farm_Dungeon;
    SLASH_BTPFARMDUNGEON1 = "/btpfarmdungeon";
    SlashCmdList["DONTBEG"] = DontBeg;
    SLASH_DONTBEG1 = "/btpbeg";
    SlashCmdList["DONTHRTH"] = DontHearth;
    SLASH_DONTHRTH1 = "/btphearth";
    SlashCmdList["RELEASE"] = DontRelease;
    SLASH_RELEASE1 = "/btprelease";
    SlashCmdList["POP"] = DontPop;
    SLASH_POP1 = "/btppop";
    SlashCmdList["DECURSE"] = DecurseToggle;
    SLASH_DECURSE1 = "/btpdecurse";
    SlashCmdList["RAIDHEAL"] = RaidHeal;
    SLASH_RAIDHEAL1 = "/btpraidheal";
    SlashCmdList["BTPINV"] = btp_invite;
    SLASH_BTPINV1 = "/btpinvite";
    SlashCmdList["CLEANFRM"] = CleanFrame;
    SLASH_CLEANFRM1 = "/cleanframe";
    SlashCmdList["HEALPRIORITYDEL"] = btp_heal_priority_del;
    SLASH_HEALPRIORITYDEL1 = "/btphpdel";
    SlashCmdList["HEALPRIORITYLIST"] = btp_heal_priority_list;
    SLASH_HEALPRIORITYLIST1 = "/btphplist";
    SlashCmdList["FEDEL"] = btp_follow_exclusion_del;
    SLASH_FEDEL1 = "/btpfedel";
    SlashCmdList["FELIST"] = btp_follow_exclusion_list;
    SLASH_FELIST1 = "/btpfelist";
    SlashCmdList["DISTCHECK"] = DistCheck;
    SLASH_DISTCHECK1 = "/btpdistcheck";

    SlashCmdList["HEALPRIORITYADD"] = function(pname)
        btp_heal_priority_add(pname)
    end;
    SLASH_HEALPRIORITYADD1 = "/btphpadd";

    SlashCmdList["FEADD"] = function(pname)
        btp_follow_exclusion_add(pname)
    end;
    SLASH_FEADD1 = "/btpfeadd";

    SlashCmdList["BTPLOOT"] = function(mode)
        btp_loot(mode)
    end;
    SLASH_BTPLOOT1 = "/btploot";
    SlashCmdList["DPSMODE"] = btp_dps_mode_toggle;
    SLASH_DPSMODE1 = "/dps";



    --
    -- This is a bind for the pet attack which does not 
    -- get bound normaly.  These are also the bot bindings.
    --
    keyToColor[key .. i] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    i = i + 1;
    keyToColor[key .. letters[i]] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    i = i + 1;
    keyToColor[key .. letters[i]] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    i = i + 1;
    keyToColor[key .. letters[i]] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    i = i + 1;
    keyToColor[key .. letters[i]] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    i = i + 1;
    keyToColor[key .. letters[i]] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    i = i + 1;

    --
    -- Bind the rest.
    --
    while true do
       keyToColor[key .. letters[i]] = hex[r] .. hex[g] .. hex[b];
       i = i + 1;

       if (i > 45 or (i > 36 and key == "CTRL-")) then
           if (key == "CTRL-") then
               key = "CTRL-SHIFT-";
           elseif (key == "CTRL-SHIFT-") then
               key = "ALT-";
           elseif (key == "ALT-") then
               key = "ALT-SHIFT-";
           elseif (key == "ALT-SHIFT-") then
               key = "ALT-CTRL-";
           elseif (key == "ALT-CTRL-") then
               key = "ALT-CTRL-SHIFT-";
           elseif (key == "ALT-CTRL-SHIFT-") then
               break;
           end

           i = 1;
       end

       r, g, b = RollRGB(r, g, b);
    end

    i = 1;

    --
    -- For player and pet targeting
    --
    targetToColor["player"] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    targetToColor["playertarget"] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    targetToColor["pet"] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    targetToColor["pettarget"] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    targetToColor["targetfriend"] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    targetToColor["targetenemy"] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);
    targetToColor["targettarget"] = hex[r] .. hex[g] .. hex[b];
    r, g, b = RollRGB(r, g, b);

    for i=1,40 do
        targetToColor["raid" .. i] = hex[r] .. hex[g] .. hex[b];
        r, g, b = RollRGB(r, g, b);
        targetToColor["raid" .. i .. "target"] = hex[r] .. hex[g] .. hex[b];
        r, g, b = RollRGB(r, g, b);
        targetToColor["raidpet" .. i] = hex[r] .. hex[g] .. hex[b];
        r, g, b = RollRGB(r, g, b);
        targetToColor["raidpet" .. i .. "target"] = hex[r] .. hex[g] .. hex[b];
        r, g, b = RollRGB(r, g, b);

        if (i < 5) then
            targetToColor["party" .. i] = hex[r] .. hex[g] .. hex[b];
            r, g, b = RollRGB(r, g, b);
            targetToColor["party" .. i .. "target"] = hex[r] .. hex[g] ..
                                                      hex[b];
            r, g, b = RollRGB(r, g, b);
            targetToColor["partypet" .. i] = hex[r] .. hex[g] .. hex[b];
            r, g, b = RollRGB(r, g, b);
            targetToColor["partypet" .. i .. "target"] = hex[r] .. hex[g] ..
                                                         hex[b];
            r, g, b = RollRGB(r, g, b);
        end
    end

    -- Create a table of all the Minimap's children objectSimpleCompass_Saved.
    local children = {Minimap:GetChildren()};

    for i=getn(children), 1, -1 do
        -- Iterate over them all, starting from the end of the list to
        -- see if the object reference is a model.
        -- If it is, and it has no name (in case some addon attached a
        -- model to it), it's probably the right one.
        if (children[i]:IsObjectType("Model") and
            not children[i]:GetName()) then
            -- Found, setting as the addon's local to keep the reference.
            btp_player_model = children[i];
            btp_player_model_facing = btp_player_model.GetFacing;
            return;
        end
    end
end

--
-- Complex type builder
--
local new, del;
do
    local list = setmetatable({}, {__mode='k'});
    function new(...)
        local t = next(list);
        if t then
            list[t] = nil;
            for i = 1, select('#', ...) do
                t[i] = select(i, ...);
            end
            return t;
        else
            return { ... };
        end
    end
    function del(t)
        for k in pairs(t) do
            t[k] = nil;
        end
        list[t] = true;
        return nil;
    end
end

local function btp_get_facing()
        return btp_player_model_facing(btp_player_model);
end


function btp_init_spells()
    local i = 1;

    -- btp_frame_debug("init spells");
    BTP_SPELLBOOK = btp_build_valid_spellbook(BOOKTYPE_SPELL);
    BTP_SPELLBOOK_PET = btp_build_valid_spellbook(BOOKTYPE_PET);
end

function FuckBlizzardTargetUnit(unit_id)
    if (fuckBlizMapping[unit_id]) then
        if (unit_id == "playertarget") then
           btp_frame_set_color_hex("PPT", keyToColor[fuckBlizMapping[unit_id]]);
        else
           btp_frame_set_color_hex("PT", keyToColor[fuckBlizMapping[unit_id]]);
        end
    else
        if (unit_id == "playertarget") then
            btp_frame_set_color_hex("PPT", targetToColor[unit_id]);
        else
            btp_frame_set_color_hex("PT", targetToColor[unit_id]);
        end
    end

    btp_frame_set_color_hex("IT", "FFFFFF");
end

function FuckBlizzardTargetUnitAlt(unit_id)
    if (fuckBlizMapping[unit_id]) then
        if (unit_id == "playertarget") then
           btp_frame_set_color_hex("APT", keyToColor[fuckBlizMapping[unit_id]]);
        else
           btp_frame_set_color_hex("AT", keyToColor[fuckBlizMapping[unit_id]]);
        end
    else
        if (unit_id == "playertarget") then
            btp_frame_set_color_hex("APT", targetToColor[unit_id]);
        else
            btp_frame_set_color_hex("AT", targetToColor[unit_id]);
        end
    end

    btp_frame_set_color_hex("IT", "FFFFFF");
end

function FuckBlizzardTargetUnitContainer(unit_id)
    if (fuckBlizMapping[unit_id]) then
        if (unit_id == "playertarget") then
           btp_frame_set_color_hex("CPT", keyToColor[fuckBlizMapping[unit_id]]);
        else
           btp_frame_set_color_hex("CT", keyToColor[fuckBlizMapping[unit_id]]);
        end
    else
        if (unit_id == "playertarget") then
            btp_frame_set_color_hex("CPT", targetToColor[unit_id]);
        else
            btp_frame_set_color_hex("CT", targetToColor[unit_id]);
        end
    end

    btp_frame_set_color_hex("IT", "FFFFFF");
end

--
-- As of right now this function is not used in the code.  There is
-- a hack in place that uses this frame to key events like pause and
-- exit.  This is also the frame that tells the macro program there
-- is an action to perform.  IF we ever need this frame in the future
-- we will have to code the hack the right way.  The IPT frame is also
-- used in the FuckBlizzardByNameStrange() function.  This frame is almost
-- never used, and so we can use it for strange things.  Again, if inventory
-- items should ever target, we will need to add more frames.  NOTE: there
-- are certainly reasons to use trinkets on other players, but for now we
-- do not do this anywhere.
--
function FuckBlizzardTargetUnitItem(unit_id)
    if (fuckBlizMapping[unit_id]) then
        if (unit_id == "playertarget") then
           btp_frame_set_color_hex("IPT", keyToColor[fuckBlizMapping[unit_id]]);
        else
           btp_frame_set_color_hex("IT", keyToColor[fuckBlizMapping[unit_id]]);
        end
    else
        if (unit_id == "playertarget") then
            btp_frame_set_color_hex("IPT", targetToColor[unit_id]);
        else
            btp_frame_set_color_hex("IT", targetToColor[unit_id]);
        end
    end

    btp_frame_set_color_hex("IT", "FFFFFF");
end

function FuckBlizzardByName(cmd)
    btp_debug("CMD: " .. cmd);
    if (fuckBlizMapping[cmd]) then
        btp_frame_set_color_hex("PA", keyToColor[fuckBlizMapping[cmd]]);
    end
    btp_frame_set_color_hex("IT", "FFFFFF");
end

function FuckBlizzardByNameAlt(cmd)
    if (fuckBlizMapping[cmd]) then
        btp_frame_set_color_hex("AA", keyToColor[fuckBlizMapping[cmd]]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    end
end

function FuckBlizzardByNameStrange(cmd)
    if (fuckBlizMapping[cmd]) then
        btp_frame_set_color_hex("IPT", keyToColor[fuckBlizMapping[cmd]]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    end
end

function FuckBlizzardAttackTarget()
    if (fuckBlizMapping["Attack"]) then
        btp_frame_set_color_hex("MA", keyToColor[fuckBlizMapping["Attack"]]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    end
end

function FuckBlizzardPetAttack()
    btp_frame_set_color_hex("MP", keyToColor["CTRL-1"]);
    btp_frame_set_color_hex("IT", "FFFFFF");
end

function FuckBlizUseInventoryItem(itemID)
    if (GetInventoryItemLink("player", itemID)) then
        itemName = string.gsub(GetInventoryItemLink("player", itemID),
                               "^.-%[(.*)%].*", "%1");
        btp_frame_set_color_hex("IA", keyToColor[fuckBlizMapping[itemName]]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    end
end

function FuckBlizUseContainerItem(bag, slot)
    if (C_Container.GetContainerItemLink(bag, slot)) then
        itemName = string.gsub(C_Container.GetContainerItemLink(bag, slot),
                               "^.-%[(.*)%].*", "%1");
        btp_frame_set_color_hex("CA", keyToColor[fuckBlizMapping[itemName]]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    end
end

function FuckBlizzardMove(action)
    if (action == "MOVEFORWARD") then
        btp_frame_set_color_hex("IA", keyToColor["CTRL-B"]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    elseif (action == "MOVEBACKWARD") then
        btp_frame_set_color_hex("IA", keyToColor["CTRL-C"]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    elseif (action == "TURNLEFT") then
        btp_frame_set_color_hex("IA", keyToColor["CTRL-D"]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    elseif (action == "TURNRIGHT") then
        btp_frame_set_color_hex("IA", keyToColor["CTRL-E"]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    elseif (action == "JUMP") then
        btp_frame_set_color_hex("IA", keyToColor["CTRL-F"]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    elseif (action == "DOWN") then
        btp_frame_set_color_hex("IA", keyToColor["CTRL-G"]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    elseif (action == "CLICK") then
        btp_frame_set_color_hex("IA", keyToColor["CTRL-H"]);
        btp_frame_set_color_hex("IT", "FFFFFF");
    end
end

local function btp_get_XY(id)
    return 100 * ((id % 10001) / 10000), 100 * (math.floor(id / 10001) / 10000);
end

function SetEquipItem(itemName)
    equipItem = itemName;
end

function btp_in_range(spell, target)
    if(spell == nil or target == nil) then return false; end

    name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon
    = GetSpellInfo(spell);

    -- check if its a valid spell
    if (spellID == nil) then
        return false;
    end

    if (maxRange == nil or maxRange == 0) then
        return true;
    end

    if (dontCheckDist) then
        return true;
    else
	    inRange = IsSpellInRange(spell, target);
        if (inRange and inRange == 1) then
            return true;
        else
            return false;
        end
    end
end

function btp_get_item(item)
    hasItem  = false;
    itemBag  = 0;
    itemSlot = 1;

    for bag=0,4 do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot)) then
          if (string.find(C_Container.GetContainerItemLink(bag,slot), item)) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasItem  = true;
                  itemBag  = bag;
                  itemSlot = slot;
              end
              break;
          end
        end
      end
    end

    return hasItem, itemBag, itemSlot;
end

function btp_check_dist(target, dist)
    if(target == nil or dist == nil) then return false; end

    if (dontCheckDist) then
        return true;
    else
	    return CheckInteractDistance(target, dist);
    end
end

function BTP_Decursive()
    hasMagicDebuff = false;
    hasDiseaseDebuff = false;
    hasCurseDebuff = false;
    hasPoisonDebuff = false;
    debuffPlayer = "player";

    for nextPet in btp_iterate_group_pets() do
        if (UnitExists(nextPet) and
            btp_check_dist(nextPet, 1)) then

            debuffName = "foo";
            j = 1;

            while (debuffName) do
                debuffName, debuffIcon, debuffCount, debuffType,
                debuffDuration, debuffTimeLeft, debuffMine, debuffStealable,
                debuffNameplateShowPersonal, spellId, canApplyAura, isBossDebuff,
                castByPlayer, nameplateShowAll, timeMod = UnitDebuff(nextPet, j);

                if (debuffName and
                    not strfind(debuffName, "Cripple") and
                    debuffType and strfind(debuffType, "Magic") and
                    not (UnitClass("player") == "Mage" or
                    UnitClass("player") == "Shaman")) then
                    hasMagicDebuff = true;
                    debuffPlayer = nextPet;
                end

                if (debuffName and debuffType and
                    strfind(debuffType, "Disease") and
                    not (UnitClass("player") == "Druid" or
                    UnitClass("player") == "Mage")) then
                    hasDiseaseDebuff = true;
                    debuffPlayer = nextPet;

                    --
                    -- NullifyDisease check
                    --
                    hasNullifyDisease, myNullifyDisease,
                    numNullifyDisease = btp_check_buff("NullifyDisease",
                                                       debuffPlayer);

                    if (hasNullifyDisease) then
                        hasDiseaseDebuff = false;
                    end
                end

                if (debuffName and debuffType and
                    strfind(debuffType, "Curse") and
                    not (UnitClass("player") == "Priest" or
                    UnitClass("player") == "Paladin" or
                    UnitClass("player") == "Shaman")) then
                    hasCurseDebuff = true;
                    debuffPlayer = nextPet;
                end

                if (debuffName and debuffType and
                    strfind(debuffType, "Poison") and
                    not (UnitClass("player") == "Priest" or
                    UnitClass("player") == "Mage")) then
                    hasPoisonDebuff = true;
                    debuffPlayer = nextPet;

                    --
                    -- NullifyPoison check
                    --
                    hasNullifyPoison, myNullifyPoison,
                    numNullifyPoison = btp_check_buff("NullifyPoison",
                                                      debuffPlayer);

                    if (hasNullifyPoison) then
                        hasPoisonDebuff = false;
                    end
                end

                j = j + 1;
            end
        end
    end

    for nextPlayer in btp_iterate_group_members() do
        if (btp_check_dist(nextPlayer, 1)) then
            debuffName = "foo";
            j = 1;

            while (debuffName) do
                --
                -- Players are more important
                --
                debuffName, debuffIcon, debuffCount, debuffType,
                debuffDuration, debuffTimeLeft, debuffMine, debuffStealable,
                debuffNameplateShowPersonal, spellId, canApplyAura, isBossDebuff,
                castByPlayer, nameplateShowAll, timeMod = UnitDebuff(nextPlayer, j);

                if (debuffName and not strfind(debuffName, "Cripple") and
                    debuffType and strfind(debuffType, "Magic") and
                    not (UnitClass("player") == "Mage" or
                    UnitClass("player") == "Shaman")) then
                    hasMagicDebuff = true;
                    debuffPlayer = nextPlayer;
                    break;
                end

                if (debuffName and debuffType and
                    strfind(debuffType, "Disease") and
                    not (UnitClass("player") == "Druid" or
                    UnitClass("player") == "Mage")) then
                    hasDiseaseDebuff = true;
                    debuffPlayer = nextPlayer;

                    --
                    -- NullifyDisease check
                    --
                    hasNullifyDisease, myNullifyDisease,
                    numNullifyDisease = btp_check_buff("NullifyDisease",
                                                       debuffPlayer);

                    if (hasNullifyDisease) then
                        hasDiseaseDebuff = false;
                    end

                    if (hasDiseaseDebuff) then
                        break;
                    end
                end

                if (debuffName and debuffType and
                    strfind(debuffType, "Curse") and
                    not (UnitClass("player") == "Priest" or
                    UnitClass("player") == "Paladin" or
                    UnitClass("player") == "Shaman")) then
                    hasCurseDebuff = true;
                    debuffPlayer = nextPlayer;
                    break;
                end

                if (debuffName and debuffType and
                    strfind(debuffType, "Poison") and
                    not (UnitClass("player") == "Priest" or
                    UnitClass("player") == "Mage")) then
                    hasPoisonDebuff = true;
                    debuffPlayer = nextPlayer;

                    --
                    -- NullifyPoison check
                    --
                    hasNullifyPoison, myNullifyPoison,
                    numNullifyPoison = btp_check_buff("NullifyPoison",
                                                      debuffPlayer);

                    if (hasNullifyPoison) then
                        hasPoisonDebuff = false;
                    end

                    if (hasPoisonDebuff) then
                        break;
                    end
                end

                j = j + 1;
            end
        end
    end

    debuffName = "foo";
    i = 1;

    while (debuffName) do
        --
        -- our pet
        --
        debuffName, debuffIcon, debuffCount, debuffType,
        debuffDuration, debuffTimeLeft, debuffMine, debuffStealable,
        debuffNameplateShowPersonal, spellId, canApplyAura, isBossDebuff,
        castByPlayer, nameplateShowAll, timeMod = UnitDebuff("pet", i);

        if (debuffName and not strfind(debuffName, "Cripple") and
            debuffType and strfind(debuffType, "Magic") and
            not (UnitClass("player") == "Mage" or
            UnitClass("player") == "Shaman")) then
            hasMagicDebuff = true;
            debuffPlayer = "pet";
            break;
        end

        if (debuffName and debuffType and
            strfind(debuffType, "Disease") and
            not (UnitClass("player") == "Druid" or
            UnitClass("player") == "Mage")) then
            hasDiseaseDebuff = true;
            debuffPlayer = "pet";

            --
            -- NullifyDisease check
            --
            hasNullifyDisease, myNullifyDisease,
            numNullifyDisease = btp_check_buff("NullifyDisease",
                                               debuffPlayer);

            if (hasNullifyDisease) then
                hasDiseaseDebuff = false;
            end

            if (hasDiseaseDebuff) then
                break;
            end
        end

        if (debuffName and debuffType and
            strfind(debuffType, "Curse") and
            not (UnitClass("player") == "Priest" or
            UnitClass("player") == "Paladin" or
            UnitClass("player") == "Shaman")) then
            hasCurseDebuff = true;
            debuffPlayer = "pet";
            break;
        end

        if (debuffName and debuffType and
            strfind(debuffType, "Poison") and
            not (UnitClass("player") == "Priest" or
            UnitClass("player") == "Mage")) then
            hasPoisonDebuff = true;
            debuffPlayer = "pet";

            --
            -- NullifyPoison check
            --
            hasNullifyPoison, myNullifyPoison,
            numNullifyPoison = btp_check_buff("NullifyPoison", debuffPlayer);

            if (hasNullifyPoison) then
                hasPoisonDebuff = false;
            end

            if (hasPoisonDebuff) then
                break;
            end
        end

        i = i + 1;
    end

    debuffName = "foo";
    i = 1;

    while (debuffName) do
        --
        -- I am more important
        --
        debuffName, debuffIcon, debuffCount, debuffType,
        debuffDuration, debuffTimeLeft, debuffMine, debuffStealable,
        debuffNameplateShowPersonal, spellId, canApplyAura, isBossDebuff,
        castByPlayer, nameplateShowAll, timeMod = UnitDebuff("player", i);

        if (debuffName and not strfind(debuffName, "Cripple") and
            debuffType and strfind(debuffType, "Magic") and
            not (UnitClass("player") == "Mage" or
            UnitClass("player") == "Shaman")) then
            hasMagicDebuff = true;
            debuffPlayer = "player";
            break;
        end

        if (debuffName and debuffType and
            strfind(debuffType, "Disease") and
            not (UnitClass("player") == "Druid" or
            UnitClass("player") == "Mage")) then
            hasDiseaseDebuff = true;
            debuffPlayer = "player";

            --
            -- NullifyDisease check
            --
            hasNullifyDisease, myNullifyDisease,
            numNullifyDisease = btp_check_buff("NullifyDisease", debuffPlayer);

            if (hasNullifyDisease) then
                hasDiseaseDebuff = false;
            end

            if (hasDiseaseDebuff) then
                break;
            end
        end

        if (debuffName and debuffType and
            strfind(debuffType, "Curse") and
            not (UnitClass("player") == "Priest" or
            UnitClass("player") == "Paladin" or
            UnitClass("player") == "Shaman")) then
            hasCurseDebuff = true;
            debuffPlayer = "player";
            break;
        end

        if (debuffName and debuffType and
            strfind(debuffType, "Poison") and
            not (UnitClass("player") == "Priest" or
            UnitClass("player") == "Mage")) then
            hasPoisonDebuff = true;
            debuffPlayer = "player";

            --
            -- NullifyPoison check
            --
            hasNullifyPoison, myNullifyPoison,
            numNullifyPoison = btp_check_buff("NullifyPoison", debuffPlayer);

            if (hasNullifyPoison) then
                hasPoisonDebuff = false;
            end

            if (hasPoisonDebuff) then
                break;
            end
        end

        i = i + 1;
    end

    if (UnitClass("player") == "Druid") then
        if (hasPoisonDebuff and
            btp_cast_spell_on_target("Cure Poison", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        end
    elseif (UnitClass("player") == "Priest") then
        if (hasMagicDebuff and
            btp_cast_spell_on_target("Dispel Magic", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (hasDiseaseDebuff and
                btp_cast_spell_on_target("Abolish Disease", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (hasDiseaseDebuff and
                btp_cast_spell_on_target("Cure Disease", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        end
    elseif (UnitClass("player") == "Shaman") then
        haveTotem, totemName, startTime, duration = GetTotemInfo(3);

        if (hasDiseaseDebuff and
            totemName ~= "Mana Tide Totem" and
            totemName ~= "Poison Cleansing Totem" and
            totemName ~= "Disease Cleansing Totem" and
            btp_cast_spell("Disease Cleansing Totem")) then
            return true;
        elseif (hasPoisonDebuff and
                totemName ~= "Mana Tide Totem" and
                totemName ~= "Disease Cleansing Totem" and
                totemName ~= "Poison Cleansing Totem" and
                btp_cast_spell("Poison Cleansing Totem")) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif ((hasDiseaseDebuff or hasPoisonDebuff) and
                btp_cast_spell_on_target("Cleanse Spirit", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (hasPoisonDebuff and
                btp_cast_spell_on_target("Cure Poison", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif (hasDiseaseDebuff and
                btp_cast_spell_on_target("Cure Disease", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        end
    elseif (UnitClass("player") == "Mage") then
        if (hasCurseDebuff and
            btp_cast_spell_on_target("Remove Lesser Curse", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        end
    elseif (UnitClass("player") == "Paladin") then
        if ((hasMagicDebuff or hasDiseaseDebuff or hasPoisonDebuff) and
            btp_cast_spell_on_target("Cleanse", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        elseif ((hasDiseaseDebuff or hasPoisonDebuff) and
                btp_cast_spell_on_target("Purge", debuffPlayer)) then
            FuckBlizzardTargetUnit("playertarget");
            return true;
        end
    end
end

function RollRGB(r, g, b)
        b = b + 1;

        if (b > 16) then
            b = 1;   
            g = g + 1;
                           
            if (g > 16) then
                g = 1;   
                r = r + 1;
                              
                if (r > 16) then
                    btp_frame_debug("btp: No more RGB values.");
                end
            end
        end

        return r, g, b;
end

function CleanFrame()
    --
    -- This is hear because it is run last.  This means after we start
    -- casting a spell we can flip an item on that helps that spell.
    -- Look to the warlock code for details.
    --
    if (equipItem) then
        EquipItemByName(equipItem);
        equipItem = nil;
    end

    -- Set frames back to black
    -- James' frame color function here.
    btp_frame_set_color_hex("IT", "000000");
    btp_frame_set_color_hex("IA", "000000");
    btp_frame_set_color_hex("IPT", "000000");

    btp_frame_set_color_hex("CT", "000000");
    btp_frame_set_color_hex("CA", "000000");
    btp_frame_set_color_hex("CPT", "000000");

    btp_frame_set_color_hex("AT", "000000");
    btp_frame_set_color_hex("AA", "000000");
    btp_frame_set_color_hex("APT", "000000");

    btp_frame_set_color_hex("PT", "000000");
    btp_frame_set_color_hex("MA", "000000");
    btp_frame_set_color_hex("PA", "000000");
    btp_frame_set_color_hex("MP", "000000");
    btp_frame_set_color_hex("PPT", "000000");
end

function ProphetKeyBindings()
    btp_bot_init();

    key = "CTRL-";
    letters = { "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O",
                "P","Q","R","S","T","U","V","W","X","Y","Z","`","-","=","[",
                "]",";","'",",",".","/","1","2","3","4","5","6","7","8",
                "9" };
    i = 1;
    j = 1;
               
    if (not InCombatLockdown() and not btp_is_mounted("player")) then
        if (not fuckBlizMapping or (GetTime() - lastBinding) >= 120) then
            lastBinding = GetTime();
            fuckBlizMapping = { };

            --
            -- Tuck this away here so it happens once.
            --
            btp_init_spells();

            --
            -- You know for robots
            --
            SetBinding(key .. "1", "PetAttack");
            fuckBlizMapping[key] = key .. "1";
            j = j + 1;
            SetBinding(key .. letters[j], "MOVEFORWARD");
            fuckBlizMapping[key] = "MOVEFORWARD";
            j = j + 1;
            SetBinding(key .. letters[j], "MOVEBACKWARD");
            fuckBlizMapping[key .. letters[j]] = "MOVEBACKWARD";
            j = j + 1;
            SetBinding(key .. letters[j], "TURNLEFT");
            fuckBlizMapping[key .. letters[j]] = "TURNLEFT";
            j = j + 1;
            SetBinding(key .. letters[j], "TURNRIGHT");
            fuckBlizMapping[key .. letters[j]] = "TURNRIGHT";
            j = j + 1;
            SetBinding(key .. letters[j], "JUMP");
            fuckBlizMapping[key .. letters[j]] = "JUMP";
            j = j + 1;
            SetBinding(key .. letters[j], "DOWN");
            fuckBlizMapping[key .. letters[j]] = "DOWN";
            j = j + 1;
            SetBinding(key .. letters[j], "CLICK");
            fuckBlizMapping[key .. letters[j]] = "CLICK";
            j = j + 1;

            --
            -- One key press target
            --
            k = 1;
            btn = CreateFrame("Button", "BtpButton" .. k, nil,
                              "SecureActionButtonTemplate");
            btn:RegisterForClicks("AnyUp");
            btn:SetAttribute("type", "macro");
            btn:SetAttribute("macrotext", "/focus target\n/target player");

            SetBindingClick(key .. letters[j], "BtpButton" .. k);
            fuckBlizMapping["player"] = key .. letters[j];
            j = j + 1;
            k = k + 1;
            local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                    "SecureActionButtonTemplate");
            btn:RegisterForClicks("AnyUp");
            btn:SetAttribute("type", "macro");
            btn:SetAttribute("macrotext", "/target focus");
            SetBindingClick(key .. letters[j], "BtpButton" .. k);
            fuckBlizMapping["playertarget"] = key .. letters[j];
            j = j + 1;
            k = k + 1;
            local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                    "SecureActionButtonTemplate");
            btn:RegisterForClicks("AnyUp");
            btn:SetAttribute("type", "macro");
            btn:SetAttribute("macrotext", "/focus target\n/target pet");
            SetBindingClick(key .. letters[j], "BtpButton" .. k);
            fuckBlizMapping["pet"] = key .. letters[j];
            j = j + 1;
            k = k + 1;
            local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                    "SecureActionButtonTemplate");
            btn:RegisterForClicks("AnyUp");
            btn:SetAttribute("type", "macro");
            btn:SetAttribute("macrotext", "/focus target\n/target pettarget");
            SetBindingClick(key .. letters[j], "BtpButton" .. k);
            fuckBlizMapping["pettarget"] = key .. letters[j];
            j = j + 1;
            k = k + 1;
            local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                    "SecureActionButtonTemplate");
            btn:RegisterForClicks("AnyUp");
            btn:SetAttribute("type", "macro");
            btn:SetAttribute("macrotext",
                             "/focus target\n/targetfriend");
            SetBindingClick(key .. letters[j], "BtpButton" .. k);
            fuckBlizMapping["targetfriend"] = key .. letters[j];
            j = j + 1;
            k = k + 1;
            local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                    "SecureActionButtonTemplate");
            btn:RegisterForClicks("AnyUp");
            btn:SetAttribute("type", "macro");
            btn:SetAttribute("macrotext", "/focus target\n/targetenemy");
            SetBindingClick(key .. letters[j], "BtpButton" .. k);
            fuckBlizMapping["targetenemy"] = key .. letters[j];
            j = j + 1;
            k = k + 1;
            local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                    "SecureActionButtonTemplate");
            btn:RegisterForClicks("AnyUp");
            btn:SetAttribute("type", "macro");
            btn:SetAttribute("macrotext",
                             "/focus target\n/target targettarget");
            SetBindingClick(key .. letters[j], "BtpButton" .. k);
            fuckBlizMapping["targettarget"] = key .. letters[j];
            j = j + 1;
            k = k + 1;

            --
            -- I am looking at the code way after the fact, but I think
            -- it means that we can use ALT-CTRL-SHIFT-[0-9] for stuff.
            -- The crowd control code is bound to 9, and the stopcasting
            -- code is bound to 8 for now.
            --
            if (UnitClass("player") == "Druid") then
                fuckBlizMapping["druidcc"] = "ALT-CTRL-SHIFT-9";
            elseif (UnitClass("player") == "Priest") then
                fuckBlizMapping["priestcc"] = "ALT-CTRL-SHIFT-9";
            elseif (UnitClass("player") == "Warlock") then
                fuckBlizMapping["warlockcc"] = "ALT-CTRL-SHIFT-9";
            elseif (UnitClass("player") == "Mage") then
                fuckBlizMapping["magecc"] = "ALT-CTRL-SHIFT-9";
            elseif (UnitClass("player") == "Rogue") then
                fuckBlizMapping["roguecc"] = "ALT-CTRL-SHIFT-9";
            end

            btp_set_macro("btp_stopcasting", "/stopcasting", 8)
            fuckBlizMapping["stopcasting"] = "ALT-CTRL-SHIFT-8";

            while true do
               local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_SPELL);
               if not spellName then
                  do break end      
               end

               if (fuckBlizMapping[spellName] == nil) then
		            if(key=="CTRL-" and letters[j] == ",") then
                       j = j + 1;
                   end
                   fuckBlizMapping[spellName] = key .. letters[j];
                   -- btp_frame_debug("key: " .. key .. letters[j] ..
                   --                 " spell: " .. spellName .. " Rank: " .. spellRank);
                   SetBindingSpell(key .. letters[j], spellName);
                   j = j + 1;


if spellName and BTP_SPELL_LEVEL_REQ[spellName] then
    for rank = 1, #BTP_SPELL_LEVEL_REQ[spellName] do
        local spellRankName = spellName .. "(Rank " .. rank .. ")";
        -- only create macros for spells we have
        -- if (not IsSpellKnown(GetSpellInfo(spellRankName))) then break; end
        -- if (not btp_get_spell_id(spellRankName)) then break; end
        if (not btp_get_spell_id(spellRankName)) then break; end
        local macroName = spellName .. "Rank" .. rank;
        if not GetMacroInfo(macroName) then
            CreateMacro(macroName, "INV_MISC_QUESTIONMARK", "/cast " .. spellRankName, nil);
        end
        fuckBlizMapping[spellRankName] = key .. letters[j];
        SetBindingMacro(key .. letters[j], macroName);
        j = j + 1;
    end
end

--[[ THIS WORKS
if (spellName == "Renew") then
    for rank = 1, 7 do
        local renewSpellName = "Renew(Rank " .. rank .. ")";
        local macroName = "RenewRank" .. rank;
        CreateMacro(macroName, "INV_MISC_QUESTIONMARK", "/cast " .. renewSpellName, nil);
        fuckBlizMapping[renewSpellName] = key .. letters[j];
        SetBindingMacro(key .. letters[j], macroName);
        j = j + 1;
    end
end
]]


               end
                          
               if (j > 45 or (j > 36 and (key == "CTRL-" or
                   key == "ALT-CTRL-SHIFT-"))) then
                   if (key == "CTRL-") then
                       key = "CTRL-SHIFT-";
                   elseif (key == "CTRL-SHIFT-") then
                       key = "ALT-";
                   elseif (key == "ALT-") then
                       key = "ALT-SHIFT-";
                   elseif (key == "ALT-SHIFT-") then
                       key = "ALT-CTRL-";
                   elseif (key == "ALT-CTRL-") then
                       key = "ALT-CTRL-SHIFT-";
                   elseif (key == "ALT-CTRL-SHIFT-") then
                       -- btp_frame_debug("No more keys to bind at: " ..
                       --                       spellName);
                       return true;
                   end
    
                   j = 1;
               end

               i = i + 1;
            end

            i = 1;
            while true do
               local spellName, spellRank = GetSpellBookItemName(i, BOOKTYPE_PET);
               if not spellName then
                  do break end      
               end

               if (fuckBlizMapping[spellName] == nil) then
                   fuckBlizMapping[spellName] = key .. letters[j];
                   SetBindingSpell(key .. letters[j], spellName);
                   j = j + 1;
               end
                          
               if (j > 45 or (j > 36 and (key == "CTRL-" or
                   key == "ALT-CTRL-SHIFT-"))) then
                   if (key == "CTRL-") then
                       key = "CTRL-SHIFT-";
                   elseif (key == "CTRL-SHIFT-") then
                       key = "ALT-";
                   elseif (key == "ALT-") then
                       key = "ALT-SHIFT-";
                   elseif (key == "ALT-SHIFT-") then
                       key = "ALT-CTRL-";
                   elseif (key == "ALT-CTRL-") then
                       key = "ALT-CTRL-SHIFT-";
                   elseif (key == "ALT-CTRL-SHIFT-") then
                       -- btp_frame_debug("No more keys to bind at: " ..
                       --                       spellName);
                       return true;
                   end

                   j = 1;
               end

               i = i + 1;
            end

            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                   itemName, itemLink, itemRarity, itemLevel, itemMinLevel,
                   itemType, itemSubType, itemStackCount, itemEquipLoc,
                   invTexture = GetItemInfo(C_Container.GetContainerItemLink(bag,slot));

                   if ((itemType == "Consumable" or
                       (itemType == "Trade Goods" and
                        itemSubType == "Devices") or
                       (itemType == "Trade Goods" and
                        itemSubType == "Explosives") or
                       (itemType == "Armor" and
                        itemSubType == "Miscellaneous") or
                       (itemType == "Miscellaneous" and
                        itemSubType == "Mount") or
                       (itemType == "Miscellaneous" and
                        itemSubType == "Junk")) and
                       fuckBlizMapping[itemName] == nil) then
                       fuckBlizMapping[itemName] = key .. letters[j];
                       SetBindingItem(key .. letters[j], itemName);
                       j = j + 1;
                   end

                   if (j > 45 or (j > 36 and (key == "CTRL-" or
                       key == "ALT-CTRL-SHIFT-"))) then
                       if (key == "CTRL-") then
                           key = "CTRL-SHIFT-";
                       elseif (key == "CTRL-SHIFT-") then
                           key = "ALT-";
                       elseif (key == "ALT-") then
                           key = "ALT-SHIFT-";
                       elseif (key == "ALT-SHIFT-") then
                           key = "ALT-CTRL-";
                       elseif (key == "ALT-CTRL-") then
                           key = "ALT-CTRL-SHIFT-";
                       elseif (key == "ALT-CTRL-SHIFT-") then
                           -- btp_frame_debug("No more keys to bind at: " ..
                           --                       itemName);
                           return true;
                       end

                       j = 1;
                   end
                end
              end
            end

            for slot=0,23 do
                if (GetInventoryItemLink("player", slot)) then
                  itemName, itemLink, itemRarity, itemLevel, itemMinLevel,
                  itemType, itemSubType, itemStackCount, itemEquipLoc,
                  invTexture = GetItemInfo(GetInventoryItemLink("player",slot));

                   if (fuckBlizMapping[itemName] == nil) then
                       fuckBlizMapping[itemName] = key .. letters[j];
                       SetBindingItem(key .. letters[j], itemName);
                       j = j + 1;
                   end

                   if (j > 45 or (j > 36 and (key == "CTRL-" or
                       key == "ALT-CTRL-SHIFT-"))) then
                       if (key == "CTRL-") then
                           key = "CTRL-SHIFT-";
                       elseif (key == "CTRL-SHIFT-") then
                           key = "ALT-";
                       elseif (key == "ALT-") then
                           key = "ALT-SHIFT-";
                       elseif (key == "ALT-SHIFT-") then
                           key = "ALT-CTRL-";
                       elseif (key == "ALT-CTRL-") then
                           key = "ALT-CTRL-SHIFT-";
                       elseif (key == "ALT-CTRL-SHIFT-") then
                           -- btp_frame_debug("No more keys to bind at: " ..
                           --                       itemName);
                           return true;
                       end

                       j = 1;
                   end
                end
            end

            i = 1;
            for i=1,5 do
                if (fuckBlizMapping["party" .. i] == nil) then
                    local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                            "SecureActionButtonTemplate");
                    btn:RegisterForClicks("AnyUp");  
                    btn:SetAttribute("type", "macro");
                    btn:SetAttribute("macrotext",
                                     "/focus target\n/target party" .. i);
                    SetBindingClick(key .. letters[j], "BtpButton" .. k);
                    fuckBlizMapping["party" .. i] = key .. letters[j];
                    k = k + 1;
                    j = j + 1;
                end

                if (j > 45 or (j > 36 and (key == "CTRL-" or
                    key == "ALT-CTRL-SHIFT-"))) then
                    if (key == "CTRL-") then
                        key = "CTRL-SHIFT-";
                    elseif (key == "CTRL-SHIFT-") then
                        key = "ALT-";
                    elseif (key == "ALT-") then
                        key = "ALT-SHIFT-";
                    elseif (key == "ALT-SHIFT-") then
                        key = "ALT-CTRL-";
                    elseif (key == "ALT-CTRL-") then
                        key = "ALT-CTRL-SHIFT-";
                    elseif (key == "ALT-CTRL-SHIFT-") then
                        -- btp_frame_debug("No more keys to bind at: " ..
                        --                       "party" .. i);
                        return true;
                    end

                    j = 1;
                end
            end

            i = 1;
            for i=1,40 do
                if (fuckBlizMapping["raid" .. i] == nil) then
                    local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                            "SecureActionButtonTemplate");
                    btn:RegisterForClicks("AnyUp");
                    btn:SetAttribute("type", "macro");
                    btn:SetAttribute("macrotext",
                                     "/focus target\n/target raid" .. i);
                    SetBindingClick(key .. letters[j], "BtpButton" .. k);
                    fuckBlizMapping["raid" .. i] = key .. letters[j];
                    k = k + 1;
                    j = j + 1;
                end

                if (j > 45 or (j > 36 and (key == "CTRL-" or
                    key == "ALT-CTRL-SHIFT-"))) then
                    if (key == "CTRL-") then
                        key = "CTRL-SHIFT-";
                    elseif (key == "CTRL-SHIFT-") then
                        key = "ALT-";
                    elseif (key == "ALT-") then
                        key = "ALT-SHIFT-";
                    elseif (key == "ALT-SHIFT-") then
                        key = "ALT-CTRL-";
                    elseif (key == "ALT-CTRL-") then
                        key = "ALT-CTRL-SHIFT-";
                    elseif (key == "ALT-CTRL-SHIFT-") then
                        -- btp_frame_debug("No more keys to bind at: " ..
                        --                       "raid" .. i);
                        return true;
                    end

                    j = 1;
                end
            end

            i = 1;
            for i=1,5 do
                if (fuckBlizMapping["partypet" .. i] == nil) then
                    local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                            "SecureActionButtonTemplate");
                    btn:RegisterForClicks("AnyUp");
                    btn:SetAttribute("type", "macro");
                    btn:SetAttribute("macrotext",
                                     "/focus target\n/target partypet" .. i);
                    SetBindingClick(key .. letters[j], "BtpButton" .. k);
                    fuckBlizMapping["partypet" .. i] = key .. letters[j];
                    k = k + 1;
                    j = j + 1;
                end

                if (j > 45 or (j > 36 and (key == "CTRL-" or
                    key == "ALT-CTRL-SHIFT-"))) then
                    if (key == "CTRL-") then
                        key = "CTRL-SHIFT-";
                    elseif (key == "CTRL-SHIFT-") then
                        key = "ALT-";
                    elseif (key == "ALT-") then
                        key = "ALT-SHIFT-";
                    elseif (key == "ALT-SHIFT-") then
                        key = "ALT-CTRL-";
                    elseif (key == "ALT-CTRL-") then
                        key = "ALT-CTRL-SHIFT-";
                    elseif (key == "ALT-CTRL-SHIFT-") then
                        -- btp_frame_debug("No more keys to bind at: " ..
                        --                       "partypet" .. i);
                        return true;
                    end

                    j = 1;
                end
            end

            i = 1;
            for i=1,40 do
                if (fuckBlizMapping["raidpet" .. i] == nil) then
                    local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                            "SecureActionButtonTemplate");
                    btn:RegisterForClicks("AnyUp");
                    btn:SetAttribute("type", "macro");
                    btn:SetAttribute("macrotext",
                                     "/focus target\n/target raidpet" .. i);
                    SetBindingClick(key .. letters[j], "BtpButton" .. k);
                    fuckBlizMapping["raidpet" .. i] = key .. letters[j];
                    k = k + 1;
                    j = j + 1;
                end

                if (j > 45 or (j > 36 and (key == "CTRL-" or
                    key == "ALT-CTRL-SHIFT-"))) then
                    if (key == "CTRL-") then
                        key = "CTRL-SHIFT-";
                    elseif (key == "CTRL-SHIFT-") then
                        key = "ALT-";
                    elseif (key == "ALT-") then
                        key = "ALT-SHIFT-";
                    elseif (key == "ALT-SHIFT-") then
                        key = "ALT-CTRL-";
                    elseif (key == "ALT-CTRL-") then
                        key = "ALT-CTRL-SHIFT-";
                    elseif (key == "ALT-CTRL-SHIFT-") then
                        -- btp_frame_debug("No more keys to bind at: " ..
                        --                       "raidpet" .. i);
                        return true;
                    end

                    j = 1;
                end
            end

            i = 1;
            for i=1,5 do
                if (fuckBlizMapping["party" .. i .. "target"] == nil) then
                    local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                            "SecureActionButtonTemplate");
                    btn:RegisterForClicks("AnyUp");  
                    btn:SetAttribute("type", "macro"); 
                    btn:SetAttribute("macrotext",
                                     "/focus target\n/target party" .. i ..
                                     "target");
                    SetBindingClick(key .. letters[j], "BtpButton" .. k);
                    fuckBlizMapping["party" .. i .. "target"] = key ..
                                    letters[j];
                    k = k + 1;
                    j = j + 1;
                end

                if (j > 45 or (j > 36 and (key == "CTRL-" or
                    key == "ALT-CTRL-SHIFT-"))) then
                    if (key == "CTRL-") then
                        key = "CTRL-SHIFT-";
                    elseif (key == "CTRL-SHIFT-") then
                        key = "ALT-";
                    elseif (key == "ALT-") then
                        key = "ALT-SHIFT-";
                    elseif (key == "ALT-SHIFT-") then
                        key = "ALT-CTRL-";
                    elseif (key == "ALT-CTRL-") then
                        key = "ALT-CTRL-SHIFT-";
                    elseif (key == "ALT-CTRL-SHIFT-") then
                        -- btp_frame_debug("No more keys to bind at: " ..
                        --                       "party" .. i .. "target");
                        return true;
                    end

                    j = 1;
                end
            end

            i = 1;
            for i=1,40 do
                if (fuckBlizMapping["raid" .. i .. "target"] == nil) then
                    local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                            "SecureActionButtonTemplate");
                    btn:RegisterForClicks("AnyUp");
                    btn:SetAttribute("type", "macro");
                    btn:SetAttribute("macrotext",
                                     "/focus target\n/target raid" .. i ..
                                     "target");                          
                    SetBindingClick(key .. letters[j], "BtpButton" .. k);      
                    fuckBlizMapping["raid" .. i .. "target"] = key ..
                                    letters[j];                       
                    k = k + 1;                                                  
                    j = j + 1;
                end

                if (j > 45 or (j > 36 and (key == "CTRL-" or
                    key == "ALT-CTRL-SHIFT-"))) then
                    if (key == "CTRL-") then
                        key = "CTRL-SHIFT-";
                    elseif (key == "CTRL-SHIFT-") then
                        key = "ALT-";
                    elseif (key == "ALT-") then
                        key = "ALT-SHIFT-";
                    elseif (key == "ALT-SHIFT-") then
                        key = "ALT-CTRL-";
                    elseif (key == "ALT-CTRL-") then
                        key = "ALT-CTRL-SHIFT-";
                    elseif (key == "ALT-CTRL-SHIFT-") then
                        -- btp_frame_debug("No more keys to bind at: " ..
                        --                       "raid" .. i .. "target");
                        return true;
                    end

                    j = 1;
                end
            end

            i = 1;
            for i=1,5 do
                if (fuckBlizMapping["partypet" .. i .. "target"] == nil) then
                    local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                            "SecureActionButtonTemplate");
                    btn:RegisterForClicks("AnyUp");
                    btn:SetAttribute("type", "macro");
                    btn:SetAttribute("macrotext",
                                     "/focus target\n/target partypet" .. i ..
                                     "target");                          
                    SetBindingClick(key .. letters[j], "BtpButton" .. k);      
                    fuckBlizMapping["partypet" .. i .. "target"] = key ..
                                    letters[j];                       
                    k = k + 1;                                                  
                    j = j + 1;
                end

                if (j > 45 or (j > 36 and (key == "CTRL-" or
                    key == "ALT-CTRL-SHIFT-"))) then
                    if (key == "CTRL-") then
                        key = "CTRL-SHIFT-";
                    elseif (key == "CTRL-SHIFT-") then
                        key = "ALT-";
                    elseif (key == "ALT-") then
                        key = "ALT-SHIFT-";
                    elseif (key == "ALT-SHIFT-") then
                        key = "ALT-CTRL-";
                    elseif (key == "ALT-CTRL-") then
                        key = "ALT-CTRL-SHIFT-";
                    elseif (key == "ALT-CTRL-SHIFT-") then
                        -- btp_frame_debug("No more keys to bind at: " ..
                        --                       "partypet" .. i .. "target");
                        return true;
                    end

                    j = 1;
                end
            end

            i = 1;
            for i=1,40 do
                if (fuckBlizMapping["raidpet" .. i .. "target"] == nil) then


                    local btn = CreateFrame("Button", "BtpButton" .. k, nil,
                                            "SecureActionButtonTemplate");
                    btn:RegisterForClicks("AnyUp");
                    btn:SetAttribute("type", "macro");
                    btn:SetAttribute("macrotext",
                                     "/focus target\n/target raidpet" .. i ..
                                     "target");                   
                    SetBindingClick(key .. letters[j], "BtpButton" .. k);
                    fuckBlizMapping["raidpet" .. i .. "target"] = key ..
                                    letters[j];
                    k = k + 1;                                         
                    j = j + 1;
                end

                if (j > 45 or (j > 36 and (key == "CTRL-" or
                    key == "ALT-CTRL-SHIFT-"))) then
                    if (key == "CTRL-") then
                        key = "CTRL-SHIFT-";
                    elseif (key == "CTRL-SHIFT-") then
                        key = "ALT-";
                    elseif (key == "ALT-") then
                        key = "ALT-SHIFT-";
                    elseif (key == "ALT-SHIFT-") then
                        key = "ALT-CTRL-";
                    elseif (key == "ALT-CTRL-") then
                        key = "ALT-CTRL-SHIFT-";
                    elseif (key == "ALT-CTRL-SHIFT-") then
                        -- btp_frame_debug("No more keys to bind at: " ..
                        --                       "raidpet" .. i .. "target");
                        return true;
                    end

                    j = 1;
                end
            end

            return true;
        end
    end
    return false;
end

function btp_general_resurrect_request()
    if (not botOff and event == "RESURRECT_REQUEST") then
        AcceptResurrect();
    end
end

function btp_general_msg_addon()
	if (event == "CHAT_MSG_ADDON") then
		addon = arg1;
		addon_txt = arg2;
		channel = arg3;
		pname = arg4;

		-- first make sure the event is for BTP
		if(addon ~= "BTP") then
			return false;
		end

		-- Don't follow exclusion request
		btp_follow_exclusion_request(addon_txt, pname);

		-- check if the request is from a guild member
		if(not btp_is_guildmate(pname)) then
			return false;
		end

		-- So if we got here then the msg is for btp
		-- sent buy a guild mate and a party/raid member

		-- resolve any target info here
		assist_id = btp_unitid_by_name(pname);
		if(assist_id == nil) then
			return false;
		end

        doAssistUnit = assist_id;
		doAssistUnitFor = pname;
        -- btp_frame_debug("doAssistUnit: " .. doAssistUnit ..
        --                 " doAssistUnitFor:" .. doAssistUnitFor);

		-- run the old command interface first
        btp_general_msg_addon_old(addon_txt, channel, pname);

        -- the return the new
		return btp_cmd(addon_txt);

	end
end

function btp_follow_exclusion_request(addon_txt, pname)
    if (addon_txt == "btpexclude") then
        btp_follow_exclusion_add(pname);
    end
end

function btp_unitid_by_name(pname)
	-- first check the party
	for j = 1, GetNumPartyMembers() do
		nextPlayer = "party" .. j;
		name, realm = UnitName(nextPlayer);
		if(name == pname) then
			return nextPlayer
		end
	end

	-- not in party check the raid
	for j = 1, GetNumRaidMembers() do
		nextPlayer = "raid" .. j;
		name, realm = UnitName(nextPlayer);
		if(name == pname) then
			return nextPlayer
		end
	end

	return nil;
end

function btp_general_msg_addon_old(arg2, arg3, arg4)
    if (not botOff) then
            if (arg2 == "warstomp") then
                doWarstomp = true;
                addonCmd = true;
            elseif (arg2 == "entangleroot") then
                doEntangleRoot = true;
                addonCmd = true;
            elseif (arg2 == "treeform") then
                doTreeForm = true;
                addonCmd = true;
            elseif (arg2 == "hibernate") then
                doHibernate = true;
                addonCmd = true;
            elseif (arg2 == "faeriefire") then
                doFaerieFire = true;
                addonCmd = true;
            elseif (arg2 == "cyclone") then
                doCyclone = true;
                addonCmd = true;
            elseif (arg2 == "shackle") then
                doShackle = true;
                addonCmd = true;
            elseif (arg2 == "psychicscream") then
                doPsychicScream = true;
                addonCmd = true;
            elseif (arg2 == "shadowwordpain") then
                doShadowWordPain = true;
                addonCmd = true;
            elseif (arg2 == "shadowfiend") then
                doShadowfiend = true;
                addonCmd = true;
            elseif (arg2 == "lightwell") then
                doLightwell = true;
                addonCmd = true;
            elseif(arg2 == "dpsmode") then
			    if(DPS_MODE_ON == true) then
			    	DPS_MODE_ON = false;
			    	btp_frame_debug("DPSMode -- Off");
			    else
			    	DPS_MODE_ON = true;
			    	DPS_ASSIST_TARGET = doAssistUnit .. "target";
			    	btp_frame_debug("dpsmode unit: " .. DPS_ASSIST_TARGET ..
                                    " status: on");
			    end
            elseif (string.sub(arg2, 0, 9) == "btpaddcc ") then
               btp_set_cc(string.sub(arg2, 12), arg4,
                           string.sub(arg2, 10));
            elseif (string.sub(arg2, 0, 8) == "btpaddcc") then
                btp_set_cc(nil, arg4, nil);
            elseif (string.sub(arg2, 0, 5) == "btpcc") then
                doCC = true;
                addonCmd = true;
            end
    end
end

function btp_cc()
    if (UnitClass("player") == "Druid" and
       (btp_can_cast("Hibernate") or btp_can_cast("Cyclone") or
        btp_can_cast("Entangling Roots"))) then
        FuckBlizzardByName("druidcc");
        return true;
    elseif (UnitClass("player") == "Priest" and
           (btp_can_cast("Shackle Undead"))) then
        FuckBlizzardByName("priestcc");
        return true;
    elseif (UnitClass("player") == "Warlock" and
           (btp_can_cast("Banish") or btp_can_cast("Fear") or
            btp_can_cast("Seduction"))) then
        FuckBlizzardByName("warlockcc");
        return true;
    elseif (UnitClass("player") == "Mage" and
           (btp_can_cast("Polymorph"))) then
        FuckBlizzardByName("magecc");
        return true;
    elseif (UnitClass("player") == "Rogue" and
           (btp_can_cast("Blind"))) then
        FuckBlizzardByName("roguecc");
        return true;
    end

    return false;
end

function btp_set_cc(targetName, playerName, creatureType)
    unit = "target";

    if (InCombatLockdown()) then
        return false;
    end

    if (creatureType == "R") then
        creatureType = "Dragonkin";
    elseif (creatureType == "B") then
        creatureType = "Beast";
    elseif (creatureType == "D") then
        creatureType = "Demon";
    elseif (creatureType == "H") then
        creatureType = "Humanoid";
    end

    if (targetName) then
        if (UnitClass("player") == "Druid" and
           (creatureType == "Beast" or creatureType == "Dragonkin")) then
            btp_cc_button("BtpDruidCC",
                          "/cast Hibernate",
                          "druidcc", targetName);
        elseif (UnitClass("player") == "Druid") then
            btp_cc_button("BtpDruidCC",
                          "/castsequence Cyclone, Entangling Roots",
                          "druidcc", targetName);
        elseif (UnitClass("player") == "Priest" and
                creatureType == "Undead") then
            btp_cc_button("BtpPriestCC", "/cast Shackle Undead", "priestcc",
                          targetName);
        elseif (UnitClass("player") == "Warlock" and
                creatureType == "Demon") then
            btp_cc_button("BtpWarlockCC", "/cast Banish", "warlockcc",
                          targetName);
        elseif (UnitClass("player") == "Warlock" and
                creatureType == "Humanoid" and btp_can_cast("Seduction")) then
            btp_cc_button("BtpWarlockCC", "/castsequence Seduction, Fear",
                          "warlockcc", targetName);
        elseif (UnitClass("player") == "Warlock") then
            btp_cc_button("BtpWarlockCC", "/cast Fear", "warlockcc",
                          targetName);
        elseif (UnitClass("player") == "Mage") then
            btp_cc_button("BtpMageCC", "/cast Polymorph", "magecc", targetName);
        elseif (UnitClass("player") == "Rogue") then
            btp_cc_button("BtpRogueCC", "/cast Blind", "roguecc", targetName);
        end
    else
        for i = 0, GetNumGuildMembers(true) do
            name, rank, rankIndex, level, class, zone, note, officernote,
            online, status = GetGuildRosterInfo(i);

            if (name and playerName and name == playerName) then
                for j = 1, GetNumRaidMembers() do
                    nextPlayer = "raid" .. j;
                    name, realm = UnitName(nextPlayer);
                    if (name == playerName) then
                        unit = nextPlayer;
                        break;
                    end
                end

                if (GetNumRaidMembers() <= 0) then
                    for j = 1, GetNumPartyMembers() do
                        nextPlayer = "party" .. j;
                        name, realm = UnitName(nextPlayer);
                            if (name == playerName) then
                            unit = nextPlayer;
                            break;
                        end
                    end
                end
            end
        end

        if (UnitClass("player") == "Druid" and
           (UnitCreatureType(unit .. "target") == "Beast" or
            UnitCreatureType(unit .. "target") == "Dragonkin")) then
            btp_cc_button("BtpDruidCC",
                          "/cast Hibernate",
                          "druidcc", UnitName(unit .. "target"));
        elseif (UnitClass("player") == "Druid") then
            btp_cc_button("BtpDruidCC",
                          "/castsequence Cyclone, Entangling Roots",
                          "druidcc", UnitName(unit .. "target"));
        elseif (UnitClass("player") == "Priest" and
                UnitCreatureType(unit .. "target") == "Undead") then
            btp_cc_button("BtpPriestCC", "/cast Shackle Undead", "priestcc",
                          UnitName(unit .. "target"));
        elseif (UnitClass("player") == "Warlock" and
                UnitCreatureType(unit .. "target") == "Demon") then
            btp_cc_button("BtpWarlockCC", "/cast Banish", "warlockcc",
                          UnitName(unit .. "target"));
        elseif (UnitClass("player") == "Warlock" and
                UnitCreatureType(unit .. "target") == "Humanoid" and
                btp_can_cast("Seduction")) then
            btp_cc_button("BtpWarlockCC", "/castsequence Seduction, Fear",
                          "warlockcc", UnitName(unit .. "target"));
        elseif (UnitClass("player") == "Warlock") then
            btp_cc_button("BtpWarlockCC", "/cast Fear", "warlockcc",
                          UnitName(unit .. "target"));
        elseif (UnitClass("player") == "Mage") then
            btp_cc_button("BtpMageCC", "/cast Polymorph", "magecc",
                          UnitName(unit .. "target"));
        elseif (UnitClass("player") == "Rogue") then
            btp_cc_button("BtpRogueCC", "/cast Blind", "roguecc",
                          UnitName(unit .. "target"));
        end
    end
end

function btp_cc_button(buttonName, macro, mapName, targetName)
    if (btnCC == nil) then
        btnCC = CreateFrame("Button", buttonName, nil,
                            "SecureActionButtonTemplate");
        btnCC:RegisterForClicks("AnyUp");                 
    end

    btnCC:SetAttribute("type", "macro");
    btnCC:SetAttribute("macrotext", "/focus target\n/targetexact " ..
                       targetName ..  "\n" .. macro ..  "\n/target focus");
    SetBindingClick("ALT-CTRL-SHIFT-9", buttonName);
end

function btp_set_macro(buttonName, macro, num)
    if (btnCC == nil) then
        btnCC = CreateFrame("Button", buttonName, nil,
                            "SecureActionButtonTemplate");
        btnCC:RegisterForClicks("AnyUp");                 
    end

    -- btp_frame_debug ("ALT-CTRL-SHIFT-" .. num .. " " .. buttonName .. " " .. macro .. "\n")
    btnCC:SetAttribute("type", "macro");
    btnCC:SetAttribute("macrotext", macro);
    SetBindingClick("ALT-CTRL-SHIFT-" .. num, buttonName);
end

function btp_general_chat_msg_guild()
    i = math.random(10);

    if (not botOff and event == "CHAT_MSG_GUILD" and
        arg2 ~= UnitName("player") and i == 5 and
       (string.find(arg1, "moo") or string.find(arg1, "MOO") or
        string.find(arg1, "Moo")) and UnitName("player") == "Moovaca") then
        SendChatMessage("vaca", "GUILD", nil);
    end

    if (not botOff and event == "CHAT_MSG_GUILD" and
        arg2 ~= UnitName("player") and i == 7 and
        UnitName("player") == "Moovaca") then
        SendChatMessage(Chatter(arg1), "GUILD", nil);
    end
end

--
-- Invites all lvl 85 players in the guild.  Does not work like the
-- whisper command 'btpinvite'.
--
function btp_invite()
    for i = 0, GetNumGuildMembers(true) do
        name, rank, rankIndex, level, class, zone, note, officernote,
        online, status = GetGuildRosterInfo(i);

        if (level == 85) then
            InviteUnit(name);
        end
    end
end

function btp_general_chat_msg_whisper()
    inGuild    = false;
    partyOK    = false;
    nextPlayer = "no one";
    unitid     = "no one";
    instanceID = 0;

    if (not botOff and event == "CHAT_MSG_WHISPER") then
        GuildRoster();

        for i = 0, GetNumGuildMembers(true) do
            name, rank, rankIndex, level, class, zone, note, officernote,
            online, status = GetGuildRosterInfo(i);

            if (name and arg2 and name == arg2 and
                arg2 ~= UnitName("player")) then

               for j = 1, GetNumRaidMembers() do
                   nextPlayer = "raid" .. j;

                   if (name == UnitName(nextPlayer)) then
                       unitid = nextPlayer;
                   end
               end

               if (GetNumRaidMembers() <= 0) then
                   for j = 1, GetNumPartyMembers() do
                       nextPlayer = "party" .. j;

                       if (name == UnitName(nextPlayer)) then
                           unitid = nextPlayer;
                       end
                   end
               end

               inGuild = true;
               break;
            end
        end

        if (inGuild) then
            if (string.sub(arg1, 0, 7) == "btphelp") then
                SendChatMessage("Hello " .. arg2 ..  ", here is a list of the commands you can use with me.  Pleae note that the commands are to be used without the [] and <> wrappers.", "WHISPER", nil, arg2);


                SendChatMessage("[btpinvite] -- If I am party leader or I have assist, then I will send you an invite.", "WHISPER", nil, arg2);


                SendChatMessage("[btpfly] <location name> -- Give this command with the name or partial name of the place you want me to fly, then send a btpclick to have me fly there.", "WHISPER", nil, arg2);


                SendChatMessage("[btpbootycall] -- If you give me a booty call in Outlands I will fly to your location myself.", "WHISPER", nil, arg2);


                SendChatMessage("[btpbeg] -- Toggles my ability to beg for change when I am not in a group.", "WHISPER", nil, arg2);


                SendChatMessage("[btproll] -- This will cause me to do a /roll.", "WHISPER", nil, arg2);


                SendChatMessage("[btpclick] -- This will cause me to right-click in the center of my screen.", "WHISPER", nil, arg2);


                SendChatMessage("[btpdrink] -- Sick of waiting for me to drink?  Force me to.", "WHISPER", nil, arg2);


                SendChatMessage("[btphearth] -- Toggle hearthing on and off.  by default I will hearth to my home location if I am not in PvP mode and I am not in a group.  If your trying to switch my mode this may cause me to hearth.  Using btphearth will stop this.", "WHISPER", nil, arg2);


                SendChatMessage("[btpaddcc] <R B D H> <targetname> -- Set my CC target to either the creature type (R = Dragonkin, B = Beast, D = Demon, H = Humanoid) and target name (with exact case), or if no creature type and target name is given, then the target you have targeted.", "WHISPER", nil, arg2);


                SendChatMessage("[btpcc] -- CC the target(s) set with the btpaddcc command.", "WHISPER", nil, arg2);


                SendChatMessage("[btprelease] -- Toggle release spirit on and off.  by default I will release spirit, but in an instance this can be problematic.  This option will tell me if I am supposed to release spirit or not.", "WHISPER", nil, arg2);


                SendChatMessage("[btpdecurse] -- Toggle blocking on decurse on or off.  This means that if someone needs a decurse the code will block on that before anyone gets a heal.", "WHISPER", nil, arg2);


                SendChatMessage("[btpstatus] -- I will report as much of my configuration as possible.  Note: Please use this command to see if I am currently in a group with other guild members, find out what zone I am in, figure out what follow mode I am using, and more.", "WHISPER", nil, arg2);


                SendChatMessage("[btploot] <wait,pass,greed,need> -- wait: wait for pass, greed, or need.  pass: pass on all loot.  greed: greed roll loot.  need: need roll loot. NOTE: if using wait and you then pass, greed, or need, remember to flip back to wait.", "WHISPER", nil, arg2);


                SendChatMessage("[btpstop] -- Tells me that I should stop following.  After this command I will simply stand in one place and twitch every now and then.", "WHISPER", nil, arg2);


                SendChatMessage("[btpstart] -- Tells me to start following again.", "WHISPER", nil, arg2);


                SendChatMessage("[btpforward] -- Tells me to run forward real fast.", "WHISPER", nil, arg2);


                SendChatMessage("[btpjump] -- Makes me jump.", "WHISPER", nil, arg2);


                SendChatMessage("[btpdown] -- Makes me swim down real fast.  Use this if you need to push my ghost below the water.", "WHISPER", nil, arg2);


                SendChatMessage("[btpreset] -- Every now and then I may crash.  Send me a btpreset either when your done with me, or when I crash.", "WHISPER", nil, arg2);


                SendChatMessage("[btpitem] <trade drink list> <item link> -- Get a list of the items in my inventory, then you can tell me to either consume that item myself, or trade it to you.", "WHISPER", nil, arg2);


                SendChatMessage("[btpsend] <playername> <message> -- Tells me to send <message> as a whisper to <playername>.  NOTE: make sure the first letter of the player name is capital.", "WHISPER", nil, arg2);


                SendChatMessage("[btpparty] -- I will send a message to the party.", "WHISPER", nil, arg2);


                SendChatMessage("[btpraid] -- I will send a message to the raid.", "WHISPER", nil, arg2);


                SendChatMessage("[btpbattleground] -- I will send a message to the battleground.", "WHISPER", nil, arg2);


                SendChatMessage("[btpwhisper] <playername> -- Tells me to relay all of the whispers I get to <playername>. NOTE: make sure the first letter of the player name is capital.  Running the command again will tell me not to relay.", "WHISPER", nil, arg2);


                SendChatMessage("[btpinnervate] <playername> -- Innervate this player when he or she is low on mana instead of self.", "WHISPER", nil, arg2);


                SendChatMessage("[btpraidheal] -- This toggles raid healing mode.  In this mode people who are NOT in the priority list will only get ONE healing over time buff in the higher heatlth range.", "WHISPER", nil, arg2);


                SendChatMessage("[btpdistcheck] -- This toggles distance checks on and off for the bot.  Useful in fights like the Prince in Karazan.", "WHISPER", nil, arg2);


                SendChatMessage("[btpselfheal] -- Toggles off priority for large heals on the bot before other players.  This helps in fights like Prince in Karazan.", "WHISPER", nil, arg2);


                SendChatMessage("[btppriority] -- This makes it so either I only heal my priority list of everyone.", "WHISPER", nil, arg2);


                SendChatMessage("[btphplist] -- List all people in the priority list.", "WHISPER", nil, arg2);


                SendChatMessage("[btphpdel] -- Clear priority list.", "WHISPER", nil, arg2);


                SendChatMessage("[btphpadd] <playername> -- Add playername to the priority list.", "WHISPER", nil, arg2);


                SendChatMessage("[btpfollow] <playername> -- Will tell me to follow the player <playername>, or if I am already following someone I will go back into guild follow mode. NOTE: in guild follow mode I will always follow the last guild member.", "WHISPER", nil, arg2);


                SendChatMessage("[btpfeadd] <playername> -- Will tell me NOT to follow the player <playername>.  Use this command if you are using more than one bot so that we do not follow eachother.", "WHISPER", nil, arg2);


                SendChatMessage("[btpfedel] -- Will remove follow exclusions.", "WHISPER", nil, arg2);


                SendChatMessage("[btpfelist] -- List follow exclusions.", "WHISPER", nil, arg2);


                SendChatMessage("[btpfarmbg] -- Oh, This will tell me to Farm BGs (alone).", "WHISPER", nil, arg2);


                SendChatMessage("[btppvp] -- My default follow mode is to group with guild members and follow them; however, I also have a PVP follow mode.  This mode allows me to move around battlegrounds by taging to other players, and means I do NOT need a guild member in the party.", "WHISPER", nil, arg2);
                SendChatMessage("[btppvp] -- Please note, IF I am in PVP mode and I am NOT in battlegrounds, then I will not accept invites or stay in a group.  You must use the [btppvp] command to put me in guild follow mode.  You may also want to block hearthing with [btphearth].", "WHISPER", nil, arg2);

            elseif (string.sub(arg1, 0, 10) == "btpforward") then
                FuckBlizzardMove("MOVEFORWARD");
            elseif (string.sub(arg1, 0, 7) == "btpjump") then
                FuckBlizzardMove("JUMP");
            elseif (string.sub(arg1, 0, 7) == "btpdown") then
                FuckBlizzardMove("DOWN");
            elseif (string.sub(arg1, 0, 8) == "btpclick") then
                FuckBlizzardMove("CLICK");
            elseif (string.sub(arg1, 0, 7) == "btpstop") then
                btpFollow = false;
                FuckBlizzardMove("TURNLEFT");
            elseif (string.sub(arg1, 0, 8) == "btpstart") then
                btpFollow = true;
            elseif (string.sub(arg1, 0, 6) == "btpfly") then
                    FlightDestination = string.sub(arg1, 8);
            elseif (string.sub(arg1, 0, 12) == "btpbootycall") then
                SendWho('n-"' .. arg2 .. '"');
                charname, guildname, level, race, class, zone,
                unknown = GetWhoInfo(1);

                if (zone ~= GetZoneText()) then
                    SetMapZoom(GetCurrentMapContinent());
                end

                x, y = GetPlayerMapPosition(unitid);
                x, y = x * 100, y * 100;

                if (x > 0 and y > 0 and zone) then
                    btp_move_to_location(zone, x, y);
                    bootyCall = true;
                    bootyName = arg2;
                    SendChatMessage("God damn you're HOT!  Be Right There!",
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 14) == "btpearthplayer") then
                    earthShieldManual = true;
                    earthShieldPlayer = string.sub(arg1, 16);
                    SendChatMessage("Added " .. string.sub(arg1, 16) ..
                                    " as my earth shield target.",
                                    "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 17) == "btpdelearthplayer") then
                    earthShieldManual = false;
                    SendChatMessage("Removed " .. earthShieldPlayer ..
                                    " as my earth shield target.",
                                    "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 11) == "btpraidheal") then
               if (btpRaidHeal) then
                    btpRaidHeal = false;
                    SendChatMessage("I will heal in normal mode!",
                                    "WHISPER", nil, arg2);
               else
                    btpRaidHeal = true;
                    SendChatMessage("I will heal in raid mode!",
                                    "WHISPER", nil, arg2);
               end
            elseif (string.sub(arg1, 0, 12) == "btpdistcheck") then
               if (dontCheckDist) then
                    dontCheckDist = false;
                    SendChatMessage("I will check distance!",
                                    "WHISPER", nil, arg2);
               else
                    dontCheckDist = true;
                    SendChatMessage("I will NOT check distance!",
                                    "WHISPER", nil, arg2);
               end
            elseif (string.sub(arg1, 0, 11) == "btpselfheal") then
               if (botSelfHeal) then
                    botSelfHeal = false;
                    SendChatMessage("I will NOT put big heals on myself" ..
                                    " before others!", "WHISPER", nil, arg2);
               else
                    botSelfHeal = true;
                    SendChatMessage("I will do big heals on myself before" ..
                                    " others!", "WHISPER", nil, arg2);
               end
            elseif (string.sub(arg1, 0, 11) == "btppriority") then
               if (PRIORITY_ONLY) then
                    PRIORITY_ONLY = false;
                    SendChatMessage("I will heal everyone!",
                                    "WHISPER", nil, arg2);
               else
                    PRIORITY_ONLY = true;
                    SendChatMessage("I will only heal my priority list!",
                                    "WHISPER", nil, arg2);
               end
            elseif (string.sub(arg1, 0, 6) == "btpbeg") then
                if (dontBeg) then
                    dontBeg = false;
                    SendChatMessage("I will now beg for change!",
                                    "WHISPER", nil, arg2);
               else
                    dontBeg = true;
                    SendChatMessage("I no longer beg for change!",
                                    "WHISPER", nil, arg2);
               end
            elseif (string.sub(arg1, 0, 8) == "btpreset") then
                SendChatMessage("Reloading my UI... BRB!",
                                "WHISPER", nil, arg2);
                reloadUI = true;
                addonCmd = true;
            elseif (string.sub(arg1, 0, 7) == "btproll") then
                RandomRoll(1,100);
                SendChatMessage("I better win this!",
                                "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 8) == "btpdrink") then
                forceDrink = true;
                SendChatMessage("Damn I am parched!!!",
                                "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 7) == "btploot") then
                btp_loot(string.sub(arg1, 9));
                SendChatMessage("I am now in " .. lootMode .. " loot mode.",
                                "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 9) == "btphearth") then
                if (dontHearth) then
                    dontHearth = false;
                    SendChatMessage("I will use my hearthstone again.",
                                    "WHISPER", nil, arg2);
                else
                    dontHearth = true;
                    SendChatMessage("I will no longer use my hearthstone.",
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 9) == "btpaddcc ") then
                    btp_set_cc(string.sub(arg1, 12), arg2,
                               string.sub(arg1, 10));
            elseif (string.sub(arg1, 0, 8) == "btpaddcc") then
                    btp_set_cc(nil, arg2, nil);
            elseif (string.sub(arg1, 0, 5) == "btpcc") then
                    doCC = true;
                    addonCmd = true;
            elseif (string.sub(arg1, 0, 10) == "btprelease") then
                if (dontRelease) then
                    dontRelease = false;
                    SendChatMessage("I will release spirit.",
                                    "WHISPER", nil, arg2);
                else
                    dontRelease = true;
                    SendChatMessage("I will no longer release spirit.",
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 6) == "btppop") then
                if (dontPop) then
                    dontPop = false;
                    SendChatMessage("I will res.", "WHISPER", nil, arg2);
                else
                    dontPop = true;
                    SendChatMessage("I will no longer res.",
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 10) == "btpdecurse") then
                if (blockOnDecurse) then
                    blockOnDecurse = false;
                    SendChatMessage("I will _not_ block on decurse.",
                                    "WHISPER", nil, arg2);
                else
                    blockOnDecurse = true;
                    SendChatMessage("I will block on decurse.",
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 7) == "btpsend") then
                    x, y = string.find(string.sub(arg1, 9), "%s");
                    SendChatMessage(string.sub(arg1, y + 9),
                                    "WHISPER", nil, string.sub(arg1, 9, y + 7));
            elseif (string.sub(arg1, 0, 8) == "btpparty") then
                    SendChatMessage(string.sub(arg1, 10), "PARTY", nil);
            elseif (string.sub(arg1, 0, 7) == "btpraid") then
                    SendChatMessage(string.sub(arg1, 9), "RAID", nil);
            elseif (string.sub(arg1, 0, 15) == "btpbattleground") then
                    SendChatMessage(string.sub(arg1, 17), "BATTLEGROUND", nil);
            elseif (string.sub(arg1, 0, 7) == "btpitem") then
                if (string.sub(string.sub(arg1, 9), 0, 5) == "trade") then
                    TradeItem(string.sub(arg1, 16), arg2);
                elseif (string.sub(string.sub(arg1, 9), 0, 5) == "drink") then
                    for bag=0,4 do
                      for slot=1,C_Container.GetContainerNumSlots(bag) do
                        if (C_Container.GetContainerItemLink(bag,slot) and
                            C_Container.GetContainerItemLink(bag,slot) ==
                            string.sub(arg1, 16)) then
                            FuckBlizUseContainerItem(bag,slot);
                            return true;
                        end
                      end
                    end
                else
                    for bag=0,4 do
                      for slot=1,C_Container.GetContainerNumSlots(bag) do
                        if (C_Container.GetContainerItemLink(bag,slot)) then
                           itemName, itemLink, itemRarity, itemLevel,
                           itemMinLevel, itemType, itemSubType, itemStackCount,
                           itemEquipLoc, invTexture = 
                           GetItemInfo(C_Container.GetContainerItemLink(bag,slot));
                   
                           if (itemType == "Consumable") then
                               SendChatMessage(itemLink, "WHISPER",
                                               nil, arg2);
                           end
                        end
                      end
                    end
                end
            elseif (string.sub(arg1, 0, 9) == "btphplist") then
                for i = 0, pcount do                   
                    if (PRIORITY_G[i]) then
                        SendChatMessage("P" .. i .. ": " .. PRIORITY_G[i] ..
                                        ".", "WHISPER", nil, arg2);
                    end
                end
            elseif (string.sub(arg1, 0, 9) == "btpfelist") then
                for i = 0, fecount do                   
                    if (FE_G[i]) then
                        SendChatMessage("P" .. i .. ": " .. FE_G[i] ..
                                        ".", "WHISPER", nil, arg2);
                    end
                end
            elseif (string.sub(arg1, 0, 8) == "btphpdel") then
                    btp_heal_priority_del();
                    SendChatMessage("Cleared priority list!",
                                    "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 8) == "btphpadd") then
                    btp_heal_priority_add(string.sub(arg1, 10));
                    SendChatMessage("Added " .. string.sub(arg1, 10) ..
                                    " to the priority list.",
                                    "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 8) == "btpfedel") then
                    btp_follow_exclusion_del();
                    SendChatMessage("Cleared follow exclusion list!",
                                    "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 8) == "btpfeadd") then
                    btp_follow_exclusion_add(string.sub(arg1, 10));
                    SendChatMessage("Added " .. string.sub(arg1, 10) ..
                                    " to the follow exclusion list.",
                                    "WHISPER", nil, arg2);
            elseif (string.sub(arg1, 0, 9) == "btpfollow") then
                if (manualFollow) then
                    manualFollow = false;
                    manualFollowName = "no one"
                    SendChatMessage("I am now in guild follow mode.",
                                    "WHISPER", nil, arg2);
                else
                    manualFollowName = string.sub(arg1, 11);
                    manualFollow = true;
                    SendChatMessage("I am now following " .. manualFollowName,
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 10) == "btpwhisper") then
                if (whisperPlayer ~= "no one") then
                    whisperPlayer = "no one";
                    SendChatMessage("I am now relaying whispers to " ..
                                    whisperPlayer .. ".", "WHISPER", nil, arg2);
                else
                    whisperPlayer = string.sub(arg1, 12);
                    SendChatMessage("I am now relaying whispers to " ..
                                    whisperPlayer .. ".", "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 12) == "btpinnervate") then
                if (iTarget ~= UnitName("player")) then
                    iTarget = UnitName("player");
                    SendChatMessage("I will now innervate " ..
                                    iTarget .. ".", "WHISPER", nil, arg2);
                else
                    iTarget = string.sub(arg1, 12);
                    SendChatMessage("I will now innervate " ..
                                    iTarget .. ".", "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 6) == "btppvp") then
                BTP_Pvp();
                if (pvpBot) then
                    SendChatMessage("Now in PVP follow mode.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("Now in non-PVP follow mode.",
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 9) == "btpfarmbg") then
                BTP_Farm_BG();
                if (farmBG) then
                    SendChatMessage("Now in BG farm mode.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("Now in non-bg-farm mode.",
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 14) == "btpfarmdungeon") then
                BTP_Farm_Dungeon();
                if (farmDungeon) then
                    SendChatMessage("Now in Dungeon farm mode.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("Now in non-dungeon-farm mode.",
                                    "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 9) == "btpinvite") then
                InviteUnit(arg2);
            elseif (string.sub(arg1, 0, 9) == "btpstatus") then
                for i=1, MAX_BATTLEFIELD_QUEUES do
                        status, mapName, instanceID = GetBattlefieldStatus(i);
                        if (status == "active") then
                            break;
                        end
                end

                for i = 1, GetNumRaidMembers() do
                    nextPlayer = "raid" .. i;

                    for j = 0, GetNumGuildMembers(true) do
                        name, rank, rankIndex, level, class, zone, note,
                        officernote, online, status = GetGuildRosterInfo(j);

                        if (name and UnitName(nextPlayer) and
                            name == UnitName(nextPlayer) and
                            UnitName("player") ~= UnitName(nextPlayer)) then
                           partyOK = true;
                        end
                    end
                end

                if (GetNumRaidMembers() <= 0) then
                    for i = 1, GetNumPartyMembers() do
                        nextPlayer = "party" .. i;

                        for j = 0, GetNumGuildMembers(true) do
                            name, rank, rankIndex, level, class, zone, note,
                            officernote, online, status = GetGuildRosterInfo(j);

                            if (name and UnitName(nextPlayer) and
                                name == UnitName(nextPlayer) and
                                UnitName("player") ~= UnitName(nextPlayer)) then
                               partyOK = true;
                            end
                        end
                    end
                end

                if (instanceID == 0) then
                    SendChatMessage("I am in " .. GetZoneText() ..
                                    " in the " .. GetSubZoneText(),
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("I am in " .. GetZoneText() ..
                                    " in the " .. GetSubZoneText() .. 
                                    " instance number " .. instanceID,
                                    "WHISPER", nil, arg2);
                end

                if (pvpBot) then
                    SendChatMessage("I am in PVP follow mode tagged to " ..
                                    manualFollowName .. ".", "WHISPER", nil,
                                    arg2);
                else
                    SendChatMessage("I am in guild follow mode tagged to " ..
                                    manualFollowName .. ".", "WHISPER", nil,
                                    arg2);
                end

                if (not btpFollow) then
                    SendChatMessage("I am currently being told to stand still.",
                                    "WHISPER", nil, arg2);
                end

                SendChatMessage("I am now in " .. lootMode .. " loot mode.",
                                "WHISPER", nil, arg2);

                SendChatMessage("I am relaying all my whispers to " ..
                                whisperPlayer .. ".", "WHISPER", nil, arg2);

                SendChatMessage("I will innervate " .. iTarget .. ".",
                                "WHISPER", nil, arg2);

                if (dontHearth) then
                    SendChatMessage("I will not use my hearthstone.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("I will use my hearthstone.",
                                    "WHISPER", nil, arg2);
                end

                if (dontRelease) then
                    SendChatMessage("I will not release spirit.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("I will release spirit.",
                                    "WHISPER", nil, arg2);
                end

                if (dontPop) then
                    SendChatMessage("I will not res.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("I will res.",
                                    "WHISPER", nil, arg2);
                end

                if (blockOnDecurse) then
                    SendChatMessage("I will block on decurse.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("I will _not_ block on decurse.",
                                    "WHISPER", nil, arg2);
                end

                if (dontBeg) then
                    SendChatMessage("I will not beg for change.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("I will beg for change if left alone.",
                                    "WHISPER", nil, arg2);
                end

               if (btpRaidHeal) then
                    SendChatMessage("I will heal in raid mode!",
                                    "WHISPER", nil, arg2);
               else
                    SendChatMessage("I will heal in normal mode!",
                                    "WHISPER", nil, arg2);
               end

               if (UnitClass("player") == "Shaman" and earthShieldManual) then
                    SendChatMessage(earthShieldPlayer ..
                                    " is my earth shield target.",
                                    "WHISPER", nil, arg2);
               elseif (UnitClass("player") == "Shaman" and pcount > 0) then
                    SendChatMessage("I will use my priority list to " ..
                                    "set my earth shield target!",
                                    "WHISPER", nil, arg2);
               elseif (UnitClass("player") == "Shaman") then
                    SendChatMessage("I have no earth shield target!",
                                    "WHISPER", nil, arg2);
               end

               if (dontCheckDist) then
                    SendChatMessage("I will NOT check distance!",
                                    "WHISPER", nil, arg2);
               else                 
                    SendChatMessage("I will check distance!",
                                    "WHISPER", nil, arg2);
               end

               if (botSelfHeal) then
                    SendChatMessage("I will do big heals on myself before" ..
                                    " others!", "WHISPER", nil, arg2);
               else
                    SendChatMessage("I will NOT put big heals on myself" ..
                                    " before others!", "WHISPER", nil, arg2);
               end

               SendChatMessage("My priority list is below:",
                               "WHISPER", nil, arg2);
               for i = 0, pcount do
                   if (PRIORITY_G[i]) then
                       SendChatMessage("P" .. i .. ": " .. PRIORITY_G[i] ..
                                       ".", "WHISPER", nil, arg2);
                   end
               end

               SendChatMessage("My follow exclusion list is below:",
                               "WHISPER", nil, arg2);
               for i = 0, fecount do
                   if (FE_G[i]) then
                       SendChatMessage("FE" .. i .. ": " .. FE_G[i] ..
                                       ".", "WHISPER", nil, arg2);
                   end
               end

               if (PRIORITY_ONLY) then
                    SendChatMessage("I will only heal my priority list!",
                                    "WHISPER", nil, arg2);
               else
                    SendChatMessage("I will heal everyone!",
                                    "WHISPER", nil, arg2);
               end

                if (UnitHealth("player") <= 1 and
                    not partyOK) then
                    corpseX, corpseY = GetCorpseMapPosition();
                    corpseX = corpseX * 100;
                    corpseY = corpseY * 100;
                    SendChatMessage("I am dead and my corpse is at " ..
                                    corpseX .. " " .. corpseY ..
                                    ".  Please help me!",
                                    "WHISPER", nil, arg2);
                elseif(partyOK) then
                    SendChatMessage("I am currently busy at the moment.  Try me again later.",
                                    "WHISPER", nil, arg2);
                else
                    SendChatMessage("I have some free time! Send me an invite and I will join you!  Oh and do not forget to reset my settings if need be.", "WHISPER", nil, arg2);
                end
            elseif (string.sub(arg1, 0, 2) == "wl" or
                    string.sub(arg1, 0, 2) == "gb") then
                -- DO NOTHING
            else
                if (whisperPlayer ~= "no one") then
                    SendChatMessage("[" .. arg2 .. "] " .. arg1,
                                    "WHISPER", nil, whisperPlayer);
                end
            end

            return true;
        end

        if (whisperPlayer ~= "no one") then
            SendChatMessage("[" .. arg2 .. "] " .. arg1,
                            "WHISPER", nil, whisperPlayer);
        elseif (pvpBot) then
            lastChatter = GetTime();
            newChatter = true;
            chatterPlayer = arg2;
            chatterMessage = arg1;
        end
    end
end

function DontBeg()
    if (dontBeg) then
        dontBeg = false;
        btp_frame_debug("BEGGING -- On.");
    else
        dontBeg = true;
        btp_frame_debug("BEGGING -- Off.");
    end
end

function DontHearth()
    if (dontHearth) then
        dontHearth = false;
        btp_frame_debug("HEARTHING -- On.");
    else
        dontHearth = true;
        btp_frame_debug("HEARTHING -- Off.");
    end
end

function DontRelease()
    if (dontRelease) then
        dontRelease = false;
        btp_frame_debug("RELEASE SPIRIT -- On.");
    else
        dontRelease = true;
        btp_frame_debug("RELEASE SPIRIT -- Off.");
    end
end

function DontPop()
    if (dontPop) then
        dontPop = false;
        btp_frame_debug("RES -- On.");
    else
        dontPop = true;
        btp_frame_debug("RES -- Off.");
    end
end

function DecurseToggle()
    if (blockOnDecurse) then
        blockOnDecurse = false;
        btp_frame_debug("BLOCK ON DECURSE -- Off.");
    else
        blockOnDecurse = true;
        btp_frame_debug("BLOCK ON DECURSE -- On.");
    end
end

function DistCheck()
   if (dontCheckDist) then
        dontCheckDist = false;
        btp_frame_debug("Distance Checking -- On.");
   else
        dontCheckDist = true;
        btp_frame_debug("Distance Checking -- Off.");
   end
end

function RaidHeal()
   if (btpRaidHeal) then
        btpRaidHeal = false;
        btp_frame_debug("RAID HEAL -- Off.");
   else
        btpRaidHeal = true;
        btp_frame_debug("RAID HEAL -- On.");
   end
end

function BTP_Pvp()
    if (pvpBot) then
        pvpBot = false;
        btp_frame_debug("BOT -- Now in normal mode.");
    else
        pvpBot = true;
        btp_frame_debug("BOT -- Now in PVP mode.");
    end
end

function BTP_Farm_BG()
    if (farmBG) then
        farmBG = false;
        btp_frame_debug("BOT -- Now in normal mode.");
    else
        farmBG = true;
        btp_frame_debug("BOT -- Now in BG Farm mode.");
    end
end

function BTP_Farm_Dungeon()
    if (farmDungeon) then
        farmDungeon = false;
        btp_frame_debug("BOT -- Now in normal mode.");
    else
        farmDungeon = true;
        btp_frame_debug("BOT -- Now in Dungeon Farm mode.");
    end
end

function BTP_Follow()
    if (manualFollow) then
        manualFollow = false;
        btp_frame_debug("BOT -- Now in guild follow mode.");
    else
        manualFollow = true;
        manualFollowName = UnitName("target");
        btp_frame_debug("BOT -- Now following " .. manualFollowName .."!");
    end
end

function BTP_Innervate()
    if (iTarget ~= UnitName("player")) then
        iTarget = UnitName("player");
        btp_frame_debug("BOT -- will now innervate self.");
    else
        iTarget = UnitName("target");
        btp_frame_debug("BOT -- will now innervate " .. iTarget .."!");
    end
end

function BTP_Stop()
    btpFollow = false;
    btp_frame_debug("BOT -- Will not follow.");
end

function BTP_Start()
    btpFollow = true;
    btp_frame_debug("BOT -- In follow mode.");
end

function SelfHeal(healthThresh, manaThresh)
    hasHealthStone = false;
    healthStoneBag = 0;
    healthStoneSlot = 1;
    hasManaPotion = false;
    manaPotionBag = 0;
    manaPotionSlot = 1;
    hasHealthPotion = false;
    healthPotionBag = 0;
    healthPotionSlot = 1;

    hasHealthStone, healthStoneBag, healthStoneSlot = btp_get_item("Healthstone");

    isArena, isRegistered = IsActiveBattlefieldArena();
    if (not isArena) then
        hasManaPotion, manaPotionBag, manaPotionSlot = btp_get_item("Mana Potion");
        hasHealthPotion, healthPotionBag, healthPotionSlot = btp_get_item("Healing Potion");
    end

    if (GetNumBattlefieldScores() > 0 and not isArena) then
        hasManaPotion, manaPotionBag, manaPotionSlot = btp_get_item("Mana Draught");
        hasHealthPotion, healthPotionBag, healthPotionSlot = btp_get_item("Healing Draught");
    end

    if (hasHealthStone and UnitAffectingCombat("player") and
        UnitHealth("player")/UnitHealthMax("player") <= healthThresh) then
        FuckBlizUseContainerItem(healthStoneBag, healthStoneSlot);
        return true;
    elseif (hasHealthPotion and
            UnitHealth("player")/UnitHealthMax("player") <= healthThresh and
            UnitAffectingCombat("player")) then
        FuckBlizUseContainerItem(healthPotionBag, healthPotionSlot);
        return true;
    elseif (hasManaPotion and UnitAffectingCombat("player") and
            UnitPower("player")/UnitPowerMax("player") <= manaThresh) then
        FuckBlizUseContainerItem(manaPotionBag, manaPotionSlot);
        return true;
    end

    return false;
end

function TradeItem(itemName, playerName)
    unitName = nil;
    itemBag = nil;
    itemSlot = nil;
    freeBag = nil;
    freeSlot = nil;
    isStack = false;

    if (itemName and 
       (string.find(itemName, "Bandage") or
        string.find(itemName, "Healing Potion") or
        string.find(itemName, "Mana Potion") or
        string.find(itemName, "Milk") or
        string.find(itemName, "Nectar") or
        string.find(itemName, "Juice") or
        string.find(itemName, "Dew") or
        string.find(itemName, "Ethermead") or
        string.find(itemName, "Manna Lollipop") or
        string.find(itemName, "Manna Biscuit") or
        string.find(itemName, "Manna Cookie") or
        string.find(itemName, "Manna Cake") or
        string.find(itemName, "Manna Brownie") or
        string.find(itemName, "Manna Strudel") or
        string.find(itemName, "Manna Pie") or
        string.find(itemName, "Star's Tears") or
        string.find(itemName, "Water"))) then
        isStack = true;
    end

    for i = 1, GetNumRaidMembers() do
        nextPlayer = "raid" .. i;

        if (playerName and UnitName(nextPlayer) and
            playerName == UnitName(nextPlayer) and
            UnitName("player") ~= UnitName(nextPlayer)) then

           if (btp_check_dist(nextPlayer, 1)) then
               unitName = nextPlayer;
           end
        end
    end

    if (GetNumRaidMembers() <= 0) then
        for i = 1, GetNumPartyMembers() do
            nextPlayer = "party" .. i;

            if (playerName and UnitName(nextPlayer) and
                playerName == UnitName(nextPlayer) and
                UnitName("player") ~= UnitName(nextPlayer)) then

               if (btp_check_dist(nextPlayer, 1)) then
                   unitName = nextPlayer;
               end
            end
        end
    end

    for bag=0,4 do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot)) then
          if (C_Container.GetContainerItemLink(bag,slot) == itemName) then
              itemBag = bag;
              itemSlot = slot;
          end
        else
            if (not freeBag and not freeSlot) then
                freeBag = bag;
                freeSlot = slot;
            end
        end
      end
    end

    if (unitName and itemBag and itemSlot) then
        if (not CursorHasItem() and isStack) then
            PickupContainerItem(itemBag, itemSlot);
        elseif (not CursorHasItem()) then
            SplitContainerItem(itemBag, itemSlot, 1);
            PickupContainerItem(freeBag, freeSlot);
            doTrade = true;
            tradeName = unitName;
        end

        if (CursorHasItem()) then
           DropItemOnUnit(unitName);
        end
    end
end

-- function to add and remove priorities
function btp_loot(mode)
    lootMode = mode;
    btp_frame_debug("Loot Mode is now: " .. mode);
end;

-- our global priority list
PRIORITY_G = { };

-- function to add and remove priorities
function btp_heal_priority_add(pname)
        if (pname == "target") then
            pname = string.lower(UnitName("target"));
            PRIORITY_G[pcount] = string.lower(UnitName("target"));
        else
            PRIORITY_G[pcount] = string.lower(pname);
        end

        pcount = pcount + 1;
        btp_frame_debug("Added priority #" .. pcount .. ": " .. pname);
end;

function btp_heal_priority_del()
        PRIORITY_G = { };
        pcount = 0;
end

function btp_heal_priority_list()
        for i = 0, pcount - 1 do
            btp_frame_debug("P" .. i .. ": " .. PRIORITY_G[i]);
        end
end

function btp_heal_priority_check(unit)
    if(pcount > 0) then
        for j = 0, pcount do
            pval = PRIORITY_G[j];
            if (string.lower(UnitName(unit)) == string.lower(pval)) then
                return true;
            end
        end
    end
    return false;
end

-- our global priority list
FE_G = { };

-- function to add and remove follow exclusions
function btp_follow_exclusion_add(pname)
        for i = 0, fecount - 1 do
            if (FE_G[i] == string.lower(pname)) then
                return;
            end
        end

        FE_G[fecount] = string.lower(pname);
        fecount = fecount + 1;
        btp_frame_debug("Added follow exclusion #" .. fecount .. ": " .. pname);
end;

function btp_follow_exclusion_del()
        FE_G = { };
        fecount = 0;
end

function btp_follow_exclusion_list()
        for i = 0, fecount - 1 do
            btp_frame_debug("FE" .. i .. ": " .. FE_G[i]);
        end
end

function btp_round(num, idp)
        return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

function btp_is_cc()
        return false;
end

function btp_spell_damage(sname)
    --
    -- Not sure how to do this yet, but if we can get the damage
    -- for a particular spell and the durration of the effect
    -- this could be useful in the future.  For now, the warlock
    -- "Drain Soul" spell is used.  Please feel free to add more.
    --

    --
    -- Make sure we have data on this spell.
    --
    if (btp_dmg_array[sname] == nil) then
        return 0;
    end

    sid = btp_get_spell_id(sname);

    if (sid ~= nil) then
        spellName, spellRank = GetSpellBookItemName(sid, BOOKTYPE_SPELL);
        speed, low, high, pos, neg = UnitRangedDamage("player");
        return (btp_dmg_array[sname][spellRank] + high + pos + neg);
    else
        return 0;
    end

end

function btp_check_player_buff(buff)
    return btp_check_buff(buff, "player");
end

-- Returns:
--     hasBuff:    (true | false)
--     myBuff:     (true | false)
--     stackNum:   Number of buffs in the stack if myBuff is true, otherwise
--                 this returns the sum of all buffs of this type and their
--                 stack numbers.
--     expBuff:    seconds until expiration 
--
function btp_check_buff(buff, unit)
    local i = 1;
    local hasBuff = false;
    local stackNum = 0;
    local buffName = "foo";

    if (not unit) then
        unit="player";
    end

    while (buffName) do
        buffName, buffIcon, buffCount, dispelType, duration,
        expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer,
        nameplateShowAll, timeMod = UnitBuff(unit, i);

        if (expirationTime == nil) then
            expirationTime = 0;
        end

        if (buffName and source == "player" and
            strfind(buffName, buff)) then
            return true, true, buffCount, (expirationTime - GetTime());
        elseif (buffName and strfind(buffName, buff)) then
            hasBuff = true;
            stackNum = stackNum + buffCount;
        end

        i = i + 1;
    end

    if (hasBuff) then
        return true, false, stackNum, (expirationTime - GetTime());
    else
        return false, false, 0, 0;
    end
end

function btp_check_player_debuff(buff)
        return btp_check_debuff(buff, "player");
end

-- Returns:
--     hasDebuff:    (true | false)
--     myDebuff:     (true | false)
--     stackNum:     Number of debuffs in the stack if myDebuff is true,
--                   otherwise this returns the sum of all debuffs of
--                   this type and their stack numbers.
--     dispelType:   Curse, Disease, Magic, Poison
--
function btp_check_debuff(buff, unit)
    local i = 1;
    local hasDebuff = false;
    local stackNum = 0;
    local debuffName = "foo";

    if (not unit) then
        unit="player";
    end

    while (debuffName) do
        debuffName, debuffIcon, debuffCount, dispelType, duration,
        expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer,
        nameplateShowAll, timeMod = UnitDebuff(unit, i);

        if (expirationTime == nil) then
            expirationTime = 0;
        end

        if (debuffName and source == "player" and
            strfind(debuffName, buff)) then
            return true, true, debuffCount, (expirationTime - GetTime()), dispelType;
        elseif (debuffName and strfind(debuffName, buff)) then
            hasDebuff = true;
            stackNum = stackNum + debuffCount;
        end

        i = i + 1;
    end

    if (hasDebuff) then
        return true, false, stackNum, (expirationTime - GetTime()), dispelType;
    else
        return false, false, 0, 0, nil;
    end
end

function btp_save_previous_state()
    -- record our previous state, might not need this
    btp_state_set("previous_cb_spell", btp_state_get("current_cb_spell"));
    btp_state_set("previous_cb", btp_state_get("current_cb"));
    btp_state_set("previous_cb_target", btp_state_get("current_cb_target"));
    btp_state_set("previous_cb_target_name", btp_state_get("current_cb_target_name"));
    local cb_start_time = btp_state_get("current_cb_start_time") or 0;
    btp_state_set("previous_cb_runtime", GetTime() - cb_start_time);
end

function btp_clear_callback_state()
    btp_state_set("current_cb_spell", nil);
    btp_state_set("current_cb", nil);
    btp_state_set("current_cb_target", nil);
    btp_state_set("current_cb_target_name", nil);
    btp_state_set("current_cb_start_time", nil);
end

function btp_stop_casting(sname, unit)
    btp_save_previous_state();
    btp_clear_callback_state()
    current_cb = nil;
    btp_debug("STOP CASTING");
    FuckBlizzardByNameStrange("stopcasting");
    return false;
end

-- TODO: make this run btp_class_callback("spell_threshold_cb", sname)
function get_class_heal_threshold(sname)
    return .98;
end

function btp_cb_generic_heal(sname)
    -- get basic unit info
    local unit_name = UnitName(current_cb_target) or "Unknown";
    local unit_health = UnitHealth(current_cb_target);
    local unit_health_max = UnitHealthMax(current_cb_target) or 1;
    local unit_health_pct = unit_health / unit_health_max;
    -- get the spell stop threshold
    local class_threshold = get_class_heal_threshold(sname);
    btp_debug("spell: " .. sname .. " on " .. current_cb_target .. " name: " .. unit_name);

    if (unit_health < 1) then
        btp_debug(unit_name .. " is dead stop cast");
        btp_stop_casting();
        return false;
    end
    btp_debug("unit_name: " .. unit_name .. " is alive");

    -- check if they no longer need the heal
    if (unit_health_pct > class_threshold) then
        btp_debug(unit_name .. " is above threshold for " .. sname);
        btp_stop_casting();
        return false;
    end
    btp_debug("unit_name: " .. unit_name .. " is above threshold");

    -- if we are in bot mode check distance to follow player
    -- if they are running away stop casting.
    if (btp_bot_should_start_following()) then
        btp_debug("follow player is running away stop cast");
        btp_stop_casting();
        return false;
    end
    btp_debug("CONTINUE spell: " .. sname .. " on " .. current_cb_target .. " name: " .. unit_name);
    return true;
end

function btp_cb_generic_dps(sname)
    cast_spell, cast_rank, cast_display_name, cast_icon, cast_start_time,
    cast_end_time, cast_is_trade_skill = UnitCastingInfo("player");

    -- May just be beteen casts, so let it stand, otherwise we should
    -- clear the callback if it's not the spell we expect.
    if (cast_spell == nil) then
        btp_debug("cast_spell is nil");
        return false;
    elseif (cast_spell ~= sname) then
        -- Well we are not casting our spell, so we can clear the callback.
        btp_debug("cast_spell " .. cast_spell .. " does not match " .. sname);
        btp_stop_casting();
        return false;
    end

    -- if we are in bot mode check distance to follow player
    -- if they are running away stop casting.
    if (btp_bot_should_start_following()) then
        btp_debug("follow player is running away stop cast");
        btp_stop_casting();
        return false;
    end
end

-- returns true if follow_unit is in danger of going out of range
function btp_bot_should_start_following()
    -- first check to see if we should stop moving
    local stop_moving = btp_state_get("stop_moving");
    if (stop_moving) then return false; end
    if (stopMoving) then return false; end 

    -- not told to stop moving so check if we have a follow unit
    local follow_unit = btp_state_get("follow_unit");
    if (not follow_unit) then return false; end
    -- check if we are getting out of range
    if (not btp_check_dist(follow_unit, 2) and btp_check_dist(follow_unit, 4)) then
        return true;
    end
    -- still in range so return false
    return false;
end

-- used to strip off the rank of a spell
function btp_get_base_spellname(rankedSpellName)
    -- local baseSpellName = string.match(rankedSpellName, "^(.-)%s*(%(Rank %d+%)%)?$");
    local baseSpellName = string.match(rankedSpellName, "^(.-)%s*%(Rank %d+%)?$")
    return baseSpellName or rankedSpellName
end

function btp_set_cb(sname, tname)
    if (cb_array[sname] ~= nil) then
        btp_debug("setting callback to " .. sname .. " on " .. tname .. " - " .. UnitName(tname));
        current_cb = cb_array[sname];
        current_cb_target = tname;
    end
    -- if we dont have a match check to see if a ranked spell was passed in
    -- if so look for a matching non-ranked spell
    local base_spell = btp_get_base_spellname(sname) or nil;
    if (base_spell ~= nil and cb_array[base_spell] ~= nil) then
        btp_debug("setting base callback to " .. base_spell .. " on " .. tname .. " - " .. UnitName(tname));
        current_cb = cb_array[base_spell];
        current_cb_target = tname;
    end

    -- record our previous state, might not need this
    btp_save_previous_state()
    -- update our current state
    btp_state_set("current_cb", cb_array[sname]);
    btp_state_set("current_cb_spell", base_spell);
    btp_state_set("current_cb_target", tname);
    btp_state_set("current_cb_target_name", UnitName(tname));
    btp_state_set("current_cb_start_time", GetTime());
end

-- you can use this kind like a sleep to wait for something
BTP_TIMER_RUNNING = false
function btp_wait(duration)
    BTP_TIMER_RUNNING = true
    C_Timer.After(duration, function()
        BTP_TIMER_RUNNING = false
    end)
end

function btp_cast_spell(sname)
    return btp_cast_spell_on_target(sname, "target");
end

function btp_cast_spell_alt(sname)
    return btp_cast_spell_on_target_alt(sname, "target");
end

function btp_get_best_ranked_spell(spell_name, unit)
    local unit_level = UnitLevel(unit)
    local highest_rank = 0
    local highest_rank_spell = nil
    -- if we dont have an entry just use the max ranked spell
    if (not BTP_SPELL_LEVEL_REQ[spell_name]) then return spell_name; end
    for rank, level_req in pairs(BTP_SPELL_LEVEL_REQ[spell_name]) do
        local spellRankName = spell_name .. "(Rank " .. rank .. ")";
        -- if we dont know the rank then return the highest we have
        if (not btp_get_spell_id(spellRankName)) then break; end
        if level_req <= unit_level and rank > highest_rank then
            highest_rank = rank
            highest_rank_spell = spell_name .. "(Rank " .. rank .. ")"
        end
    end
    btp_debug(unit .. " highest ranked spell: " .. highest_rank_spell)
    return highest_rank_spell
end

function btp_cast_spell_on_target(sname, tname)
    btp_debug("attempting to cast: " .. sname .. " On: " .. tname);
    if (not UnitIsConnected(tname)) then
        btp_debug("unit is not connected: " .. tname);
        return false;
    end

    if (not sname or not tname) then
        btp_debug("invalid args");
        return false;
    end

    if (not btp_spell_known(sname)) then
        btp_debug("unknown: " .. sname);
        return false;
    end

    if (tname ~= "player" and not btp_in_range(sname, tname)) then
        btp_debug("OUT OF RANGE: " .. sname .. " On: " .. tname);
        return false;
    end

    if (btp_can_cast(sname)) then
        btp_debug("we can cast: " .. sname .. " On: " .. tname);
        btp_set_cb(sname, tname);

        -- some healing spells will not work on low level units.
        -- check if we mapped the spell to a rank
        -- this has to be inside btp_can_cast since we dont index any ranked spells
        local ranked_spell = btp_get_best_ranked_spell(sname, tname)
        if (ranked_spell) then
            btp_debug("got ranked spell: " .. ranked_spell);
            sname = ranked_spell;
            --[[ TODO: check if the spell will WAY overheal.
            if (btp_config_get(OVERHEAL_LIMIT) and
                btp_check_overheal(ranked_spell, tname)) then
                    -- if the spell is an overheal return false
                    return false;
            end
            ]]
        end

        if (tname ~= "target") then
            FuckBlizzardTargetUnit(tname);
        end

        btp_debug("CASTING: " .. sname .. " on: " .. tname);
        FuckBlizzardByName(sname);
        return true;
    else
    	btp_debug("can not cast: " .. sname .. " On: " .. tname);
    end

    return false;
end

function btp_check_overheal(ranked_spell, tname)
    return false;
end

function btp_cast_spell_on_target_alt(sname, tname)
        if (not sname or not tname) then
            return false;
        end

        if (not btp_spell_known(sname)) then
                return false;
        end

        if (btp_can_cast(sname)) then
                -- btp_frame_debug("Cast Alt: " .. sname .. " On: " .. tname);
                if (tname ~= "target") then
                    FuckBlizzardTargetUnitAlt(tname);
                end

                FuckBlizzardByNameAlt(sname);
                return true;
        end

        return false;
end

function btp_can_cast(sname)
    if(sname == nil) then
        return false;
    end
    btp_debug("trying to cast: " .. sname);

    if(btp_spell_known(sname)) then
            local sid = btp_get_spell_id(sname);
            if(not sid) then                    
                -- btp_frame_debug(sname .. " has no SID.");
            end

            local psid = btp_get_spell_id_pet(sname);
            if(not psid) then                    
                -- btp_frame_debug(sname .. " has no PID.");
            end

            if (sid) then
                -- btp_frame_debug("SID: " .. sid);
                if (GetSpellCooldown(sid, BOOKTYPE_SPELL) == 0) then
                    return true;
                else
                    -- btp_frame_debug(sname .. " is in cooldown");
                end
            elseif (psid) then
                -- btp_frame_debug("PSID: " .. psid);
                if (GetSpellCooldown(psid, BOOKTYPE_PET) == 0) then
                    return true;
                else
                    -- btp_frame_debug(sname .. " is in cooldown");
                end
            end
    end
    return false;
end 

function btp_spell_known(sname)
    local spell_id = btp_get_spell_id(sname);
    if (not spell_id) then return false; end

    usable, nomana = IsUsableSpell(spell_id, BOOKTYPE_SPELL);
    if (usable and not nomana) then
        btp_debug("spell known: " .. sname);
        return true;
    else
        btp_debug(sname .. " for player is unusable");
    end

    usable, nomana = IsUsableSpell(btp_get_spell_id_pet(sname), BOOKTYPE_PET);
    if (usable and not nomana) then
        btp_debug("pet spell known: " .. sname);
        return true;
    else
        btp_debug(sname .. " for pet is unusable");
    end

    return false;
end

function btp_has_ranked_spell(spellRankName)
    local numTabs = GetNumSpellTabs()
    for t = 1, numTabs do
        local _, _, offset, numSpells = GetSpellTabInfo(t)
        for i = 1, (offset + numSpells) do
            if GetSpellBookItemName(i, BOOKTYPE_SPELL) == spellRankName then
                return true
            end
        end
    end
    return false
end
function btp_get_spell_max_rank(spell)
    local SpellCount = 0
    local ReturnName
    local ReturnRank
    local spellRankName
    local requestedRank = tonumber(string.match(SpellName, "Rank (%d+)") or "0")
    local baseSpellName = string.match(SpellName, "(.-)%s*%(Rank %d+%)") or SpellName

    while not ReturnName or not string.find(ReturnName, baseSpellName, 1, true) do
        SpellCount = SpellCount + 1
        ReturnName, ReturnRank = GetSpellBookItemName(SpellCount, BOOKTYPE_SPELL)
        local returnedRank = tonumber(string.match(ReturnRank or "", "Rank (%d+)") or "0")
        if ReturnRank and returnedRank >= requestedRank then
            spellRankName = ReturnName .. '(' .. ReturnRank .. ')'
        else
            spellRankName = ReturnName
        end
        if not ReturnName then
            return false
        end
        btp_frame_debug("spell name: " .. spellRankName)
    end

end

function btp_get_spell_id_new(SpellName)
    local SpellCount = 0
    local ReturnName
    local ReturnRank
    local spellRankName
    local requestedRank = tonumber(string.match(SpellName, "Rank (%d+)") or "0")
    local baseSpellName = string.match(SpellName, "(.-)%s*%(Rank %d+%)") or SpellName

    while not ReturnName or not string.find(ReturnName, baseSpellName, 1, true) do
        SpellCount = SpellCount + 1
        ReturnName, ReturnRank = GetSpellBookItemName(SpellCount, BOOKTYPE_SPELL)
        local returnedRank = tonumber(string.match(ReturnRank or "", "Rank (%d+)") or "0")
        if ReturnRank and returnedRank >= requestedRank then
            spellRankName = ReturnName .. '(' .. ReturnRank .. ')'
        else
            spellRankName = ReturnName
        end
        if not ReturnName then
            return false
        end
        btp_frame_debug("spell name: " .. spellRankName)
    end

    while baseSpellName and ReturnName and string.find(ReturnName, baseSpellName, 1, true) do
        SpellID = SpellCount
        SpellCount = SpellCount + 1
        ReturnName, ReturnRank = GetSpellBookItemName(SpellCount, BOOKTYPE_SPELL)
        local returnedRank = tonumber(string.match(ReturnRank or "", "Rank (%d+)") or "0")
        if ReturnRank and returnedRank >= requestedRank then
            spellRankName = ReturnName .. '(' .. ReturnRank .. ')'
        else
            spellRankName = ReturnName
        end
        if not ReturnName then
            break
        end
        btp_frame_debug("spell_id: " .. SpellID .. " spell name: " .. spellRankName)
        if not string.find(ReturnName, baseSpellName, 1, true) then
            break
        end
    end

    return SpellID
end

function btp_get_spell_id_returns_max_rank_id(SpellName)
    local SpellCount = 0
    local ReturnName
    local ReturnRank
    local spellRankName

    while not ReturnName or not string.find(spellRankName, SpellName, 1, true) do
        SpellCount = SpellCount + 1
        ReturnName, ReturnRank = GetSpellBookItemName(SpellCount, BOOKTYPE_SPELL)
        if ReturnRank then
            spellRankName = ReturnName .. '(' .. ReturnRank .. ')';
        else
            spellRankName = ReturnName
        end
        if not ReturnName then
            return false
        end
        btp_frame_debug("spell name: " .. spellRankName)
    end

    while SpellName and ReturnName and string.find(spellRankName, SpellName, 1, true) do
        SpellID = SpellCount
        SpellCount = SpellCount + 1
        ReturnName, ReturnRank = GetSpellBookItemName(SpellCount, BOOKTYPE_SPELL)
        if ReturnRank then
            spellRankName = ReturnName .. '(' .. ReturnRank .. ')';
        else
            spellRankName = ReturnName
        end
        if not ReturnName then
            break
        end
        btp_frame_debug("spell_id: " .. SpellID .. " spell name: " .. spellRankName)
        if not string.find(spellRankName, SpellName, 1, true) then
            break
        end
    end

    return SpellID
end

BTP_SPELLBOOK = {};
BTP_SPELLBOOK_PET = {};

function btp_build_valid_spellbook(book_type)
    local SpellCount = 0
    local ReturnName
    local ReturnRank
    local spellBook = {}

    while true do
        SpellCount = SpellCount + 1
        ReturnName, ReturnRank = GetSpellBookItemName(SpellCount, book_type)
        if not ReturnName then
            break
        end
        -- add just the spell name cause if its returned at all we have it
        spellBook[ReturnName] = SpellCount;
        local returnedRank = tonumber(string.match(ReturnRank or "", "Rank (%d+)") or "0")
        for i = 1, returnedRank do
            local spellRankName = ReturnName .. "(Rank " .. i .. ")"
            spellBook[spellRankName] = SpellCount;
        end
    end
    return spellBook
end

-- improve btp_get_spell_id
function btp_get_spell_id(SpellName)
    if (next(BTP_SPELLBOOK) == nil) then
        btp_frame_debug("spell book is not initialzed, initializing now");
        BTP_SPELLBOOK = btp_build_valid_spellbook(BOOKTYPE_SPELL);
    end
    if (BTP_SPELLBOOK[SpellName]) then
        return BTP_SPELLBOOK[SpellName];
    end
    return false;
end

function btp_get_spell_id_pet(SpellName)
    if (BTP_SPELLBOOK_PET[SpellName]) then
        return BTP_SPELLBOOK_PET[SpellName];
    end
    return false
end

-- THIS IS BROKEN, not sure what the issue is yet.
function btp_iterate_targets(lists_and_iterators)
    btp_frame_debug("btp_iterate_targets IS BUSTED DONT USE");
    local index = 0
    local list_or_iterator_index = 1
    local currentListOrIterator = lists_and_iterators[list_or_iterator_index]
    local isIterator = type(currentListOrIterator) == "function"
    if isIterator then
        currentListOrIterator = currentListOrIterator()
    end

    return function()
        if not isIterator then
            index = index + 1
            if index <= #currentListOrIterator then
                return currentListOrIterator[index]
            end
        else
            local nextTarget = currentListOrIterator()
            if nextTarget then
                return nextTarget
            end
        end

        -- Move to the next list or iterator
        list_or_iterator_index = list_or_iterator_index + 1
        if list_or_iterator_index <= #lists_and_iterators then
            currentListOrIterator = lists_and_iterators[list_or_iterator_index]
            isIterator = type(currentListOrIterator) == "function"
            if isIterator then
                currentListOrIterator = currentListOrIterator()
            end
            index = 0
            return currentListOrIterator()
        end

        -- No more targets
        return nil
    end
end

--[[
TODO: this is a work in progress
function btp_iterate_friendly_targets()
    local lists_and_iterators = {{"player", "target"}, btp_iterate_group_members, btp_iterate_group_pets}
    return function()
        return btp_iterate_targets(lists_and_iterators);
    end
end
]]

-- iterates all potential friendly targets
function btp_iterate_friendly_targets_new()
    local initialList = {"target", "player"}
    local index = 0
    local groupMembersIterator = btp_iterate_group_members()
    local groupPetsIterator = btp_iterate_group_pets()

    return function()
        index = index + 1
        if index <= #initialList then
            return initialList[index]
        else
            local nextPlayer = groupMembersIterator()
            if nextPlayer then
                return nextPlayer
            else
                return groupPetsIterator()
            end
        end
    end
end

function btp_iterate_friendly_targets()
    local initialList = {"target", "player"}
    local index = 0
    local groupMembersIterator = btp_iterate_group_members()

    return function()
        index = index + 1
        if index <= #initialList then
            return initialList[index]
        else
            return groupMembersIterator()
        end
    end
end

-- TODO: rewrite to use unitinfo
function btp_health_status_quick()
    local lowest_health = 0
    local lowest_percent = 1
    local lowest_target = 0
    local largest_heal_missing = 0
    local largest_heal_target = nil
    local largest_heal_missing_percent = 1

    local function _health_status_check(player)
        if not UnitExists(player) then
            btp_debug(player .. " does not exist")
            return
        end

        if btp_config_get("DISTANCE_CHECK") and not btp_unit_in_casting_range(player) then
            btp_debug("not in range: " .. UnitName(player))
            return
        end

        local cur_class = UnitClass(player)
        local cur_health = UnitHealth(player)
        local cur_health_max = UnitHealthMax(player)
        local cur_health_missing = cur_health_max - cur_health
        local cur_percent = cur_health / cur_health_max

        -- only return the largetst heal if the player is less than 90% health
        if ((largest_heal_missing_percent < .90)
            and (cur_health_missing > 5)
            and (cur_health_missing > largest_heal_missing)) then
            largest_heal_missing = cur_health_missing
            largest_heal_target = player
            largest_heal_missing_percent = cur_health / cur_health_max
            btp_debug("NEW largest_heal_missing: " ..  largest_heal_missing
                .. " largest_heal_missing_percent: " .. largest_heal_missing_percent
                .. " largest_heal_target: " .. largest_heal_target);
        end

        if cur_health > 5 and lowest_percent > cur_percent and btp_check_dist(player, 1) then
            lowest_percent = cur_percent
            lowest_target = player
            lowest_health = cur_health_max - cur_health

            btp_debug("NEW lowest_percent: " .. lowest_percent
                .. " lowest_health: " .. lowest_health
                .. " lowest_target: " .. lowest_target);
            if btp_heal_priority_check(lowest_target) then
                btp_debug("priority target: " .. lowest_target
                    .. " lowest_percent: " .. lowest_percent
                    .. " lowest_health: " .. lowest_health);
                return lowest_percent, lowest_health, lowest_target
            end
        end
    end

    -- process player and target first
    for nextPlayer in btp_iterate_friendly_targets() do _health_status_check(nextPlayer); end

    if btp_config_get("PRIORITY_ONLY") then
        btp_debug("PRIORITY_ONLY is set, skipping group and pet checks")
        return false;
    end
    if btp_config_get("HEAL_PETS") then
        for nextPet in btp_iterate_group_pets() do
            _health_status_check(nextPet)
        end
    end

    -- if the health mising is larget than the person with the lowest percent
    -- chances are its a tank and should take priority since it has a larger health pool
    if largest_heal_missing > 1 and largest_heal_missing > lowest_health then
        btp_debug("largest_heal_missing: " .. largest_heal_missing .. " largest_heal_missing_percent: " .. largest_heal_missing_percent .. " largest_heal_target: " .. largest_heal_target)
        return largest_heal_missing_percent, largest_heal_missing, largest_heal_target
    end

    -- if lowest_percent is not defined or 1 then we have no one to heal
    if not lowest_percent or lowest_percent == 1 then return false; end

    btp_debug("lowest_percent: " .. lowest_percent .. " lowest_health: " .. lowest_health .. " lowest_target: " .. lowest_target);
    return lowest_percent, lowest_health, lowest_target
end

function btp_unit_is_pet(unit)
    if not UnitExists(unit) then return false; end

    local classification = UnitClassification(unit)
    local creatureFamily = UnitCreatureFamily(unit)
    if classification == "pet" and creatureFamily ~= nil then return true;
    else return false; end
end

function btp_dont_follow(name)
    if (name == nil) then
        return true;
    end

    if(fecount > 0) then
        for j = 0, fecount - 1 do
            pval = FE_G[j];

            if (string.lower(name) == string.lower(pval)) then
                return true;
            end
        end
    end

    return false;
end


function btp_health_status(thresh)
    btp_health_status(thresh, false);
end

-- This function should make some basic priority decisions
-- on who should get a heal.
function btp_health_status(thresh, raidHeal)
    skipPlayer       = false;
    cur_heal         = nil;
    cur_priority     = 0;
    cur_heal_percent = 1;
    cur_percent      = 0;
    cur_subgroup     = 1;
    party_cnt        = 0;
    raid_cnt         = 0;

    party_status[1] = 0;
    party_status[2] = 0;
    party_status[3] = 0;
    party_status[4] = 0;
    party_status[5] = 0;
    party_status[6] = 0;
    party_status[7] = 0;
    party_status[8] = 0;

    if (UnitClass("player") == "Druid") then
        spell = "Healing Touch";
    elseif (UnitClass("player") == "Priest") then
        spell = "Lesser Heal";
    elseif (UnitClass("player") == "") then
        spell = "Lesser Heal";
    end

    for nextPlayer in btp_iterate_group_members() do
        cur_health     = UnitHealth(nextPlayer);
        cur_health_max = UnitHealthMax(nextPlayer);
        cur_class      = UnitClass(nextPlayer);
        cur_threat     = UnitThreatSituation(nextPlayer);
        cur_percent    = cur_health / cur_health_max;

        if (cur_percent <= thresh and cur_health >= 5 and
            btp_in_range(spell, nextPlayer)) then
                index = UnitInRaid(nextPlayer);
                if (index == nil) then index = 1; end
                name, rank, subgroup, level, class, fileName, zone, online,
                isDead, role, isML, combatRole = GetRaidRosterInfo(index);

                raid_cnt                   = raid_cnt + 1;
                party_cnt                  = party_cnt + 1;
                party_status[subgroup]     = party_status[subgroup] + 1;
        end
    end

    --
    -- First check our priority queue
    --
    if(pcount > 0) then
        for j = 0, pcount do
            pval = PRIORITY_G[j];

            for nextPlayer in btp_iterate_group_members() do
                cur_health     = UnitHealth(nextPlayer);
                cur_health_max = UnitHealthMax(nextPlayer);
                cur_class      = UnitClass(nextPlayer);
                cur_percent    = cur_health / cur_health_max;

                if (cur_health/cur_health_max <= thresh and
                    cur_health >= 2 and btp_in_range(spell, nextPlayer) and
                    pval and UnitName(nextPlayer) and
                    string.lower(UnitName(nextPlayer)) == string.lower(pval)) then

                    index = UnitInRaid(nextPlayer);
                    if (index == nil) then index = 1; end
                    name, rank, subgroup, level, class, fileName, zone, online,
                    isDead, role, isML, combatRole = GetRaidRosterInfo(index);

                    return nextPlayer, party_cnt, raid_cnt, party_status[subgroup];
                end
            end
        end
    end

    if(PRIORITY_ONLY) then
        return false, 0, 0, 0;
    end

    -- Now that we are done checking our priorities check
    -- to see if any party or raid members are below thresh
    for nextPlayer in btp_iterate_group_members() do
        cur_health     = UnitHealth(nextPlayer);
        cur_health_max = UnitHealthMax(nextPlayer);
        cur_class      = UnitClass(nextPlayer);
        cur_threat     = UnitThreatSituation(nextPlayer);
        cur_percent    = cur_health / cur_health_max;

        if (raidHeal and cur_threat ~= nil and cur_threat < 2) then
           skipPlayer = false;

           --
           -- Rejuvination check
           --
           hasRejuvenation, myRejuvenation,
           numRejuvenation, expRejuvination = btp_check_buff("Rejuvenation", nextPlayer);

           --
           -- Regrowth check
           --
           hasRegrowth, myRegrowth,
           numRegrowth, expRegrowth = btp_check_buff("Regrowth", nextPlayer);

           --
           -- Renew check
           --
           hasRenew, myRenew,
           numRenew, expRenew = btp_check_buff("Renew", nextPlayer);

           if (hasRejuvenation or hasRegrowth or hasRenew) then
               skipPlayer = true;
           end
        end

        index = UnitInRaid(nextPlayer);
        if (index == nil) then index = 1; end
        name, rank, subgroup, level, class, fileName, zone, online,
        isDead, role, isML, combatRole = GetRaidRosterInfo(index);

        if (not skipPlayer and cur_percent <= thresh and
            cur_health >= 5 and btp_in_range(spell, nextPlayer)) then

            -- Tanking
            if (cur_threat ~= nil and cur_threat > 1) then
                if (cur_heal_percent > cur_percent) then
                    cur_heal         = nextPlayer;
                    cur_priority     = 100;
                    cur_heal_percent = cur_percent;
                    cur_subgroup     = subgroup;
                end
            end

            -- second in line are potential healers
            if (cur_class == "Priest" or 
                cur_class == "Druid" or
                cur_class == "Paladin" or
                cur_class == "Shaman") then

                if (cur_priority <= 75 and
                    cur_heal_percent > cur_percent) then
                    cur_heal         = nextPlayer;
                    cur_priority     = 75;
                    cur_heal_percent = cur_percent;
                    cur_subgroup     = subgroup;
                end
            end
            
            -- dps classes all get the same
            if (cur_priority <= 50 and
                cur_heal_percent > cur_percent) then
                cur_heal         = nextPlayer;
                cur_priority     = 50;
                cur_heal_percent = cur_percent;
                cur_subgroup     = subgroup;
            end
        end
    end

    -- check raid pets lowest priority
    for nextPet in btp_iterate_group_pets() do
        if (UnitExists(nextPet) and btp_in_range(spell, nextPet)) then
            pet_health     = UnitHealth(nextPet);
            pet_health_max = UnitHealthMax(nextPet);
            pet_threat     = UnitThreatSituation(nextPet);
            pet_percent    = pet_health / pet_health_max;

            if (raidHeal and pet_threat ~= nil and pet_threat < 2) then
               skipPlayer = false;

               --
               -- Rejuvination check
               --
               hasRejuvenation, myRejuvenation,
               numRejuvenation, expRejuvination = btp_check_buff("Rejuvenation", nextPet);

               --
               -- Regrowth check
               --
               hasRegrowth, myRegrowth,
               numRegrowth, expRegrowth = btp_check_buff("Regrowth", nextPet);

               --
               -- Renew check
               --
               hasRenew, myRenew,
               numRenew, expRenew = btp_check_buff("Renew", nextPet);

               if (hasRejuvenation or hasRegrowth or hasRenew) then
                   skipPlayer = true;
               end
            end

            if (not skipPlayer and pet_percent <= thresh and
                pet_health > 5 and btp_in_range(spell, nextPet)) then
                if (cur_priority <= 20 and pet_threat ~= nil and
                    pet_threat > 1 and cur_heal_percent > pet_percent) then
                    cur_heal         = nextPet;
                    cur_priority     = 20;
                    cur_heal_percent = pet_percent;
                    cur_subgroup     = subgroup;
                end

                if (cur_priority <= 10 and
                    cur_heal_percent > pet_percent) then
                    cur_heal         = nextPet;
                    cur_priority     = 10;
                    cur_heal_percent = pet_percent;
                    cur_subgroup     = subgroup;
                end
            end
        end
    end

    if (cur_heal ~= nil) then
        return cur_heal, party_cnt, raid_cnt, party_status[cur_subgroup];
    end

    return false;
end


function btp_is_drinking(unitid)
    --
    -- Drinking Buff Check
    --
    hasDrinking, myDrinking,
    numDrinking = btp_check_buff("Drink", unitid);

    return hasDrinking;
end

-- would be nice
function btp_foreach(list, callback)
    return false;
end


function btp_icon_is_mount_ground(icon)
    if (icon and (
        strfind(icon, "Belt_12") or
        strfind(icon, "camel") or
        strfind(icon, "Centaur") or
        strfind(icon, "Charger") or
        strfind(icon, "Cockatrice") or
        strfind(icon, "DireWolf") or
        strfind(icon, "Dreadsteed") or
        strfind(icon, "horse") or
        strfind(icon, "Halloween_Witch") or
        strfind(icon, "Kodo") or
        strfind(icon, "Mammoth") or
        strfind(icon, "Misc_Key_03") or
        strfind(icon, "Misc_Key_04") or
        strfind(icon, "Misc_Key_14") or
        strfind(icon, "Misc_Foot_Centaur") or
        strfind(icon, "MountainRam") or
        strfind(icon, "PolarBear") or
        strfind(icon, "Raptor") or
        strfind(icon, "raptor") or
        strfind(icon, "runningwild") or
        strfind(icon, "Mount_Raven") or
        strfind(icon, "Swiftness") or
        strfind(icon, "Tiger") or
        strfind(icon, "turtle") or
        strfind(icon, "Warstrider") or
        strfind(icon, "RidingElekk") or
        strfind(icon, "_Mount_BlackDireWolf") or
        strfind(icon, "Mount_MechaStrider") or
        strfind(icon, "_Mount_") or
        strfind(icon, "wolf")
        )) then
	    return true;
    end
    return false;
end

function btp_icon_is_mount_flying(icon)
    if (icon and (
        strfind(icon, "Copter") or
        strfind(icon, "DeathCharger") or
        strfind(icon, "Drake") or
        strfind(icon, "dragon") or
        strfind(icon, "celestial") or
        strfind(icon, "Celestial") or
        strfind(icon, "FlightForm") or
        strfind(icon, "frostwrym") or
        strfind(icon, "flyingcarpet") or
        strfind(icon, "Hippogryph") or
        strfind(icon, "Gyrocoptor") or
        strfind(icon, "NetherRay") or
        strfind(icon, "rocketmount") or
        strfind(icon, "windrider") or
        strfind(icon, "Wyvern")
        )) then
         return true;
    end
    return false;
end

function btp_icon_is_mount(icon)
    if (btp_icon_is_mount_ground(icon)) then return true; end
    if (btp_icon_is_mount_flying(icon)) then return true; end
    return false;
end

function btp_is_mounted_ground(unitid)
    local i = 1;
    local buffName = "foo";

    while (buffName) do
        buffName, buffIcon, buffCount, dispelType, duration,
        expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer,
        nameplateShowAll, timeMod = UnitBuff(unitid, i);
        if (btp_icon_is_mount_ground(buffName)) then
            return true;
        end
        i = i + 1;
    end
    return false
end

function btp_is_mounted_flying(unitid)
    local i = 1;
    local buffName = "foo";

    while (buffName) do
        buffName, buffIcon, buffCount, dispelType, duration,
        expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer,
        nameplateShowAll, timeMod = UnitBuff(unitid, i);
        if (btp_icon_is_mount_flying(buffName)) then
            return true;
        end
        i = i + 1;
    end
    return false;
end

function btp_is_mounted(unitid)
    if (btp_is_mounted_ground(unitid)) then return true; end
    if (btp_is_mounted_flying(unitid)) then return true; end
end

function btp_is_summoning_mount(unitid)
    local spell, rank, displayName, icon, startTime, endTime, 
    isTradeSkill, castID, interrupt = UnitCastingInfo(unitid);
    if (spell ~= nil) then
        return btp_icon_is_mount(icon);
    end
    return false
end

function btp_is_casting(unitid)
    name, text, texture, startTimeMS, endTimeMS,
    isTradeSkill, castID, notInterruptible, spellId = UnitCastingInfo(unitid)
    if (name) then
        return true;
    end
    return false;
end

function btp_is_channeling(unitid)
    name, text, texture, startTimeMS, endTimeMS,
    isTradeSkill, notInterruptible, spellId = UnitChannelInfo(unitid);
    if (name) then
        return true;
    end
    return false;
end

-- This function sets most of the global variables
-- that are used for state information
-- unsure the std btp_bot needs this, it might even break
-- things.
function btp_bot_init()
    -- initilize the spellbook
    if (#BTP_SPELLBOOK == 0) then
        BTP_SPELLBOOK = btp_build_valid_spellbook(BOOKTYPE_SPELL);
    end
    if (#BTP_SPELLBOOK_PET == 0) then
        BTP_SPELLBOOK_PET = btp_build_valid_spellbook(BOOKTYPE_PET);
    end

    --refresh the spell books once in a while not in combat
    if (((math.floor(GetTime()) % 10) ~= 0) and not UnitAffectingCombat("player")) then
        BTP_SPELLBOOK = btp_build_valid_spellbook(BOOKTYPE_SPELL);
        BTP_SPELLBOOK_PET = btp_build_valid_spellbook(BOOKTYPE_PET);
    end

    _btp_follow_player = "";
    _btp_assist_player = "";
end


function btp_report_afk()
    if (GetNumBattlefieldScores() > 0 and
       (GetTime() - lastCheckAFK) > 30) then
        lastCheckAFK = GetTime();

        for index = 1, GetNumBattlefieldScores() do
            name, killingBlows, honorKills, deaths, honorGained,
            faction, rank, race, class, damageDone, healingDone,
            filename = GetBattlefieldScore(index);

            if (name ~= nil and string.find(name, "-")) then
                x, y = string.find(name, "-");
                name = string.sub(name, 0, x - 1);
            end

            if (name ~= nil and bgStats[name] == nil) then
                bgStats[name] = { };
            end

            if (name ~= nil and bgStats[name]["dd"] == nil) then
                bgStats[name]["dd"] = 0;
            end

            if (name ~= nil and bgStats[name]["hd"] == nil) then
                bgStats[name]["hd"] = 0;
            end

            if (name ~= nil and bgStats[name]["time"] == nil) then
                bgStats[name]["time"] = GetTime();
            end

            if (name ~= nil and bgStats[name]["reported"] == nil) then
                bgStats[name]["reported"] = false;
            end

	    -- always track current users stats
            if (name ~= nil and (bgStats[name]["dd"] ~= damageDone or
                bgStats[name]["hd"] ~= healingDone)) then
                --
                -- Keep track of player stats
                --
                bgStats[name]["dd"]   = damageDone;
                bgStats[name]["hd"]   = healingDone;
                bgStats[name]["time"] = GetTime();
            end


        end

        --
        -- Report the player AFK if they do not do any damage or healing
        -- for 5 minutes or more.
        --
        for i = GetNumRaidMembers() - 1, 1, -1 do
            nextPlayer = "raid" .. i;
            if (bgStats[UnitName(nextPlayer)] ~= nil and
               (GetTime() - bgStats[UnitName(nextPlayer)]["time"]) > 300 and
                not bgStats[UnitName(nextPlayer)]["reported"]) then
                -- Let's report the user AFK
                -- I hope Blizzard likes what we're doing here.
                -- This should help fix the AFK bot problem in BGs.
                bgStats[UnitName(nextPlayer)]["reported"] = true;
                ReportPlayerIsPVPAFK(nextPlayer);
            end
        end

        if (GetNumRaidMembers() <= 0) then
            for i = GetNumPartyMembers() - 1, 1, -1 do
                nextPlayer = "party" .. i;
                if (bgStats[UnitName(nextPlayer)] ~= nil and
                   (GetTime() -bgStats[UnitName(nextPlayer)]["time"]) > 300 and
                    not bgStats[UnitName(nextPlayer)]["reported"]) then
                    -- Let's AFK the user
                    -- I hope Blizzard likes what we're doing here.
                    -- This should help fix the AFK bot problem in BGs.
                    bgStats[UnitName(nextPlayer)]["reported"] = true;
                    ReportPlayerIsPVPAFK(nextPlayer);
                end
            end
        end
    end
end

-- returns the number of enemies in combat and in range of an ability
function btp_enemies_in_range_of(spell)
    local inRange, unitID = 0;
    for _, plate in pairs(C_NamePlate.GetNamePlates()) do
        unitID = plate.namePlateUnitToken;
        if (UnitCanAttack("player", unitID) and
            btp_in_range(spell, unitID)) then
            inRange = inRange + 1;
        end
    end

    -- btp_frame_debug(spell .. ": " .. inRange);
    return inRange;
end

function btp_bot()
    hasHearthStone = false;
    hearthBag = 0;
    hearthSlot = 1;
    hasWater = false;
    waterBag = 0;
    waterSlot = 1;
    hasMount = false;
    hasFastMount = false;
    hasFastFlyingMount = false;
    hasFlyingMount = false;
    flyingMountSlot = 1;
    flyingMountSlotFast = 1;
    nextPlayer = "player";
    followPlayer = nextPlayer;
    bestDamage = 0;
    partyOK = false;
    playerOnMount = false;
    targetOnMount = false;
    playerOnFlyingMount = false;
    targetOnFlyingMount = false;
    isDrinking = false;
    shadowTrance = false;
    canCurse = true;
    canInst = true;
    warlockInstCount = 0;
    startName = "no one";
    noFollow = false;
    queueNow = false;
    atFlag = false;
    unitid = "no one";

    hasBandageBuff, myBandageBuff,
    numBandageBuff, expBandageBuff = btp_check_buff("Bandage", bandageTarget);
      
    if (((GetTime() - lastBandage) <= 1) or myBandageBuff) then
        return true;
    end

    if (current_cb ~= nil and current_cb()) then
        return true;
    end

    ProphetKeyBindings();

    hasPreperation, myPreperation,
    numPreperation = btp_check_buff("WispSplode", "player");
      
    hasFreeCast, myFreeCast,
    numFreeCast = btp_check_buff("Holy_Resurrection", "player");

    hasDefendFlags, myDefendFlags,
    numDefendFlags = btp_check_buff("defendflags", "player");

    if (doTrade and tradeName) then
        PickupContainerItem(freeBag, freeSlot);

        if (CursorHasItem()) then
           DropItemOnUnit(tradeName);
           doTrade = false;
           tradeName = nil;
        end
    end

    if ((GetTime() - lastBotWater) <= 2) then
        isDrinking = true;
    end

    if (newChatter and chatterCount > 8 and
        chatterPlayer == lastChatterPlayer) then
        newChatter = false;
        chatterCount = chatterCount + 1;
        -- Ignore the jerk.  But we should never get here.  Unless
        -- it is a GM or something.  Then we are in trouble.
    elseif (newChatter and chatterCount == 8 and
            chatterPlayer == lastChatterPlayer) then
        newChatter = false;
        chatterCount = chatterCount + 1;
        SendChatMessage("Welcome to my ignore list!",
                        "WHISPER", nil, chatterPlayer);
        AddIgnore(chatterPlayer);
    elseif (newChatter and chatterCount > 4 and
            chatterPlayer == lastChatterPlayer) then
        newChatter = false;
        chatterCount = chatterCount + 1;
        -- Ignore the jerk.
    elseif (newChatter and chatterCount == 4 and
            chatterPlayer == lastChatterPlayer) then
        i = math.random(MAX_ANOY_MESSAGE);
        newChatter = false;
        chatterCount = chatterCount + 1;
        SendChatMessage(anoyMessage[i], "WHISPER", nil, chatterPlayer);
    elseif (newChatter and (GetTime() - lastChatter) >= 5) then
        lastChatter = GetTime();
        newChatter = false;

        if (chatterPlayer == lastChatterPlayer) then
            chatterCount = chatterCount + 1;
        else
            lastChatterPlayer = chatterPlayer;
            chatterCount = 0;
        end
        
        SendChatMessage(Chatter(chatterMessage), "WHISPER", nil, chatterPlayer);
    end

    if (not LoggingChat()) then
      btp_frame_debug("Chat is not being logged - starting it!");
      LoggingChat(1);
    end

    if (botOff) then
--         btp_frame_create_pos("Casting Bar", "0", "-425", 400, 100);
--         btp_frame_set_color_hex("Casting Bar", "FF0000");
        botOff = false;
    end

    local bag = 4
    while (bag >= 0) do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot)) then

            if (string.find(C_Container.GetContainerItemLink(bag,slot), "Hearthstone")) then
                hasHearthStone = true;
                hearthBag = bag;
                hearthSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot), "Milk")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Mana Biscuit")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Mana Lollipop")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Mana Cookie")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Mana Brownie")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Mana Cake")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Mana Strudel")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Mana Pie")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot), "Tea")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot), "Nectar")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot), "Juice")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot), "Dew")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot), "Ethermead")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Manna Biscuit")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot),
                "Star's Tears")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end

            if (string.find(C_Container.GetContainerItemLink(bag,slot), "Water")) then
                hasWater = true;
                waterBag = bag;
                waterSlot = slot;
            end
        end
      end

      bag = bag - 1;
    end

    mounts = GetNumCompanions("MOUNT");
    if (mounts == nil) then mounts = 0; end
    for i=1, mounts do
        creatureID, creatureName, creatureSpellID, 
        icon, issummoned = GetCompanionInfo("MOUNT", i);
        if(creatureID ~= nil) then
            -- btp_frame_debug("slot: " .. i .. " id: " ..
            --                 creatureID .. " name: " ..
            --                 creatureName .. " csid: " ..
            --                 creatureSpellID); 
            -- btp_frame_debug("icon: " .. icon);
            -- issummoned is set if you are currently on the
            -- mount nil otherwise issummoned: " .. issummoned);
    
            -- add eles statement to allow other types of mounts
            if(not hasFastFlyingMount and
               string.find(creatureName, "Swift") and
               string.find(creatureName, "Wind Rider")) then
                hasFastFlyingMount = true;
                flyingMountSlotFast = i;
            elseif (not hasFlyingMount and
                    string.find(creatureName, "Wind Rider")) then
                    hasFlyingMount = true;
                    flyingMountSlot = i;
            elseif (not hasFastMount and
                    string.find(creatureName, "Dreadsteed")) then
                hasFastMount = true;
                mountSlotFast = i;
            else
                hasMount = true;
                mountSlot = i;
            end
        end
    end

    --
    -- Just Load these because we need the data in memory.
    --
    -- SetMapToCurrentZone();

    --
    -- Trying to move some of the bot code around BGs out of this HUGE function.
    --
    btp_do_dungeon_stuff();

    --
    -- Trying to move some of the bot code around BGs out of this HUGE function.
    --
    btp_do_bg_stuff();

    --
    -- Free action here will do nothing unless we have a debuff, and
    -- would go off a maximum of two turns.  This should help use
    -- the insignia and will of the forsaken more often when needed.
    --
    if (btp_free_action()) then
        return true;
    end

    if (GetNumGroupMembers() > 0 or pvpBot) then
        -- if (GetNumBattlefieldScores() <= 0) then
        --     for i=1, MAX_BATTLEFIELD_QUEUES do
        --              status, mapName, instanceID = GetBattlefieldStatus(i);
        --             if (status == "confirm") then
        --                     AcceptBattlefieldPort(i,1);
        --                     StaticPopup_Hide("CONFIRM_BATTLEFIELD_ENTRY");
        --             end
        --     end
        -- end

        for nextPlayer in btp_iterate_group_members() do
            -- btp_frame_debug("Next Player: " .. nextPlayer);
            if (manualFollow and
                manualFollowName == UnitName(nextPlayer)) then

                if (btp_check_dist(nextPlayer, 4)) then
                    followPlayer = nextPlayer;
                end

                partyOK = true;
                break;
            elseif (btp_is_guild_member(UnitName(nextPlayer)) and
                    UnitName("player") ~= UnitName(nextPlayer)) then
                -- btp_frame_debug("Follow Player: " .. followPlayer);

                if (not btp_dont_follow(name) and
                    btp_check_dist(nextPlayer, 4)) then
                    followPlayer = nextPlayer;
                end

                partyOK = true;
            end
        end

        -- if (GetNumRaidMembers() <= 0) then
        --     for i = 1, GetNumPartyMembers() do
        --         nextPlayer = "party" .. i;

        --         if (manualFollow and
        --             manualFollowName == UnitName(nextPlayer)) then

        --             if (btp_check_dist(nextPlayer, 4)) then
        --                 followPlayer = nextPlayer;
        --             end

        --             partyOK = true;
        --             break;
        --         elseif (btp_is_guild_member(UnitName(nextPlayer)) and
        --                 UnitName("player") ~= UnitName(nextPlayer)) then

        --            if (not btp_dont_follow(name) and
        --                btp_check_dist(nextPlayer, 4)) then
        --                followPlayer = nextPlayer;
        --            end

        --            partyOK = true;
        --         end
        --     end
        -- end

        --
        -- Choose the next person to follow if there is no guild member
        -- around.  A bunch of stuff happens here, but notice the priority
        -- on those people that have done more damage.
        --
        -- if (pvpBot and followPlayer == "player") then
        --     partyOK = true;
        --     bestDamage = 0;

        --     for i = GetNumRaidMembers() - 1, 1, -1 do
        --         nextPlayer = "raid" .. i;

        --         if (btp_check_dist(nextPlayer, 4) and
        --             not btp_dont_follow(UnitName(nextPlayer)) and
        --            ((bgStats[UnitName(nextPlayer)] ~= nil and
        --             bgStats[UnitName(nextPlayer)]["dd"] >= bestDamage) or
        --            (farmDungeon and
        --            (UnitGroupRolesAssigned(nextPlayer) == "DAMAGER" or
        --             UnitGroupRolesAssigned(nextPlayer) == "HEALER" or
        --             UnitGroupRolesAssigned(nextPlayer) == "TANK"))) and
        --            ((UnitHealth("player") < 2 and UnitHealth(nextPlayer) < 2) or
        --            (UnitHealth("player") >= 2 and
        --            UnitHealth(nextPlayer) >= 2))) then

        --             if (bgStats[UnitName(nextPlayer)] ~= nil) then
        --                 bestDamage = bgStats[UnitName(nextPlayer)]["dd"];
        --             end

        --             followPlayer = nextPlayer;

        --             if (farmDungeon and
        --                 UnitGroupRolesAssigned(nextPlayer) == "TANK") then
        --                 break;
        --             end
        --         end
        --     end

        --     if (GetNumRaidMembers() <= 0) then
        --         for i = GetNumPartyMembers() - 1, 1, -1 do
        --             nextPlayer = "party" .. i;

        --             if (btp+btp_check_dist(nextPlayer, 4) and
        --                 not btp_dont_follow(UnitName(nextPlayer)) and
        --                ((bgStats[UnitName(nextPlayer)] ~= nil and
        --                 bgStats[UnitName(nextPlayer)]["dd"] >= bestDamage) or
        --                 (farmDungeon and
        --                 (UnitGroupRolesAssigned(nextPlayer) == "DAMAGER" or
        --                  UnitGroupRolesAssigned(nextPlayer) == "HEALER" or
        --                  UnitGroupRolesAssigned(nextPlayer) == "TANK"))) and
        --                ((UnitHealth("player") < 2 and
        --                  UnitHealth(nextPlayer) < 2) or
        --                (UnitHealth("player") >= 2 and
        --                 UnitHealth(nextPlayer) >= 2))) then

        --                 if (bgStats[UnitName(nextPlayer)] ~= nil) then
        --                     bestDamage = bgStats[UnitName(nextPlayer)]["dd"];
        --                 end

        --                 followPlayer = nextPlayer;

        --                 if (farmDungeon and
        --                     UnitGroupRolesAssigned(nextPlayer) == "TANK") then
        --                     break;
        --                 end
        --             end
        --         end
        --     end

        --     --
        --     -- This looks fucked up, but it is here to allow the bot
        --     -- to mount up when there is no one around.  That way when
        --     -- a player rides by it can quickly tag on and follow while
        --     -- mounted.
        --     --
        --     if (UnitName(followPlayer) ~= UnitName("player")) then
        --         targetOnMount = false;
        --     else
        --         targetOnMount = true;
        --     end
        -- end

        if (partyOK) then
            lastInParty = GetTime();

            -- i = 1;

            if (btp_is_mounted_ground("player")) then
                playerOnMount = true;
            end

            if (btp_is_mounted_flying("player")) then
                playerOnFlyingMount = true;
            end

            if (btp_is_drinking("player")) then
                isDrinking = true;
            end

            if (btp_is_summoning_mount(followPlayer)) then 
                targetOnMount = true; 
            end

            if (btp_is_mounted_ground(followPlayer)) then
               targetOnMount = true;
            end

            if (btp_is_mounted_flying(followPlayer)) then
                targetOnFlyingMount = true;
            end

            if (followPlayer == "player") then
                noFollow = true;
            elseif (pvpBot and hasDefendFlags and not targetOnMount and
                    not targetOnFlyingMount and not playerOnMount and
                    not playerOnFlyingMount and not isDrinking and
                    not UnitAffectingCombat(followPlayer) and
                    btp_check_dist(followPlayer, 2)) then
                atFlag = true;

                if ((GetTime() - lastDefendFlags) > 5) then
                    lastDefendFlags = GetTime();
                    FuckBlizzardMove("TURNLEFT");
                end
            end

            if (pvpBot and not UnitAffectingCombat(followPlayer) and
                not UnitAffectingCombat("player") and btpFollow and
                not btp_check_dist(followPlayer, 2) and
                btp_check_dist(followPlayer, 4) and not isDrinking and
                not btp_is_summoning_mount("player") and
                not (targetOnMount and not playerOnMount) and
               (GetTime() - lastJumpFollow) > 2) then
                    lastJumpFollow = GetTime();
                    FuckBlizzardMove("JUMP");
            end

            if (not btp_dont_follow(UnitName(followPlayer)) and
                btpFollow and not stopMoving and not atFlag and
                (GetTime() - lastMountTry) > 2 and
                not forceDrink and (not isDrinking or
                UnitPower("player") == UnitPowerMax("player") or
               (farmDungeon and btp_check_dist(followPlayer, 4) and
                not btp_check_dist(followPlayer, 2)))) then

                FollowUnit(followPlayer);

                if (btp_check_dist(followPlayer, 4) and
                    followPlayer ~= "player") then
                    bootyCall = false;
                    lastFollowTime = GetTime();
                end
            end

            if (hasWater and okayDrink) then
                okayDrink = false;
                FuckBlizUseContainerItem(waterBag,waterSlot);
            end

            if (okayMount and targetOnMount) then
                if (hasFastMount) then
                    CallCompanion("MOUNT", mountSlotFast);
                elseif (hasMount) then
                    CallCompanion("MOUNT", mountSlot);
                end

                okayMount = false;
            elseif (okayMount) then
                if (hasFastFlyingMount) then
                    CallCompanion("MOUNT", flyingMountSlotFast);
                elseif (hasFlyingMount) then
                    CallCompanion("MOUNT", flyingMountSlot);
                end

                okayMount = false;
            end

            if ((GetTime() - lastSummon) >= 60) then
                lastSummon = GetTime();
                C_SummonInfo.ConfirmSummon();
            elseif (UnitIsGroupLeader("player") and UnitName(followPlayer) and
                    not btp_dont_follow(UnitName(followPlayer))) then
                PromoteToLeader(followPlayer);
            elseif (hasWater and (GetTime() - lastBotWater) >= 5 and
                    UnitPower("player")/UnitPowerMax("player") <= .3 and
                    UnitPower("player") > 0 and UnitHealth("player") > 2 and
                    not isDrinking and not targetOnMount and
                    not UnitAffectingCombat("player")) then
                if (farmDungeon and btp_check_dist(followPlayer, 4) and
                    not btp_check_dist(followPlayer, 2)) then
                    -- We are lagging, do not drink
                else
                    lastBotWater = GetTime();
                    okayDrink = true;
                    FuckBlizzardMove("TURNLEFT");
                end
            elseif (hasWater and forceDrink and
                   (GetTime() - lastBotWater) >= 3) then
                forceDrink = false;
                okayDrink = true;
                lastBotWater = GetTime();
                FuckBlizzardMove("TURNLEFT");
            elseif ((targetOnMount or targetOnFlyingMount or bootyCall) and
                     not (playerOnMount or playerOnFlyingMount) and
                   (GetTime() - lastMountCheck) >= 5 and not isDrinking) then
                --
                -- Mount Up
                --
                lastMountCheck = GetTime();

                if (targetOnMount) then
                    if (btp_druid_istree()) then
                        FuckBlizzardByNameAlt("Tree of Life");
                    end

                    if (hasFastMount) then
                        FuckBlizzardMove("TURNLEFT");
                        lastMountTry = GetTime();
                        okayMount = true;
                    elseif (hasMount) then
                        FuckBlizzardMove("TURNLEFT");
                        lastMountTry = GetTime();
                        okayMount = true;
                    elseif (btp_cast_spell("Running Wild")) then
                        FuckBlizzardMove("TURNLEFT");
                        lastMountTry = GetTime();
                        return true;
                    end
                else
                    if (btp_druid_istree()) then
                        FuckBlizzardByNameAlt("Tree of Life");
                    end

                    if (btp_cast_spell("Swift Flight Form")) then
                        return true;
                    elseif (btp_cast_spell("Flight Form")) then
                        return true;
                    elseif (hasFastFlyingMount) then
                        FuckBlizzardMove("TURNLEFT");
                        lastMountTry = GetTime();
                        okayMount = true;
                    elseif (hasFlyingMount) then
                        FuckBlizzardMove("TURNLEFT");
                        lastMountTry = GetTime();
                        okayMount = true;
                    end
                end
            elseif (not (targetOnMount or targetOnFlyingMount) and
                   (playerOnMount or playerOnFlyingMount) and
                   (GetTime() - lastMountCheck) >= 2) then
                --
                -- Dismount
                --
                lastMountCheck = GetTime();
                Dismount();

                if (btp_druid_isbird()) then
                    if (btp_cast_spell("Swift Flight Form")) then
                        return true;
                    elseif (btp_cast_spell("Flight Form")) then
                        return true;
                    end
                end
            elseif (bootyCall) then
                SendWho('n-"' .. bootyName .. '"');                     
                charname, guildname, level, race, class, zone,
                unknown = GetWhoInfo(1);                      

                for nextPlayer in btp_iterate_group_members() do
                    if (bootyName == UnitName(nextPlayer)) then
                        unitid = nextPlayer;
                        break;
                    end
                end

                if (unitid == "no one") then
                    bootyCall = false;
                    return false;
                end

                if (zone ~= GetZoneText()) then
                    SetMapZoom(GetCurrentMapContinent());
                end

                x, y = GetPlayerMapPosition(unitid);
                x, y = x * 100, y * 100;

                if (x > 0 and y > 0 and zone) then
                    btp_move_to_location(zone, x, y);
                end
            elseif (not dontPop and 
                    UnitHealth("player") < 2 and HasSoulstone()) then
                UseSoulstone();
            elseif ((GetTime() - lastDice) >= 17) then
                lastDice = GetTime();
                for Rollid=0, 256 do
                    if (lootMode == "greed") then
                        RollOnLoot(Rollid, 2);
                        ConfirmLootRoll(Rollid, 2);
                    elseif (lootMode == "need") then
                        RollOnLoot(Rollid, 1);
                        ConfirmLootRoll(Rollid, 1);
                    elseif (lootMode == "wait") then
                        -- DO NOTHING
                    else
                        -- Default action is to pass
                        RollOnLoot(Rollid, 0);
                        ConfirmLootRoll(Rollid, 0);
                    end
                end
            elseif ((GetTime() - lastQuestTrade) >= 7) then
                lastQuestTrade = GetTime();
                AcceptTrade();
                AcceptQuest();
            elseif (not dontRelease and
                    IsActiveBattlefieldArena() == nil and
                   (GetTime() - lastRelease) >= 23 and
                    UnitHealth("player") < 2) then
                lastRelease = GetTime();
                RepopMe();
            elseif (not dontPop and UnitHealth("player") < 2 and 
                   (GetTime() - envRes) >= 11) then
                envRes = GetTime();
                AcceptResurrect();
                RetrieveCorpse();
            elseif ((hasFreeCast or hasPreperation or
                   ((GetTime() - lastBuff) >= 5)) and
                    not (playerOnMount or playerOnFlyingMount or isDrinking) and
                    UnitHealth("player") > 2 and
                    UnitClass("player") == "Shaman" and btp_sham_buff()) then
                lastBuff = GetTime();
            elseif ((hasFreeCast or hasPreperation or
                   ((GetTime() - lastBuff) >= 5)) and not
                   (playerOnMount or playerOnFlyingMount or isDrinking) and
                    not UnitAffectingCombat("player") and
                    UnitClass("player") ~= "Shaman" and
                    UnitHealth("player") > 2) then
                lastBuff = GetTime();
                if (UnitClass("player") == "Priest" and pvpBot and
                    UnitPower("player")/UnitPowerMax("player") >= .9) then
                    PriestBuff();
                elseif (UnitClass("player") == "Priest" and
                    UnitPower("player")/UnitPowerMax("player") >= .3 and
                    not pvpBot) then
                    PriestBuff();
                elseif (UnitClass("player") == "Druid" and
                        UnitPower("player")/UnitPowerMax("player") >= .3) then
                    druid_buff();
                elseif (UnitClass("player") == "Warlock" and
                        UnitPower("player")/UnitPowerMax("player") >= .3) then
                    WarlockBuff();
                end
            else
                if (UnitClass("player") == "Priest" and
                    not (playerOnMount or playerOnFlyingMount or
                         isDrinking)) then
                    	btp_priest_heal();
                      if (DPS_MODE_ON == true and
                          UnitAffectingCombat(followPlayer) and
                          UnitPower("player")/UnitPowerMax("player") > .35 and
                          UnitAffectingCombat("player")) then
                          DPS_ASSIST_TARGET = followPlayer .. "target";
                             btp_priest_dps(DPS_ASSIST_TARGET);
                      end
                elseif (UnitClass("player") == "Druid" and
                        not (playerOnMount or playerOnFlyingMount or
                             isDrinking)) then
                    druid_heal();
                elseif(UnitClass("player") == "Shaman" and
                        not (playerOnMount or playerOnFlyingMount or
                             isDrinking)) then
                    btp_sham_heal();
                elseif(UnitClass("player") == "Paladin" and
                        not (playerOnMount or playerOnFlyingMount or
                             isDrinking)) then
                    btp_pal_heal();
		elseif (UnitClass("player") == "Mage" and
			not (playerOnMount or playerOnFlyingMount or
			isDrinking)) then
            if(btp_mage_buff()) then return true; end

			if(DPS_MODE_ON == true and UnitAffectingCombat(followPlayer)) then
				btp_mage_dps(DPS_ASSIST_TARGET);
			end

                elseif (UnitClass("player") == "Warlock" and
                        not (playerOnMount or playerOnFlyingMount or
                             isDrinking)) then
                    if (pvpBot) then
                        if (targetCount > 5) then
                            FuckBlizzardTargetUnit("targetenemy");
                            targetCount = 0;
                        else
                            targetCount = targetCount + 1;
                        end

                        if (UnitFactionGroup("player") ==
                            UnitFactionGroup("target")) then
                            targetCount = 6;
                            return false;
                        end

                        if (WarlockPrimary()) then
                            return true;
                        elseif (WarlockInst()) then
                            return true;
                        elseif (WarlockDest()) then
                            return true;
                        else
                            return false;
                        end
                    elseif (UnitAffectingCombat(followPlayer) and
                            not noFollow) then
                        FuckBlizzardTargetUnit(followPlayer .. "target");

                        if (WarlockPrimary()) then
                            return true;
                        elseif (WarlockInst()) then
                            return true;
                        elseif (WarlockDest()) then
                            return true;
                        else
                            return false;
                        end
                    end
                end
            end
        else
            LeaveParty();
            AcceptGroup();
        end
    else
        if (not dontHearth and (GetTime() - lastHearth) >= 3600 and
            (GetTime() - lastInParty) >= 120) then
            lastHearth = GetTime();
            FuckBlizUseContainerItem(hearthBag,hearthSlot);
        else
            AcceptGroup();
        end

        if (not dontBeg and btp_cast_spell("Basic Campfire")) then
            HoboBeg();
            return true;
        elseif (not dontBeg) then
            if (UnitClass("player") == "Druid") then
                druid_buff();
            elseif (UnitClass("player") == "Priest") then
                PriestBuff();
            elseif (UnitClass("player") == "Mage") then
                if (not mageisDrinking) then
                    btp_mage_waterbreak();
                end
            end

            if ((GetTime() - lastQuestTrade) >= 7) then
                lastQuestTrade = GetTime();
                AcceptTrade();
            end
        end

        hasWater = false;
        local bag = 4
        while (bag >= 0) do
          for slot=1,C_Container.GetContainerNumSlots(bag) do
            if (C_Container.GetContainerItemLink(bag,slot)) then
                --
                -- XXX: Add new alcohol
                --
                if (string.find(C_Container.GetContainerItemLink(bag,slot),
                                "Bottle of Pinot Noir")) then
                    hasWater = true;
                    waterBag = bag;
                    waterSlot = slot;
                end

                if (string.find(C_Container.GetContainerItemLink(bag,slot),
                                "Flask of Port")) then
                    hasWater = true;
                    waterBag = bag;
                    waterSlot = slot;
                end

                if (string.find(C_Container.GetContainerItemLink(bag,slot),
                                "Skin of Dwarven Stout")) then
                    hasWater = true;
                    waterBag = bag;
                    waterSlot = slot;
                end

                if (string.find(C_Container.GetContainerItemLink(bag,slot),
                                "Flagon of Mead")) then
                    hasWater = true;
                    waterBag = bag;
                    waterSlot = slot;
                end

                if (string.find(C_Container.GetContainerItemLink(bag,slot),
                                "Jug of Bourbon")) then
                    hasWater = true;
                    waterBag = bag;
                    waterSlot = slot;
                end

                if (string.find(C_Container.GetContainerItemLink(bag,slot),
                                "Darkmoon Special Reserve")) then
                    hasWater = true;
                    waterBag = bag;
                    waterSlot = slot;
                end

                if (string.find(C_Container.GetContainerItemLink(bag,slot),
                                "Cenarion Spirits")) then
                    hasWater = true;
                    waterBag = bag;
                    waterSlot = slot;
                end
            end
          end

          bag = bag - 1;
        end

        if (hasWater and (GetTime() - lastBooze) >= 30) then
            lastBooze = GetTime();
            i = math.random(MAX_EMOTE_INDEX);

            DoEmote(emote[i], "");
            FuckBlizUseContainerItem(waterBag, waterSlot);
        end
    end
end


function btp_free_action()
    duration = 0;
    start = 0;
    hasLivingAction = false;
    hasInsignia = false;
    insigniaSlot = 13;

    if (UnitHealth("player") < 2) then
        return false;
    end

    for slot=13,14 do
      if (GetInventoryItemLink("player", slot) and
         (string.find(GetInventoryItemLink("player", slot),
                      "of the Horde") or
          string.find(GetInventoryItemLink("player", slot),
                      "of the Alliance"))) then
        start, duration, enable = GetInventoryItemCooldown("player", trinkSlot);
        if (duration - (GetTime() - start) <= 0) then
            hasInsignia = true;
            insigniaSlot = slot;
        end
      end
    end

    for bag=0,4 do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot) and
            string.find(C_Container.GetContainerItemLink(bag,slot),
                        "Living Action Potion")) then
            start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
            if (duration - (GetTime() - start) <= 0) then
                hasLivingAction = true;
            end
        end
      end
    end

    if (btp_is_feared("player") and
       (GetTime() - lastBreakCC) > 1 and
        (btp_cast_spell("Will of the Forsaken") or btp_cast_spell("Fade"))) then
        lastBreakCC = GetTime();
        return true;
    elseif (btp_is_impaired("player") and hasInsignia and
           (GetTime() - lastBreakCC) > 1) then
        lastBreakCC = GetTime();
	if (btp_cast_spell("Fade")) then return true; end
        FuckBlizUseInventoryItem(insigniaSlot);
        return true;
    elseif (btp_is_charmed("player") and
           (GetTime() - lastBreakCC) > 1 and
           (btp_cast_spell("Will of the Forsaken") or btp_cast_spell("Fade"))) then
        lastBreakCC = GetTime();
        return true;
    elseif (btp_is_impaired("player") and hasLivingAction and
           (GetTime() - lastBreakCC) > 1) then
        for bag=0,4 do
          for slot=1,C_Container.GetContainerNumSlots(bag) do
            if (C_Container.GetContainerItemLink(bag,slot) and
                string.find(C_Container.GetContainerItemLink(bag,slot),
                            "Living Action Potion")) then
                FuckBlizUseContainerItem(bag,slot);
                lastBreakCC = GetTime();
                return true;
            end
          end
        end
    end

    return false;
end


function btp_is_charmed(unit)
    debuffTexture = "foo";
    i = 1;

    while (debuffTexture) do
        debuffName, debuffRank, debuffTexture, debuffApplications,
        debuffType, debuffDuration, debuffTimeLeft, debuffMine,
        debuffStealable = UnitDebuff(unit, i);

        if (debuffTexture and debuffTimeLeft and
            strfind(debuffTexture, "MindSteal")) then
            return true;
        end

        i = i + 1;
    end
end


function btp_is_feared(unit)
    debuffTexture = "foo";
    i = 1;

    while (debuffTexture) do
        debuffName, debuffRank, debuffTexture, debuffApplications,
        debuffType, debuffDuration, debuffTimeLeft, debuffMine,
        debuffStealable = UnitDebuff(unit, i);

        if (debuffTexture and debuffTimeLeft and
           (strfind(debuffTexture, "DeathScream") or
            strfind(debuffTexture, "PsychicScream") or
            strfind(debuffTexture, "GolemThunderClap") or
            strfind(debuffTexture, "Possession"))) then
            return true;
        end

        i = i + 1;
    end
end


function btp_is_stunned(unit)
    return btp_is_impaired(unit);
end

function btp_is_impaired(unit)
    if (btp_is_feared(unit) or btp_is_charmed(unit)) then
        return true;
    end

    debuffTexture = "foo";
    i = 1;

    while (debuffTexture) do
        debuffName, debuffRank, debuffTexture, debuffApplications,
        debuffType, debuffDuration, debuffTimeLeft, debuffMine,
        debuffStealable = UnitDebuff(unit, i);

        if (debuffTexture and debuffTimeLeft and
           (strfind(debuffTexture, "Frost_Stun") or
            strfind(debuffTexture, "FrostBolt02") or
            strfind(debuffTexture, "FrostNova") or
            strfind(debuffTexture, "FrostArmor") or
            strfind(debuffTexture, "Rogue_Trip") or
            strfind(debuffTexture, "GolemStormBolt") or
            strfind(debuffTexture, "Spear_02") or
            strfind(debuffTexture, "ChainsOfIce") or
            strfind(debuffTexture, "Polymorph") or
            strfind(debuffTexture, "Cripple") or
            -- strfind(debuffTexture, "Nature_Sleep") or
            strfind(debuffTexture, "MindSteal") or
            strfind(debuffTexture, "ThunderClap") or
            strfind(debuffTexture, "Nature_Slow") or
            strfind(debuffTexture, "DeathScream") or
            strfind(debuffTexture, "ShockWave") or
            strfind(debuffTexture, "Hex") or
            strfind(debuffTexture, "FrostShock") or
            strfind(debuffTexture, "Sap") or
            strfind(debuffTexture, "Gouge") or
            strfind(debuffTexture, "CheapShot") or
            strfind(debuffTexture, "KidneyShot") or
            strfind(debuffTexture, "StrangleVines") or
            strfind(debuffTexture, "Nature_EarthBind") or
            -- strfind(debuffTexture, "Nature_Sleep") or
            strfind(debuffTexture, "SealOfMight") or
            strfind(debuffTexture, "TurnUndead") or
            strfind(debuffTexture, "GrimWard") or
            strfind(debuffTexture, "DeathCoil"))) then
            return true;
        end

        i = i + 1;
    end
end


function PrintBuffs()
    btp_frame_debug("PLAYER BUFFS");
    for i = 1, 64 do
        buffName, buffIcon, buffCount, dispelType, duration,
        expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer,
        nameplateShowAll, timeMod = UnitBuff("player", i);

        if (buffName) then
            btp_frame_debug(buffName);
        end
    end

    btp_frame_debug("PLAYER DEBUFFS");
    for i = 1, 40 do
        debuffName, buffIcon, debuffCount, dispelType, duration,
        expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer,
        nameplateShowAll, timeMod = UnitDebuff("player", i);

        if (debuffName) then
            btp_frame_debug(debuffName);
        end
    end

    btp_frame_debug("TARGET BUFFS");
    for i = 1, 64 do
        buffName, buffIcon, buffCount, dispelType, duration,
        expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer,
        nameplateShowAll, timeMod = UnitBuff("target", i);

        if (buffName) then
            btp_frame_debug(buffName);
        end
    end

    btp_frame_debug("TARGET DEBUFFS");
    for i = 1, 40 do
        debuffName, buffIcon, debuffCount, dispelType, duration,
        expirationTime, source, isStealable, nameplateShowPersonal,
        spellId, canApplyAura, isBossDebuff, castByPlayer,
        nameplateShowAll, timeMod = UnitDebuff("target", i);

        if (debuffName) then
            btp_frame_debug(debuffName);
        end
    end
end

function DrinkPotion()
    duration = 0;
    start = 0;
    drankPotion = false;
    hasPhysicalProtect = false;
    hasShadowProtect = false;
    hasFireProtect = false;
    hasHolyProtect = false;
    hasNatureProtect = false;
    hasArcaneProtect = false;
    hasMagicProtect = false;
    hasFreeAction = false;
    hasInvulnerability = false;
    hasStealthDetect = false;
    hasPoisonProtect = false;
    hasFrostProtect = false;

    for bag=0,4 do
      for slot=1,C_Container.GetContainerNumSlots(bag) do
        if (C_Container.GetContainerItemLink(bag,slot)) then
          if (string.find(C_Container.GetContainerItemLink(bag,slot), "Stoneshield")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasPhysicalProtect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Shadow Protection")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasShadowProtect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Fire Protection")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasFireProtect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Holy Protection")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasHolyProtect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Nature Protection")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasNatureProtect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Arcane Protection")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasArcaneProtect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Magic Resistance")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasMagicProtect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Free Action")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasFreeAction = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Invulnerability Potion")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasInvulnerability = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Catseye Elixir")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasStealthDetect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Poison Resistance")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasPoisonProtect = true;
              end
          elseif (string.find(C_Container.GetContainerItemLink(bag,slot), "Frost Protection")) then
              start, duration, enable = C_Container.GetContainerItemCooldown(bag, slot);
              if (duration - (GetTime() - start) <= 0) then
                  hasFrostProtect = true;
              end
          end
        end
      end
    end

    if (UnitClass("target") == "Warrior") then
        if (hasPhysicalProtect and (GetTime() - lastPhysicalProtect) >= 121) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Stoneshield")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastPhysicalProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasFreeAction and (GetTime() - lastFreeAction) >= 31) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Free Action")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastFreeAction = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasInvulnerability and (GetTime() - lastInvulnerability) >= 15) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Invulnerability Potion")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastInvulnerability = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    elseif (UnitClass("target") == "Druid") then
        if (hasArcaneProtect and (GetTime() - lastArcaneProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Arcane Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastArcaneProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasNatureProtect and (GetTime() - lastNatureProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Nature Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastNatureProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasPhysicalProtect and (GetTime() - lastPhysicalProtect) >= 121) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Stoneshield")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastPhysicalProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasMagicProtect and (GetTime() - lastMagicProtect) >= 181) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Magic Resistance")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastMagicProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    elseif (UnitClass("target") == "Hunter") then
        if (hasPhysicalProtect and (GetTime() - lastPhysicalProtect) >= 121) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Stoneshield")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastPhysicalProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasArcaneProtect and (GetTime() - lastArcaneProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Arcane Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastArcaneProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasNatureProtect and (GetTime() - lastNatureProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Nature Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastNatureProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasFreeAction and (GetTime() - lastFreeAction) >= 31) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Free Action")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastFreeAction = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasInvulnerability and (GetTime() - lastInvulnerability) >= 15) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Invulnerability Potion")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastInvulnerability = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    elseif (UnitClass("target") == "Mage") then
        if (hasMagicProtect and (GetTime() - lastMagicProtect) >= 181) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Magic Resistance")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastMagicProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasFireProtect and (GetTime() - lastFireProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Fire Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastFireProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasFrostProtect and (GetTime() - lastFrostProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Frost Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastFrostProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasArcaneProtect and (GetTime() - lastArcaneProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Arcane Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastArcaneProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    elseif (UnitClass("target") == "Paladin") then
        if (hasHolyProtect and (GetTime() - lastHolyProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Holy Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastHolyProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasPhysicalProtect and (GetTime() - lastPhysicalProtect) >= 121) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Stoneshield")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastPhysicalProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasFreeAction and (GetTime() - lastFreeAction) >= 31) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Free Action")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastFreeAction = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasInvulnerability and (GetTime() - lastInvulnerability) >= 15) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Invulnerability Potion")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastInvulnerability = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    elseif (UnitClass("target") == "Priest") then
        if (hasShadowProtect and (GetTime() - lastShadowProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Shadow Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastShadowProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasHolyProtect and (GetTime() - lastHolyProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Holy Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastHolyProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasMagicProtect and (GetTime() - lastMagicProtect) >= 181) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Magic Resistance")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastMagicProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    elseif (UnitClass("target") == "Rogue") then
        if (hasFreeAction and (GetTime() - lastFreeAction) >= 31) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Free Action")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastFreeAction = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasPoisonProtect and (GetTime() - lastPoisonProtect) >= 61) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Poison Resistance")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastPoisonProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasPhysicalProtect and (GetTime() - lastPhysicalProtect) >= 121) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Stoneshield")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastPhysicalProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasInvulnerability and (GetTime() - lastInvulnerability) >= 15) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Invulnerability Potion")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastInvulnerability = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasStealthDetect and (GetTime() - lastStealthDetect) >= 601) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Catseye Elixir")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastStealthDetect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    elseif (UnitClass("target") == "Shaman") then
        if (hasPhysicalProtect and (GetTime() - lastPhysicalProtect) >= 121) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Stoneshield")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastPhysicalProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasNatureProtect and (GetTime() - lastNatureProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Nature Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastNatureProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasMagicProtect and (GetTime() - lastMagicProtect) >= 181) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Magic Resistance")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastMagicProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    elseif (UnitClass("target") == "Warlock") then
        if (hasShadowProtect and (GetTime() - lastShadowProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Shadow Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastShadowProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasFireProtect and (GetTime() - lastFireProtect) >= 3600) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Fire Protection")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastFireProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        elseif (hasMagicProtect and (GetTime() - lastMagicProtect) >= 181) then
            for bag=0,4 do
              for slot=1,C_Container.GetContainerNumSlots(bag) do
                if (C_Container.GetContainerItemLink(bag,slot)) then
                  if (string.find(C_Container.GetContainerItemLink(bag,slot), "Magic Resistance")) then
                      FuckBlizUseContainerItem(bag,slot);
                      lastMagicProtect = GetTime();
                      drankPotion = true;
                  end
                end
              end
            end
        else
            drankPotion = false;
        end
    end

    return drankPotion;
end

function math_round( num,  idp )
        -- init numbers
        local idp = idp or 1
        idp = idp + 1
        --get rest
        if tonumber(num) then
                local dpoint = 0
                local count = 0 
                local strnum = ""
                for i in string.gmatch( tostring( num ), "(.)") do
                        if dpoint ~= 0 then
                                count = count + 1
                                if count == idp+1 then
                                        break
                                end
                        end
                        if i == "." then
                                dpoint = 1
                        end
                        strnum = strnum..i
                end
                if dpoint == 0 then
                        return num                               
                end
                -- get number to round
                local toround = tonumber( string.sub( strnum, -1, -1 ) )
                -- evaluate ( if x < 5 then x = 0 ) else x = 10
                if toround < 5 then
                        -- remove last number, done
                        return  tonumber( string.sub( strnum, 1, -2 ) )
                end
                -- else remove last and add one to before
                local ibefore = string.sub( strnum, -2, -2 )
                -- if dot then only add one and return
                if ibefore == "." then
                        return tonumber( string.sub( strnum, 1, -3 ) ) + 1
                end
                ibefore = tonumber( ibefore )
                ibefore = ibefore + 1
                if ibefore == 10 then
                        return math.round( tonumber( string.sub( strnum, 1, -2 ) ), idp-1 )
                end
                return tonumber( string.sub( strnum, 1, -3 )..ibefore )
        end
end

function HoboBeg()
    if ((GetTime() - lastBeg) >= 120) then
        lastBeg = GetTime();
        i = math.random(MAX_BEG_INDEX);
        SendChatMessage(beg[i], "SAY", nil);
    end
end

function Chatter(arg1)
    position = 0;

    for i = 1, MAX_CHATTER do
        local j = 2;
        local count = 0;
        local chatterString = "none";
        local chatterString2 = "none";
        local testString = string.upper(arg1);

        if (string.sub(testString, string.len(testString),
            string.len(testString)) == "," or
            string.sub(testString, string.len(testString),
            string.len(testString)) == ")" or
            string.sub(testString, string.len(testString),
            string.len(testString)) == "!" or
            string.sub(testString, string.len(testString),
            string.len(testString)) == "]" or
            string.sub(testString, string.len(testString),
            string.len(testString)) == "." or
            string.sub(testString, string.len(testString),
            string.len(testString)) == "?") then
            testString = string.sub(testString, 1, string.len(testString) - 1);
        end

        -- 
        -- Looks like we find the case that starts and ends with '*'
        -- Looks like we find the case that contains an '*'
        -- 
        if (chatter[i][1] and string.sub(chatter[i][1], 1, 1) == "*" and
            string.sub(chatter[i][1], string.len(chatter[i][1]),
            string.len(chatter[i][1])) == "*") then
            chatterString = string.sub(chatter[i][1], 3,
            string.len(chatter[i][1]) - 2);

            chatterString = "%s" .. chatterString .. "%s";
            if (chatter[i][1] and string.find(testString, chatterString)) then
                while (chatter[i][j]) do
                    count = count + 1;
                    j = j + 1;
                end

                return chatter[i][(1 + math.random(count))];
            end
        elseif (chatter[i][1] and string.find(chatter[i][1], "*")) then
            x, y = string.find(chatter[i][1], "*");

            --
            -- Starts with '*' or position 1
            -- Contains '*' or position 2
            -- Ends with '*' or position 3
            --
            if (x == 1) then
                chatterString = string.sub(chatter[i][1], y + 2);
                position = 1;
            elseif (x > 1 and x < string.len(chatter[i][1])) then
                chatterString = string.sub(chatter[i][1], 1, x - 1);
                chatterString2 = string.sub(chatter[i][1], y + 1,
                                            string.len(chatter[i][1]));
                position = 2;
            else
                chatterString = string.sub(chatter[i][1], 1, x - 1);
                position = 3;
            end

            if (chatter[i][1] and position == 2 and
                string.sub(testString,  1, string.len(chatterString)) ==
                chatterString and string.sub(testString,
               (string.len(testString) - string.len(chatterString2)) + 1,
                string.len(testString)) == chatterString2) then
                while (chatter[i][j]) do
                    count = count + 1;
                    j = j + 1;
                end

                return chatter[i][(1 + math.random(count))];
            elseif (chatter[i][1] and position == 1 and
                    string.sub(testString,  string.len(testString) -
                    strlen(chatterString), string.len(testString)) ==
                    chatterString) then
                while (chatter[i][j]) do
                    count = count + 1;
                    j = j + 1;
                end

                return chatter[i][(1 + math.random(count))];
            elseif (chatter[i][1] and position == 3 and
                    string.sub(testString, 1, string.len(chatterString)) ==
                    chatterString) then
                while (chatter[i][j]) do
                    count = count + 1;
                    j = j + 1;
                end

                return chatter[i][(1 + math.random(count))];
            end
        elseif (chatter[i][1] and testString == chatter[i][1]) then
            while (chatter[i][j]) do
                count = count + 1;
                j = j + 1;
            end

            return chatter[i][(1 + math.random(count))];
        end
    end

    return "";
end

function btp_has_magic_immune_shield(unit)
    if (unit == nil) then
        unit = "target";
    end

    --
    -- Mage Ice Block
    --
    hasIceBlock, myIceBlock,
    numIceBlock = btp_check_buff("Ice Block", unit);

    --
    -- Pally Divine Shield
    --
    hasDivineInt, myDivineInt,
    numDivineInt = btp_check_buff("Divine Intervention", unit);

    return (hasIceBlock or hasDivineInt);
end

function btp_has_physical_immune_shield(unit)
    if (unit == nil) then
        unit = "target";
    end

    --
    -- Mage Ice Block
    --
    hasIceBlock, myIceBlock,
    numIceBlock = btp_check_buff("Ice Block", unit);

    --
    -- Pally Divine Shield
    --
    hasDivineInt, myDivineInt,
    numDivineInt = btp_check_buff("Divine Intervention", unit);

    return (hasIceBlock or hasDivineInt);
end

function btp_has_immune_shield(unit)
    if (unit == nil) then
        unit = "target";
    end

    return (btp_has_magic_immune_shield(unit) and
            btp_has_physical_immune_shield(unit));
end

function btp_has_magic_absorb_shield(unit)
    if (unit == nil) then
        unit = "target";
    end

    --
    -- Mage: Ice Shield
    --
    hasIceBarrier, myIceBarrier,
    numIceBarrier = btp_check_buff("Ice Barrier", unit);

    --
    -- Priest: Power Word: Shield
    --
    hasPowerWordShield, myPowerWordShield,
    numPowerWordShield = btp_check_buff("Power Word: Shield", unit);

    --
    -- Warlock: Shadow Ward
    --
    hasShadowWard, myShadowWard,
    numShadowWard = btp_check_buff("Shadow Ward", unit);

    return (hasIceBarrier or hasPowerWordShield or hasShadowWard);
end

function btp_has_physical_absorb_shield(unit)
    if (unit == nil) then
        unit = "target";
    end

    --
    -- Priest Shield
    --
    hasPowerWordShield, myPowerWordShield,
    numPowerWordShield = btp_check_buff("Ice_Lament", unit);

    --
    -- Mage Ice Shield
    --
    hasIceBarrier, myIceBarrier,
    numIceBarrier = btp_check_buff("Ice_Lament", unit);

    return (hasIceShield);
end

function btp_has_absorb_shield(unit)
    if (unit == nil) then
        unit = "target";
    end

    return (btp_has_magic_absorb_shield(unit) and
            btp_has_physical_absorb_shield(unit));
end

function btp_name_to_unit(name)
    if (name == nil or name == "Unknown" or UnitName("player") == name) then
        return "player";
    end

    for nextPlayer in btp_iterate_group_members() do
        if (UnitName(nextPlayer) == name) then
            return nextPlayer;
        end

        -- if(UnitExists("raidpet" .. i) and UnitName("raidpet" .. i) == name) then
        --     return "raidpet" .. i;
        -- end
    end

    return "player";
end

function btp_is_moving(unit)
    if(not unit) then unit = "player"; end
    if (GetUnitSpeed(unit)>0) then return true; end
    return false;
end

function btp_stop_moving()
    -- if (stopMoving) then return; end
    if (not btp_config_get("CASTING_STOP")) then return; end;
    -- btp_frame_debug("STOPPING");
    -- btp_do_movement("TURNLEFT");
    FuckBlizzardMove("TURNLEFT");
    btp_state_set("stop_moving", true);
    stopMoving = true;
    return stopMoving;
end

function btp_start_moving()
    btp_state_set("stop_moving", false);
    stopMoving = false;
    return stopMoving;
end

function btp_do_dungeon_stuff()
    --
    -- Clock how long we've been in the instance.
    --
    if (IsInInstance() == nil) then
        instanceTime = GetTime();
    end

    --
    -- This is useful in raids
    --
    ConfirmReadyCheck(true);

    --
    -- This is useful for LFG ready check
    --
    AcceptProposal();
    CompleteLFGRoleCheck(true);

    -- mode, submode = GetLFGMode();

    -- if (farmDungeon and (mode == nil or mode == 'abandonedInDungeon') and
    --    (GetTime() - lastFarmBGTime) >= 30 and
    --     not UnitHasLFGDeserter("player") and
    --     not UnitHasLFGRandomCooldown("player") and
    --     UnitIsDeadOrGhost("player") == nil) then
    --     ShowUIPanel(LFDParentFrame);
    --     SetLFGDungeon(LFDQueueFrame.type);
    --     JoinLFG();
    --     HideUIPanel(LFDParentFrame);
    --     lastFarmBGTime = GetTime();
    -- elseif (farmDungeon and not farmBG and mode == 'lfgparty' and
    --         GetNumPartyMembers() > 0 and GetNumPartyMembers() < 3 and
    --        (GetTime() - lastFarmBGTime) > 30 and
    --        (GetTime() - instanceTime) > 60) then
    --     btp_frame_debug("Leaving LFG system: party falling apart.");
    --     LeaveParty();
    --     LeaveLFG();
    --     lastFarmBGTime = GetTime();
    -- end

    -- if (farmDungeon and not farmBG and mode == 'lfgparty' and
    --     GetNumPartyMembers() > 0 and GetNumPartyMembers() < 4 and
    --    (GetTime() - lastFollowTime) > 120 and btpFollow) then
    --     btp_frame_debug("Leaving LFG system: no one to follow.");
    --     LeaveParty();
    --     LeaveLFG();
    --     lastFollowTime = GetTime();
    -- end

    -- if (farmDungeon and mode == nil and (UnitHasLFGDeserter("player") or
    --     UnitHasLFGRandomCooldown("player"))) then
    --     -- farmBG instead
    --     farmBG = true;
    --     dontRelease = false;
    --     dontHearth = false;
    -- elseif (farmDungeon and GetBattlefieldInstanceRunTime() == 0) then
    --     farmBG = false;
    --     dontRelease = true;
    --     dontHearth = true;
    -- end
end

function btp_do_bg_stuff()
    RequestBattlefieldScoreData();

    --
    -- This should join the last BG we queued for if in BG farm mode.
    --
    for i=1, MAX_BATTLEFIELD_QUEUES do
        status, mapName, instanceID = GetBattlefieldStatus(i);
        if (status == "queued") then
            --
            -- hack to stop us from queueing for BG again.
            --
            lastFarmBGTime = GetTime();
        end
    end

    if (farmBG and GetBattlefieldInstanceRunTime() == 0 and
       (GetTime() - lastFarmBGTime) >= 30) then
        -- btp_frame_debug("Join BG");
        JoinBattlefield(0);
        lastFarmBGTime = GetTime();
    end

    --
    -- If we are in BG and it has not ended get the last time we were in.
    --
    battlefieldWinner = GetBattlefieldWinner();

    if (GetBattlefieldInstanceRunTime() > 0 and
        battlefieldWinner == nil) then
        lastBG = GetTime();
    end

    if (battlefieldWinner ~= nil) then
        -- wait 10 seconds before we exit
        if((GetTime() - lastBG) >= 10) then
            lastBG = 0;
            bgStats = { }; 
            btp_follow_exclusion_del();
            LeaveBattlefield();
        end
    end

    --
    -- Make AFK douche bags go bye bye.
    --
    btp_report_afk();

    --
    -- alert other bots we are one too.
    --
    if (pvpBot and GetNumBattlefieldScores() > 0 and
       (GetTime() - lastExcludeBroadcast) > 60) then
        lastExcludeBroadcast = GetTime();
        SendAddonMessage("BTP", "btpexclude", "BATTLEGROUND");
    end
end

--
-- true of false if a talent exists in the target's tree.
-- This function only works on currently active talents
--
function btp_has_talent(talent_name)
    for tab_index = 1, GetNumTalentTabs() do
        for talent_index = 1, GetNumTalents(tab_index, false,false) do
            name, iconTexture, tier, column, rank, maxRank, isExceptional,
            meetsPrereq, previewRank, meetsPreviewPrereq =
            GetTalentInfo(tab_index, talent_index, false, false, nil);

            if (name == talent_name and rank > 0) then
                return true;
            end
        end
    end

    return false;
end

--
-- true of false if a UnitName() exists in the guild roster.
--
function btp_is_guild_member(unit_name)
    -- until we can fix this
    if (unit_name) then
        return true;
    end

    if (not unit_name) then
        return false;
    end

    --
    -- This while loop hack it so load the GuildRoster() until
    -- it populates.  Once this has happened we should no longer
    -- need to reload the guild roster info.  That is, we want to
    -- cache the guild roster into a hash table in memory for fast
    -- lookup later.  This is causing pain in the client.
    --
    while (IsInGuild() and guild_members[UnitName("player")] == nil) do
        GuildRoster();
        for i = 0, GetNumGuildMembers(true) do
            name, rank, rankIndex, level, class, zone, note, officernote,
            online, status = GetGuildRosterInfo(i);

            if (name) then
                guild_members[name] = true;
            end
        end
    end

    --
    -- Check our cache to see if that name is in the guild
    --
    if (guild_members[unit_name]) then
        return true;
    end

    return false;
end

function GetNumPartyMembers()
  local unit = (not forceParty and IsInRaid()) and 'raid' or 'party'
  local numGroupMembers = unit == 'party' and GetNumSubgroupMembers() or GetNumGroupMembers()
  return numGroupMembers;
end

function btp_iterate_group_members(reversed, forceParty)
  local unit = (not forceParty and IsInRaid()) and 'raid' or 'party'
  local numGroupMembers = unit == 'party' and GetNumSubgroupMembers() or GetNumGroupMembers()
  local i = reversed and numGroupMembers or (unit == 'party' and 0 or 1)
  return function()
    local ret
    if i == 0 and unit == 'party' then
      ret = 'player'
    elseif i <= numGroupMembers and i > 0 then
      ret = unit .. i
    end
    i = i + (reversed and -1 or 1)
    return ret
  end
end

function btp_iterate_group_pets(reversed, forceParty)
  local unit = (not forceParty and IsInRaid()) and 'raidpet' or 'partypet'
  local numGroupMembers = unit == 'partypet' and GetNumSubgroupMembers() or GetNumGroupMembers()
  local i = reversed and numGroupMembers or (unit == 'partypet' and 0 or 1)
  return function()
    local ret
    if i == 0 and unit == 'partypet' then
      ret = 'pet'
    elseif i <= numGroupMembers and i > 0 then
      ret = unit .. i
    end
    i = i + (reversed and -1 or 1)
    return ret
  end
end

function btp_iterate_nearby_nameplates()
    local i = 1
    return function()
        local nextPlayer = "nameplate"..i
        local name = UnitName(nextPlayer)
        if name then
            i = i + 1
            return nextPlayer
        end
    end
end

function btp_unit_has_threat(unit)
    if (not UnitExists(unit)) then btp_debug(unit .. "does not exits"); return false; end

    local unit_threat = UnitThreatSituation(unit)
    if (unit_threat == nil) then btp_debug(unit .. " has no threat"); return false; end
    if (unit_threat > 0) then
        btp_debug(unit .. "has threat");
        return true;
    end
    return false;
end

function btp_is_soft_target(unit)
    -- warriors need rage, hunter can feign, paladins, should have armor
    local soft_target_classes = {"Priest", "Mage", "Warlock", "Druid", "Shaman", "Rouge"};
    for index, v in ipairs(soft_target_classes) do
        if (v == UnitClass(unit)) then
            btp_debug(unit .. " is a soft target");
            return true
        end
    end
    btp_debug(unit .. " is not a soft target");
    return false;
end

--[[


BETA CODE DOWN HERE


]]



-- used to check if the unit is in range of our caster
function btp_unit_in_casting_range(unit)
    if (not UnitIsConnected(unit)) then return false; end
    return btp_class_callback("range", unit);
end

-- used to check if we have a valid unit id
-- NOTE: unit can not be a player name

function btp_is_unitid(unit)
    if (unit == nil) then
        btp_frame_debug("btp_is_unitid - passed a nil unit");
        return false;
    end
    if (unit == "player" or unit == "playertarget" or unit == "target" or strmatch(unit, "party%d+") or strmatch(unit, "raid%d+")) then
        return true;
    end
    btp_frame_debug("btp_is_unitid - passed a non-valid unit: " .. unit);
    return false;
end

function btp_is_party_unit(unit)
    if (unit == nil) then
        btp_debug("btp_is_party_unitid - passed a nil unit");
        return false;
    end
    if (unit == "player" or strmatch(unit, "party%d+") or strmatch(unit, "raid%d+")) then
        btp_debug("btp_is_party_unitid - YES: " .. unit);
        return true;
    end
    btp_debug("btp_is_party_unit - NO: " .. unit);
    return false;
end



-- Ordered list of all player classes
BTP_BASIC_PRIORITIES = {
    "Warrior",
    "Paladin",
    "Priest",
    "Druid",
    "Shaman",
    "Mage",
    "Death Knight",
    "Demon Hunter",
    "Warlock",
    "Monk",
    "Hunter",
    "Rogue"
}

function btp_unit_is_player(unit)
    local unitinfo = btp_unitinfo_get(unit);
    if (unitinfo.name == BTP_PLAYER_INFO.name) then return true; end
    return false
end

function btp_set_priority_order()
    for nextPlayer in btp_iterate_group_members() do
        local unitinfo = btp_unitinfo_get(nextPlayer);
    end
    for nextPet in btp_iterate_group_pets() do
        local unitinfo = btp_unitinfo_get(nextPet);
    end

    -- Loop over BTP_PLAYER_INFO and add the player info to the ordered list
    for unit, info in pairs(BTP_PLAYER_INFO) do
        table.insert(BTP_UNITINFO_PRIORITY_ORDER, info)
    end

    -- Sort the list based on the priority value
    table.sort(BTP_UNITINFO_PRIORITY_ORDER, function(a, b)
        return a.priority < b.priority
    end)

end

function btp_class_callback(callback, unit)
    local player_class = UnitClass("player")
    local class_callbacks = BTP_CLASS_CALLBACKS[player_class]

    if (not class_callbacks) then
        btp_frame_debug("No callbacks for " .. player_class);
        return false
    end
    
    class_callback_function = class_callbacks[callback];
    -- btp_frame_debug("RUNNING: " .. player_class .. " " .. callback);
    return class_callback_function(unit)
end

-- this can be used to cycle targets
function btp_target_friend()
    btp_debug("btp_target_friend - called");
    FuckBlizzardByName("targetfriend");
    return true;
end

-- if we are in a party always have a friendly target
function btp_target_party_member()
    btp_debug("finding_party_member - called");
    if (btp_config_get("ROAMING")) then
        return btp_target_friend();
    end
    FuckBlizzardTargetUnit("party1");
    return true;
end


function btp_bind_keys()
    local time_last_key_bind = btp_state_get("time_last_key_bind") or 0;
    local time_last_unitinfo_update = btp_state_get("time_last_unitinfo_update") or 0;

    local durration_last_key_bind = GetTime() - time_last_key_bind;
    local durration_last_unitinfo_update = GetTime() - time_last_unitinfo_update;

    if (durration_last_key_bind > 5) then
        btp_state_set("time_last_key_bind", GetTime());
        -- spellbook update also happens here since it creates a new keybind
        ProphetKeyBindings();
    end

    if (durration_last_unitinfo_update > 5) then
        btp_state_set("time_last_unitinfo_update", GetTime());
        btp_unitinfo_update();
    end

    return false;
end

-- not all units are in party
function btp_unit_in_party(unit)
    if (UnitExists(unit) == nil) then return false; end
    -- if unit is "target" we need to get the name to check against party members
    local unitinfo = btp_unitinfo_get_by_name(unit);
    if(unitinfo == nil) then return false; end
    return unitinfo.party_unit;
end

function btp_unitname_in_party(unit_name)
    local unitinfo = btp_unitinfo_get_by_name(unit_name);
    if(unitinfo == nil) then return false; end
end

function btp_get_party_size()
    local party_size = 0
    for nextPlayer in btp_iterate_group_members() do
        party_size = party_size + 1;
    end
    return party_size;
end

function btp_in_party()
    local party_size = btp_get_party_size();
    if (party_size > 1) then return true; end
    return false;
end

function btp_do_movement(movement)
    if (btp_state_get("stop_moving")) then return false; end
    if (stopMoving) then return false; end
    btp_debug("executing movement: " .. movement);
    FuckBlizzardMove(movement);
end

function btp_unit_in_combat(unit)
    if (UnitAffectingCombat(unit)) then
        return true;
    end
    return false;
end

function btp_is_player(unit)
    if (UnitName(unit) == UnitName("player")) then return true; end
    return false;
end

BTP_STATE = {}

function btp_state_set (state, value)
    --[[
    if (value == nil or state == nil) then 
        -- btp_frame_debug("btp_state_set: nil value");
        btp_debug("btp_state_set: nil value");
        return false;
    end
    ]]
    btp_debug("btp_state_set: " .. state .. " = " .. tostring(value));
    BTP_STATE[state] = value;
    return true;
end

function btp_state_get(state)
    if (BTP_STATE[state] == nil) then 
        -- btp_frame_debug("btp_state_get nil state");
        return false;
    end
    return BTP_STATE[state];
end

function btp_dps_mode_toggle()
    if(DPS_MODE_ON == nil or DPS_MODE_ON == false) then
        btp_config_set("DPS", true);
        DPS_MODE_ON = true;
        btp_frame_debug("DPS_MODE = ON");
    else
        btp_config_set("DPS", false);
        DPS_MODE_ON = false;
        btp_frame_debug("DPS_MODE = OFF");
    end
end


