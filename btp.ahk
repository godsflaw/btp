; Behead The Prophet code.
; Chris Mooney, James Luedke

;
; Change the following to "false" if you expect to use this code in
; non-robot conditions.  For instance, if you were using the warlock
; code you would want this to be false.  
; 
botOn          := "true"

;
;
; Farm BG
;
farmBG         := "false"

;
; Change the following to "true" if you are going to use the node
; farming bot.  You will want to bind the macro btp_collect_herb(false) to
; the key findNode is assigned to, and the macro btp_collect_herb(true) to
; the key clearNode is assigned to below.
; 
nodeBotOn      := "false"

;
; NOTE: Since we have added stopcasting callbacks this should always
; be false.
;
; Set this to "true" if your care more about big heals then mana.  If
; this is "true" it will not wait to check the casting bar, and will
; result in some heals going off twice.  If this is "false" the code will
; always wait 200ms before checking if anyone needs a heal again.  This
; change stops what we call "double bouncing" of the heals.
;
doubleBounce   := "false"

;
; The following are the keys you have bound to /cleanframe and /btpbot
; respectively.  If you use {home} or 9 in your normal opperations then
; you should bind these macros in-game to another key and put the key
; in here.  You can find meta-key commands like {home} at:
; http://www.autohotkey.com/docs/commands/Send.htm
;
clearKey       := "{home}"

;
; The following only matters if you are running the bot
;
btpBotKey    := "9"
findNode     := "1"
clearNode    := "2"
moveDown     := "x"
moveDownUp   := "{x Up}"
moveDownDown := "{x Down}"

;
; The following only matters if you want to configure the bot to be
; logged on by a player through the website.
;
;bot_login   := "true"
;botName     := "[Your Character]"
;path_to_wow := "C:\Program Files\World of Warcraft"
;wow_exe     := "cosmos.exe"
;username    := "username"
;password    := "foobar"

; The first time you run this you must configure the Casting Bar location
; which is different on every computer. To do this you must start the
; macro program and enter warcraft. Start casting a spell such as 
; "Greater Heal" which makes the casting bar appear at the bottom of the
; page. put your mose over the Casting Bar leave it there for a few
; seconds until the message box appears with your X and Y cords.
; Set the cbarx and cbary to the values in the message box.
; Once that is done comment out the lines bellow by placing a ";" in
; front of the line

;Sleep, 9000
;MouseGetPos, OutputVarX, OutputVarY
;PixelGetColor, OutputVar, OutputVarX, OutputVarY, RGB
;MsgBox % "X: " . OutputVarX . "Y: " . OutputVarY
;Sleep, 3000
;ExitApp, 0

; comment out to here
; Set these two vars with the above X and Y
;
; Bot box Druid
;
;cbarx := 462
;cbary := 650
;
; My box Druid
;
;cbarx := 878
;cbary := 996
;
; My Box Priest
;
;cbarx := 881
;cbary := 1029

; You may also want to find the point that is as far to the lower left as
; you can; however, this is not normaly important.  You can just use your
; screen res for this.
;
; Bot box
;
;maxX  := 1600
;maxY  :=  800
;
; My box
;
maxX  := 1828
maxY  := 1064

;
; The following is needed for the btpclick command.  You will want to use
; this to find the very center of your screen.  This would be the location
; of merchants, portals, battle masters, and flight masters.  Get the value
; by uncommenting the following code to see the X, Y positions and then plug
; them in for centerX and centerY below.
;
;Sleep, 9000
;MouseGetPos, OutputVarX, OutputVarY
;PixelGetColor, OutputVar, OutputVarX, OutputVarY, RGB
;MsgBox % "X: " . OutputVarX . "Y: " . OutputVarY
;Sleep, 3000
;ExitApp, 0

; comment out to here
; Set these two vars with the above X and Y
;
; Bot box
;
;centerX := 502
;centerY := 361
;
; My box
;
centerX := 961
centerY := 603

;
; The following is needed for the gathering bot.  You need to take 16 locations
; next to the center of the minimap and get the (x,y) coordinates for each
; one.
;
;Sleep, 9000
;MouseGetPos, OutputVarX, OutputVarY
;PixelGetColor, OutputVar, OutputVarX, OutputVarY, RGB
;MsgBox % "X: " . OutputVarX . "Y: " . OutputVarY
;Sleep, 3000
;ExitApp, 0

; comment out to here
; Set these eight vars with the above X and Y at each minimap location.
;
; Bot box
;
mm1x  := 1585
mm1y  := 90
mm2x  := 1600
mm2y  := 90
mm3x  := 1615
mm3y  := 90
mm4x  := 1630
mm4y  := 90

mm5x  := 1585
mm5y  := 100
mm6x  := 1600
mm6y  := 100
mm7x  := 1615
mm7y  := 100
mm8x  := 1630
mm8y  := 100

mm9x  := 1585
mm9y  := 110
mm10x := 1600
mm10y := 110
mm11x := 1615
mm11y := 110
mm12x := 1630
mm12y := 110

mm13x := 1585
mm13y := 120
mm14x := 1600
mm14y := 120
mm15x := 1615
mm15y := 120
mm16x := 1630
mm16y := 120


;
; There should be no reason to change anything below this line unless you
; are told to or know what your doing.
;

nodeActive     := "false"
lastX          := 0
lastY          := 50
r              := 0
g              := 0
b              := 0
index          := 0
count          := 0
in_game_count  := 0
star_x         := 5
start_y        := 5

hex%index% := "00"
index += 1
hex%index% := "11"
index += 1
hex%index% := "22"
index += 1
hex%index% := "33"
index += 1
hex%index% := "44"
index += 1
hex%index% := "55"
index += 1
hex%index% := "66"
index += 1
hex%index% := "77"
index += 1
hex%index% := "88"
index += 1
hex%index% := "99"
index += 1
hex%index% := "AA"
index += 1
hex%index% := "BB"
index += 1
hex%index% := "CC"
index += 1
hex%index% := "DD"
index += 1
hex%index% := "EE"
index += 1
hex%index% := "FF"

index := 1
letters%index% := "a"
index += 1
letters%index% := "b"
index += 1
letters%index% := "c"
index += 1
letters%index% := "d"
index += 1
letters%index% := "e"
index += 1
letters%index% := "f"
index += 1
letters%index% := "g"
index += 1
letters%index% := "h"
index += 1
letters%index% := "i"
index += 1
letters%index% := "j"
index += 1
letters%index% := "k"
index += 1
letters%index% := "l"
index += 1
letters%index% := "m"
index += 1
letters%index% := "n"
index += 1
letters%index% := "o"
index += 1
letters%index% := "p"
index += 1
letters%index% := "q"
index += 1
letters%index% := "r"
index += 1
letters%index% := "s"
index += 1
letters%index% := "t"
index += 1
letters%index% := "u"
index += 1
letters%index% := "v"
index += 1
letters%index% := "w"
index += 1
letters%index% := "x"
index += 1
letters%index% := "y"
index += 1
letters%index% := "z"
index += 1
letters%index% := "``"
index += 1
letters%index% := "-"
index += 1
letters%index% := "="
index += 1
letters%index% := "["
index += 1
letters%index% := "]"
index += 1
letters%index% := ";"
index += 1
letters%index% := "'"
index += 1
letters%index% := "," 
index += 1
letters%index% := "."
index += 1
letters%index% := "/"
index += 1
letters%index% := "1"
index += 1
letters%index% := "2"
index += 1
letters%index% := "3"
index += 1
letters%index% := "4"
index += 1
letters%index% := "5"
index += 1
letters%index% := "6"
index += 1
letters%index% := "7"
index += 1
letters%index% := "8"
index += 1
letters%index% := "9"
index += 1


URLtoVAR(URL, ByRef Result, UserAgent = "", Proxy = "", ProxyBypass = "")
{
    ; Requires Windows Vista, Windows XP, Windows 2000 Professional,
    ; Windows NT Workstation 4.0,
    ; Windows Me, Windows 98, or Windows 95.
    ; Requires Internet Explorer 3.0 or later.
 
    hModule := DllCall("LoadLibrary", "Str", "wininet.dll")

    AccessType := Proxy != "" ? 3 : 1
    ;INTERNET_OPEN_TYPE_PRECONFIG                    0   // use registry config
    ;INTERNET_OPEN_TYPE_DIRECT                       1   // direct to net
    ;INTERNET_OPEN_TYPE_PROXY                        3   // via named proxy
    ;INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY  4   // no java/script/INS

    io := DllCall("wininet\InternetOpenA"
     , "Str", UserAgent ;lpszAgent
     , "UInt", AccessType
     , "Str", Proxy
     , "Str", ProxyBypass
     , "UInt", 0) ;dwFlags
   
    iou := DllCall("wininet\InternetOpenUrlA"
     , "UInt", io
     , "Str", url
     , "Str", "" ;lpszHeaders
     , "UInt", 0 ;dwHeadersLength
     , "UInt", 0x80000000 ;dwFlags: INTERNET_FLAG_RELOAD = 0x80000000
     , "UInt", 0) ;dwContext
   
    If (ErrorLevel != 0 or iou = 0)
    {
        DllCall("FreeLibrary", "UInt", hModule)
        return 0
    }
   
    VarSetCapacity(buffer, 10240, 0)
    VarSetCapacity(BytesRead, 4, 0)
   
    Loop
    {
        irf := DllCall("wininet\InternetReadFile", "UInt", iou, "UInt", &buffer, "UInt", 10240, "UInt", &BytesRead)
        VarSetCapacity(buffer, -1)
    
        BytesRead_ = 0
        Loop, 4
            BytesRead_ += *(&BytesRead + A_Index-1) << 8*(A_Index-1)
   
        If (irf = 1 and BytesRead_ = 0)
            break
        Else
            Result .= SubStr(buffer, 1, BytesRead_)
   
        /* optional: retrieve only a part of the file
        BytesReadTotal += BytesRead_
        If (BytesReadTotal >= 30000)
           break
        */
    }
   
    DllCall("wininet\InternetCloseHandle",  "UInt", iou)
    DllCall("wininet\InternetCloseHandle",  "UInt", io)
    DllCall("FreeLibrary", "UInt", hModule)
}

index = 0
Loop
{
    if (b > 15)
    {
        b := 0
        g += 1

        if (g > 15)
        {
            g := 0
            r += 1

            if (r > 15)
            {
                break
            }
        }
    }

    hexToIndex%index% := "0x" . hex%r% . hex%g% . hex%b%
    ;tmp := hexToIndex%index%
    ;FileAppend, ( %index% = %tmp% ), F:\foo.txt

    b += 1
    index += 1
}


state := 1
i     := 1
index := 1
keyPress%index% := "{Ctrl Down}1{Ctrl Up}"
index += 1
i     += 1
keyPress%index% := "{Up Down}{Space}{Up Up}"
index += 1
i     += 1
keyPress%index% := "{Down Down}{Space}{Down Up}"
index += 1
i     += 1
keyPress%index% := "{Left}"
index += 1
i     += 1
keyPress%index% := "{Right}"
index += 1
i     += 1
keyPress%index% := "{Space}"
index += 1
i     += 1
keyPress%index% := moveDown
index += 1
i     += 1
keyPress%index% := "t"
index += 1
i     += 1

Loop
{
    if (state == 1)
    {
        keyPress%index% := "{Ctrl Down}" . letters%i% . "{Ctrl Up}"
    }
    else if (state == 2)
    {
        keyPress%index% := "{Ctrl Down}{Shift Down}" . letters%i% . "{Shift Up}{Ctrl Up}"
    }
    else if (state == 3)
    {
        keyPress%index% := "{Alt Down}" . letters%i% . "{Alt Up}"
    }
    else if (state == 4)
    {
        keyPress%index% := "{Alt Down}{Shift Down}" . letters%i% . "{Shift Up}{Alt Up}"
    }
    else if (state == 5)
    {
        keyPress%index% := "{Alt Down}{Ctrl Down}" . letters%i% . "{Ctrl Up}{Alt Up}"
    }
    else if (state == 6)
    {
        keyPress%index% := "{Alt Down}{Ctrl Down}{Shift Down}" . letters%i% . "{Shift Up}{Ctrl Up}{Alt Up}"
    }

    index += 1
    i     += 1

    if (i > 45 || (i > 36 && state == 1))
    {
        i := 1
        state += 1

        if (state > 6)
        {
            break
        }
    }
}

MAX_KEY := index

i     := 1
index := MAX_KEY + 1
targetToString%index% := "target player{Enter}"
index += 1
targetToString%index% := "target focus{Enter}"
index += 1
targetToString%index% := "target pet{Enter}"
index += 1
targetToString%index% := "target pettarget{Enter}"
index += 1
targetToString%index% := "targetfriend{Enter}"
index += 1
targetToString%index% := "targetenemy{Enter}"
index += 1
targetToString%index% := "target targettarget{Enter}"
index += 1

Loop, 40
{
    targetToString%index% := "target raid" . i . "{Enter}"
    index += 1
    targetToString%index% := "target raid" . i . "target{Enter}"
    index += 1
    targetToString%index% := "target raidpet" . i . "{Enter}"
    index += 1
    targetToString%index% := "target raidpet" . i . "target{Enter}"
    index += 1

    if (i < 5)
    {
        targetToString%index% := "target party" . i . "{Enter}"
        index += 1
        targetToString%index% := "target party" . i . "target{Enter}"
        index += 1
        targetToString%index% := "target partypet" . i . "{Enter}"
        index += 1
        targetToString%index% := "target partypet" . i . "target{Enter}"
        index += 1
    }

    i     += 1
}

MAX_TARGET := index
Sleep, 5000

finit_cnt := 1
Loop
{
    ;letters%index% := "/"
    ;index += 1
    
    xbox := 10
    ybox := 5
    Send /
    Sleep, 75
    SendInput btp_finit{Enter}
    Loop
    {
        Loop
        {
            ;MouseMove, xbox, ybox
            PixelGetColor, OutputVar, xbox, ybox, RGB
            if(not b1 and OutputVar == "0x000011")
            {
                b1x := xbox
                b1y := ybox
                ;MsgBox % OutputVarX . " box one" 
                b1 := 1
            }
            else if(not b2 and OutputVar == "0x000022")
            {
                ;MsgBox % OutputVarX . " box 2" 
                b2x := xbox
                b2y := ybox
                b2 := 1
            }
            else if(not b3 and OutputVar == "0x000033")
            {
                ;MsgBox % OutputVarX . " box 3" 
                b3x := xbox
                b3y := ybox
                b3 := 1
            }
            else if(not b4 and OutputVar == "0x000044")
            {
                ;MsgBox % OutputVarX . " box 4" 
                b4x := xbox
                b4y := ybox
                b4 := 1
            }
            else if(not b5 and OutputVar == "0x000055")
            {
                ;MsgBox % OutputVarX . " box 5" 
                b5x := xbox
                b5y := ybox
                b5 := 1
            }
            else if(not b6 and OutputVar == "0x000066")
            {
                ;MsgBox % OutputVarX . " box 6" 
                b6x := xbox
                b6y := ybox
                b6 := 1
            }
            else if(not b7 and OutputVar == "0x000077")
            {
                ;MsgBox % OutputVarX . " box 7" 
                b7x := xbox
                b7y := ybox
                b7 := 1
            }
            else if(not b8 and OutputVar == "0x000088")
            {
                ;MsgBox % OutputVarX . " box 8" 
                b8x := xbox
                b8y := ybox
                b8 := 1
            }
            else if(not b9 and OutputVar == "0x000099")
            {
                ;MsgBox % OutputVarX . " box 9" 
                b9x := xbox
                b9y := ybox
                b9 := 1
            }
            else if(not bA and OutputVar == "0x0000AA")
            {
                ;MsgBox % OutputVarX . " box A" 
                bAx := xbox
                bAy := ybox
                bA := 1
            }
            else if(not bB and OutputVar == "0x0000BB")
            {
                ;MsgBox % OutputVarX . " box B" 
                bBx := xbox
                bBy := ybox
                bB := 1
            }
            else if(not bC and OutputVar == "0x0000CC")
            {
                ;MsgBox % OutputVarX . " box C" 
                bCx := xbox
                bCy := ybox
                bC := 1
            }
            else if(not bD and OutputVar == "0x0000DD")
            {
                ;MsgBox % OutputVarX . " box D" 
                bDx := xbox
                bDy := ybox
                bD := 1
            }
            else if(not bE and OutputVar == "0x0000EE")
            {
                bEx := xbox
                bEy := ybox
                ;MsgBox % bEx . " " . bEy
                bE := 1
            }

            xbox += 5
            if(xbox > 4096)
            {
                break
            }
    
            if(b1 and b2 and b3 and b4 and b5 and b6 and b7 and b8 and b9 and bA and bB and bC and bD and bE)
            {
                SendInput %clearKey%
                ybox := 1024
                break
            }
        }

        ybox += 5

        if(ybox > 1024)
        {
            break
        }

        xbox = 5
    }

    if(b1 and b2 and b3 and b4 and b5 and b6 and b7 and b8 and b9 and bA and bB and bC and bD and bE)
    {
        SendInput %clearKey%
        break
    }
    else
    {
        Send /
        Sleep, 75
        SendInput btp_dbg Could not find frame command boxes trying again{Enter}
        Sleep, 5000
        if(finit_cnt > 2)
        {
            MsgBox "Error: Could not configure your output boxes! WILL NOT WORK! AHK EXITING!"
            ExitApp, 1
        }
        finit_cnt += 1
    }
}

fpause := 0
clickTime := 300
Loop
{
    if(fpause == 0 and botOn == "true")
    {
        ;MouseClick, right, %centerX%, %centerY%
        SendInput %btpBotKey%
        Sleep, 150
    }

    if(farmBG == "true")
    {
        if(clickTime >= 300)
        {
            MouseClick, right, %centerX%, %centerY%
            clickTime := 0
        }
        else
        {
            clickTime += 1
        }
    }

    if(fpause == 0 and nodeBotOn == "true")
    {
        ;MouseClick, right, %centerX%, %centerY%
        SendInput %findNode%
        Sleep, 150
    }

    if count < 5
    {
        count += 1
	Sleep, 1000
    }
    else
    {
        ;MsgBox % OutputVar
	;sleep 3000

        PixelGetColor, OutputVar, cbarx, cbary, RGB

        if (needClear == "true" and fpause == 0)
        {
            needClear := "false"
            SendInput %clearKey%
        }

;	if(botOn == "true" and OutputVar != "0xFF0000")
;        {
;            ;MsgBox % OutputVar
;            if (doubleBounce != "true")
;            {
;                Sleep, 150
;            }
;
;            needClear := "true"
;
;            if (bot_login == "true" and in_game_count > 305)
;            {
;              ; This means we have bounced out of the game and
;              ; should check to see if anyone would like us to
;              ; log back on.  This will run once a minute.
;              Sleep, 60000
;              urldata := "false"
;              URLtoVAR("http://btp.dod.net/bots.php?name=" . %botName%, urldata)
;              filedelete, btp_check.txt
;              fileappend, %urldata%,btp_check.txt
;
;              if (urldata == "true")
;              {
;                  ; Go through the trouble of getting the bot logged on
;                  ; here.
;                  SendInput {Alt Down}{F4}{Alt Up}
;                  Sleep, 30000
;                  Run, %wow_exe%, %path_to_wow%
;                  Sleep, 30000
;                  SendInput %username%
;                  SendInput {Tab}
;                  SendInput %password%
;                  SendInput {Enter}
;                  Sleep, 15000
;                  SendInput {Enter}
;                  Sleep, 60000
;              }
;            }
;            else
;            {
;                in_game_count += 1
;            }
;
;            Continue
;        }
	if(botOn == "true" and count > 305)
        {
            Sleep, 150
            SendInput {Enter}
            Sleep, 150
            count := 5
        }
        else
        {
            in_game_count := 0
        }

        ;
        ; The following should help you find the screen positions of
        ; the color frames.  Just uncomment the next two lines and
        ; run the macro.  When you go into your app place the mouse
        ; over the position where you would like to get the color.
        ; A message box will pop up with the color, so make a note
        ; of the values and kill the script before you hit okay.
        ; Now you can use the X, Y position for PixelGetColor
        ;
        ;MouseGetPos, OutputVarX, OutputVarY
        ;MsgBox % OutputVarX . " " . OutputVarY
        ;
        ; IT Frame
        ;
        PixelGetColor, OutputVar, b1x, b1y, RGB

        if (OutputVar == "0x121212")
        {
            Send /
            Sleep, 75
            SendInput btp_dbg stopping keys{Enter}
            Sleep, 1000
            SendInput %clearKey%
            Sleep, 75
            ExitApp, 0
        }

        if (fpause == 1)
        {
            if(OutputVar == "0x000000")
            {
                Send /
                Sleep, 75
                fpause := 0
                SendInput btp_dbg GO{enter}
                needClear := "false"
                SendInput %clearKey%
            }

            Sleep, 2000
            Continue
        }

        if (OutputVar == "0x984343")
        {
            Send /
            Sleep, 75
            SendInput btp_dbg PAUSE{enter}
            fpause := 1
            Sleep, 1000
            Continue
        }

        if (OutputVar == "0xFFFFFF")
        {
            ;
            ; Then we are good to go
            ;
            Sleep, 100
            count += 1
        }
        else
        {
            count := 5
            Continue
        }

        ;
        ; This block is unused as of now.  Uncomment if we ever need
        ; the Inventory Item Target frame for anything.  But we will
        ; need to move the signal code to another frame.  This is a
        ; hack for now, but who gives a fuck.  I am lazy.
        ;
        ;     if (OutputVar == hexToIndex%i%)
        ; i := 1
        ; Loop, %MAX_TARGET%
        ; {
        ;     {
        ;         if (i <= MAX_KEY)
        ;         {
        ;             str := keyPress%i%
        ;             SendInput %str%
        ;         }
        ;         else
        ;         {
        ;             if (botOn != "true")
        ;             {
        ;                 str := "focus target{Enter}"
        ;                 Send /
        ;                 Sleep, 75
        ;                 SendInput %str%
        ;                 Sleep, 75
        ;             }
        ;     
        ;             str := targetToString%i%
        ;             Send /
        ;             Sleep, 75
        ;             SendInput %str%
        ;         }
        ; 
        ;         Sleep, 75
        ;         needClear := "true"
        ;         Break
        ;     }
        ; 
        ;     i += 1
        ; }

        ;
        ; IA Frame
        ;
        PixelGetColor, OutputVar, b2x, b2y, RGB
        i := 1
        Loop, %MAX_KEY%
        {
            if (OutputVar == hexToIndex%i%)
            {
                if (i == 2)
                {
                    SendInput {Up Down}
                    Sleep 1000
                    SendInput {Up Up}
                }
                else if (i == 3)
                {
                    SendInput {Down Down}
                    Sleep 1000
                    SendInput {Down Up}
                }
                else if (i == 4)
                {
                    SendInput {Left Down}
                    Sleep 50
                    SendInput {Left Up}
                }
                else if (i == 5)
                {
                    SendInput {Right Down}
                    Sleep 50
                    SendInput {Right Up}
                }
                else if (i == 8)
                {
                    MouseClick, right, %centerX%, %centerY%
                    Sleep, 10000
                }
                else
                {
                    str := keyPress%i%
                    SendInput %str%
                }

                Sleep, 75
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x101010")
            {
                ;
                ; Move Forward
                ;
                SendInput {Down Up}
                SendInput {Space Up}
                SendInput %moveDownUp%

                SendInput {Up Down}
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x202020")
            {
                ;
                ; Move Back
                ;
                SendInput {Up Up}
                SendInput {Space Up}
                SendInput %moveDownUp%

                SendInput {Down Down}
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x303030")
            {
                ;
                ; Turn Left
                ;
                SendInput {Up Up}
                SendInput {Down Up}
                SendInput {Space Up}
                SendInput %moveDownUp%

                SendInput {Left Down}
                Sleep, 50
                SendInput {Left Up}
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x404040")
            {
                ;
                ; Turn Right
                ;
                SendInput {Up Up}
                SendInput {Down Up}
                SendInput {Space Up}
                SendInput %moveDownUp%

                SendInput {Right Down}
                Sleep, 50
                SendInput {Right Up}
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x505050")
            {
                ;
                ; Jump / Fly Up
                ;
                SendInput {Up Up}
                SendInput {Down Up}
                SendInput {Space Up}
                SendInput %moveDownUp%

                SendInput {Space Down}
                Sleep, 250
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x606060")
            {
                ;
                ; Swim / Fly Down
                ;
                SendInput {Up Up}
                SendInput {Down Up}
                SendInput {Space Up}

                SendInput %moveDownDown%
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x707070")
            {
                ;
                ; Right Click
                ;
                SendInput {Up Up}
                SendInput {Down Up}
                SendInput {Space Up}
                SendInput %moveDownUp%

                MouseClick, right, %lastX%, %lastY%
                Sleep, 10000
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x808080")
            {
                ;
                ; Scan for Loot
                ;
                SendInput {Up Up}
                SendInput {Down Up}
                SendInput {Space Up}
                SendInput %moveDownUp%

                if (lastX > maxX)
                {
                    if (lastY > maxY)
                    {
                        lastY := 50
                    }

                    lastX := 0
                    lastY += 50
                }
                else
                {
                    lastX += 100
                }

                MouseMove, %lastX%, %lastY%
                needClear := "true"
                Break
            }
            else if (OutputVar == "0x909090")
            {
                ;
                ; Stop Moving / Do Nothing
                ;
                SendInput {Up Up}
                SendInput {Down Up}
                SendInput {Space Up}
                SendInput %moveDownUp%
                needClear := "true"
                Break
            }
            else if (OutputVar == "0xA0A0A0")
            {
                ;
                ; Check if node is there
                ;
                SendInput {Up Up}
                SendInput {Down Up}
                SendInput {Space Up}
                SendInput %moveDownUp%
                needClear := "true"
        
                PixelGetColor, OutputVar, mm1x, mm1y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm2x, mm2y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm3x, mm3y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm4x, mm4y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm5x, mm5y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm6x, mm6y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm7x, mm7y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm8x, mm8y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm9x, mm9y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm10x, mm10y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm11x, mm11y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm12x, mm12y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm13x, mm13y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm14x, mm14y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm15x, mm15y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }
        
                PixelGetColor, OutputVar, mm16x, mm16y, RGB
                if (OutputVar == "0xFF0000")
                {
                    nodeActive := "true"
                }

                if (nodeActive == "true")
                {
                    nodeActive := "false"
                }
                else
                {
                    SendInput %clearNode%
                }

                Break
            }

            i += 1
        }

        ;
        ; IPT Frame
        ;
        PixelGetColor, OutputVar, b3x, b3y, RGB
        i := 1
        Loop, %MAX_TARGET%
        {
            if (OutputVar == hexToIndex%i%)
            {
                if (i <= MAX_KEY)
                {
                    str := keyPress%i%
                    SendInput %str%
                }
                else
                {
                    if (botOn != "true")
                    {
                        str := targetToString%i%
                        Send /
                        Sleep, 75
                        SendInput %str%
                    }
                }

                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; CT Frame
        ;
        PixelGetColor, OutputVar, b4x, b4y, RGB
        i := 1
        Loop, %MAX_TARGET%
        {
            if (OutputVar == hexToIndex%i%)
            {
                if (i <= MAX_KEY)
                {
                    str := keyPress%i%
                    SendInput %str%
                }
                else
                {
                    if (botOn != "true")
                    {
                        str := "focus target{Enter}"
                        Send /
                        Sleep, 75
                        SendInput %str%
                        Sleep, 75
                    }

                    str := targetToString%i%
                    Send /
                    Sleep, 75
                    SendInput %str%
                }

                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; CA Frame
        ;
        PixelGetColor, OutputVar, b5x, b5y, RGB
        i := 1
        Loop, %MAX_KEY%
        {
            if (OutputVar == hexToIndex%i%)
            {
                str := keyPress%i%
                SendInput %str%
                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; CPT Frame
        ;
        PixelGetColor, OutputVar, b6x, b6y, RGB
        i := 1
        Loop, %MAX_TARGET%
        {
            if (OutputVar == hexToIndex%i%)
            {
                if (i <= MAX_KEY)
                {
                    str := keyPress%i%
                    SendInput %str%
                }
                else
                {
                    if (botOn != "true")
                    {
                        str := targetToString%i%
                        Send /
                        Sleep, 75
                        SendInput %str%
                    }
                }
                  
                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; AT Frame
        ;
        PixelGetColor, OutputVar, b7x, b7y, RGB
        i := 1
        Loop, %MAX_TARGET%
        {
            if (OutputVar == hexToIndex%i%)
            {
                if (i <= MAX_KEY)
                {
                    str := keyPress%i%
                    SendInput %str%
                }
                else
                {
                    if (botOn != "true")
                    {
                        str := "focus target{Enter}"
                        Send /
                        Sleep, 75
                        SendInput %str%
                        Sleep, 75
                    }

                    str := targetToString%i%
                    Send /
                    Sleep, 75
                    SendInput %str%
                }

                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; AA Frame
        ;
        PixelGetColor, OutputVar, b8x, b8y, RGB
        i := 1
        Loop, %MAX_KEY%
        {
            if (OutputVar == hexToIndex%i%)
            {
                str := keyPress%i%
                SendInput %str%

                if (botOn == "true")
                {
                    Sleep, 750
                }
                else
                {
                    Sleep, 75
                }

                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; APT Frame
        ;
        PixelGetColor, OutputVar, b9x, b9y, RGB
        i := 1
        Loop, %MAX_TARGET%
        {
            if (OutputVar == hexToIndex%i%)
            {
                if (i <= MAX_KEY)
                {
                    str := keyPress%i%
                    SendInput %str%
                }
                else
                {
                    if (botOn != "true")
                    {
                        str := targetToString%i%
                        Send /
                        Sleep, 75
                        SendInput %str%
                    }
                }
                  
                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; PT Frame
        ;
        PixelGetColor, OutputVar, bAx, bAy, RGB
        i := 1
        Loop, %MAX_TARGET%
        {
            if (OutputVar == hexToIndex%i%)
            {
                if (i <= MAX_KEY)
                {   
                    str := keyPress%i%
                    SendInput %str%
                }  
                else
                {   
                    if (botOn != "true")
                    {
                        str := "focus target{Enter}"
                        Send /
                        Sleep, 75
                        SendInput %str%
                        Sleep, 75
                    }
                    
                    str := targetToString%i%
                    Send /
                    Sleep, 75
                    SendInput %str%
                }
                    
                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; MA Frame
        ;
        PixelGetColor, OutputVar, bBx, bBy, RGB
        i := 1
        Loop, %MAX_KEY%
        {
            if (OutputVar == hexToIndex%i%)
            {
                str := keyPress%i%
                SendInput %str%
                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; PA Frame
        ;
        PixelGetColor, OutputVar, bCx, bCy, RGB
        i := 1
        Loop, %MAX_KEY%
        {
            if (OutputVar == hexToIndex%i%)
            {
                str := keyPress%i%
                SendInput %str%
                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; MP Frame
        ;
        PixelGetColor, OutputVar, bDx, bDy, RGB
        i := 1
        Loop, %MAX_KEY%
        {
            if (OutputVar == hexToIndex%i%)
            {
                str := keyPress%i%
                SendInput %str%
                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }

        ;
        ; PPT Frame
        ;
        PixelGetColor, OutputVar, bEx, bEy, RGB
        i := 1
        Loop, %MAX_TARGET%
        {
            if (OutputVar == hexToIndex%i%)
            {
                if (i <= MAX_KEY)
                {
                    str := keyPress%i%
                    SendInput %str%
                }
                else
                {
                    if (botOn != "true")
                    {
                        str := targetToString%i%
                        Send /
                        Sleep, 75
                        SendInput %str%
                    }
                }
                  
                Sleep, 75
                needClear := "true"
                Break
            }

            i += 1
        }
    }
}

Return
