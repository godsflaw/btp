#Requires AutoHotkey v2.0


; Change the following to "false" if you expect to use this code in
; non-robot conditions.  For instance, if you were using the warlock
; code you would want this to be false.  
; 
botOn          := false

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
btpBotKey    := "{end}"

; You may also want to find the point that is as far to the lower left as
; you can; however, this is not normaly important.  You can just use your
; screen res for this.
;
; defaults (updated for UHD)
;
maxX  := 4096
maxY  := 2048
;
; Sleep 5000
; MouseGetPos &xpos, &ypos
; MsgBox "The cursor is at X" xpos " Y" ypos
;
centerX := 3845
centerY := 1080

;
;
;
debug     := false
debugFile := "D:\debug.txt"

;
; There should be no reason to change anything below this line unless you
; are told to or know what your doing.
;

F9::
{
    global botOn
    if (botOn) {
        botOn := false
    } else {
        botOn := true
    }
}

r            := 0
g            := 0
b            := 0
index        := 0
moveDown     := "x"
moveDownUp   := "{x Up}"
moveDownDown := "{x Down}"

hex := Map()
hex[index] := "00"
index += 1
hex[index] := "11"
index += 1
hex[index] := "22"
index += 1
hex[index] := "33"
index += 1
hex[index] := "44"
index += 1
hex[index] := "55"
index += 1
hex[index] := "66"
index += 1
hex[index] := "77"
index += 1
hex[index] := "88"
index += 1
hex[index] := "99"
index += 1
hex[index] := "AA"
index += 1
hex[index] := "BB"
index += 1
hex[index] := "CC"
index += 1
hex[index] := "DD"
index += 1
hex[index] := "EE"
index += 1
hex[index] := "FF"

letters := Map()
index := 1
letters[index] := "a"
index += 1
letters[index] := "b"
index += 1
letters[index] := "c"
index += 1
letters[index] := "d"
index += 1
letters[index] := "e"
index += 1
letters[index] := "f"
index += 1
letters[index] := "g"
index += 1
letters[index] := "h"
index += 1
letters[index] := "i"
index += 1
letters[index] := "j"
index += 1
letters[index] := "k"
index += 1
letters[index] := "l"
index += 1
letters[index] := "m"
index += 1
letters[index] := "n"
index += 1
letters[index] := "o"
index += 1
letters[index] := "p"
index += 1
letters[index] := "q"
index += 1
letters[index] := "r"
index += 1
letters[index] := "s"
index += 1
letters[index] := "t"
index += 1
letters[index] := "u"
index += 1
letters[index] := "v"
index += 1
letters[index] := "w"
index += 1
letters[index] := "x"
index += 1
letters[index] := "y"
index += 1
letters[index] := "z"
index += 1
letters[index] := "``"
index += 1
letters[index] := "-"
index += 1
letters[index] := "="
index += 1
letters[index] := "["
index += 1
letters[index] := "]"
index += 1
letters[index] := ";"
index += 1
letters[index] := "'"
index += 1
letters[index] := "," 
index += 1
letters[index] := "."
index += 1
letters[index] := "/"
index += 1
letters[index] := "1"
index += 1
letters[index] := "2"
index += 1
letters[index] := "3"
index += 1
letters[index] := "4"
index += 1
letters[index] := "5"
index += 1
letters[index] := "6"
index += 1
letters[index] := "7"
index += 1
letters[index] := "8"
index += 1
letters[index] := "9"
index += 1

hexToIndex := Map()
index := 0
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

    hexToIndex[index] := "0x" . hex[r] . hex[g] . hex[b]

    if (debug) {
        tmp := hexToIndex[index]
        FileAppend ( index " = " tmp "`n" ), "D:\debug.txt"
    }

    b += 1
    index += 1
}

keyPress := Map()
state := 1
i     := 1
index := 1
keyPress[index] := "{Ctrl Down}1{Ctrl Up}"
index += 1
i     += 1
keyPress[index] := "{Up Down}{Space}{Up Up}"
index += 1
i     += 1
keyPress[index] := "{Down Down}{Space}{Down Up}"
index += 1
i     += 1
keyPress[index] := "{Left}"
index += 1
i     += 1
keyPress[index] := "{Right}"
index += 1
i     += 1
keyPress[index] := "{Space}"
index += 1
i     += 1
keyPress[index] := moveDown
index += 1
i     += 1
keyPress[index] := "t"
index += 1
i     += 1

Loop
{
    if (state == 1)
    {
        keyPress[index] := "{Ctrl Down}" . letters[i] . "{Ctrl Up}"
    }
    else if (state == 2)
    {
        keyPress[index] := "{Ctrl Down}{Shift Down}" . letters[i] . "{Shift Up}{Ctrl Up}"
    }
    else if (state == 3)
    {
        keyPress[index] := "{Alt Down}" . letters[i] . "{Alt Up}"
    }
    else if (state == 4)
    {
        keyPress[index] := "{Alt Down}{Shift Down}" . letters[i] . "{Shift Up}{Alt Up}"
    }
    else if (state == 5)
    {
        keyPress[index] := "{Alt Down}{Ctrl Down}" . letters[i] . "{Ctrl Up}{Alt Up}"
    }
    else if (state == 6)
    {
        keyPress[index] := "{Alt Down}{Ctrl Down}{Shift Down}" . letters[i] . "{Shift Up}{Ctrl Up}{Alt Up}"
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

targetToString := Map()
i     := 1
index := MAX_KEY + 1
targetToString[index] := "/target player{Enter}"
index += 1
targetToString[index] := "/target focus{Enter}"
index += 1
targetToString[index] := "/target pet{Enter}"
index += 1
targetToString[index] := "/target pettarget{Enter}"
index += 1
targetToString[index] := "/targetfriend{Enter}"
index += 1
targetToString[index] := "/targetenemy{Enter}"
index += 1
targetToString[index] := "/target targettarget{Enter}"
index += 1

Loop 40
{
    targetToString[index] := "/target raid" . i . "{Enter}"
    index += 1
    targetToString[index] := "/target raid" . i . "target{Enter}"
    index += 1
    targetToString[index] := "/target raidpet" . i . "{Enter}"
    index += 1
    targetToString[index] := "/target raidpet" . i . "target{Enter}"
    index += 1

    if (i < 5)
    {
        targetToString[index] := "/target party" . i . "{Enter}"
        index += 1
        targetToString[index] := "/target party" . i . "target{Enter}"
        index += 1
        targetToString[index] := "/target partypet" . i . "{Enter}"
        index += 1
        targetToString[index] := "/target partypet" . i . "target{Enter}"
        index += 1
    }

    i += 1
}

MAX_TARGET := index
Sleep 5000

; get the target window
target := WinGetTitle("A")

if (debug) {
    FileAppend ( "target: " target "`n" ), "D:\debug.txt"
}

SetKeyDelay 20

;
; frame detection loop
;
b1 := false
b2 := false
b3 := false
b4 := false
b5 := false
b6 := false
b7 := false
b8 := false
b9 := false
bA := false
bB := false
bC := false
bD := false
bE := false
finit_cnt := 1
Loop
{
    xbox := 10
    ybox := 5
    ControlSend "/btp{Shift down}_{Shift up}finit`n", , target
    Loop
    {
        if (debug) {
            FileAppend ( "Start Frame Sweep: " xbox ", " ybox ), "D:\debug.txt"
        }

        Loop
        {
            OutputVar := PixelGetColor(xbox, ybox)
            if (debug) {
                FileAppend ( "PixelGetColor: " OutputVar "`n" ), "D:\debug.txt"
            }
            if(not b1 and OutputVar == "0x000011")
            {
                b1x := xbox
                b1y := ybox
                b1  := true
            }
            else if(not b2 and OutputVar == "0x000022")
            {
                b2x := xbox
                b2y := ybox
                b2  := true
            }
            else if(not b3 and OutputVar == "0x000033")
            {
                b3x := xbox
                b3y := ybox
                b3  := true
            }
            else if(not b4 and OutputVar == "0x000044")
            {
                b4x := xbox
                b4y := ybox
                b4  := true
            }
            else if(not b5 and OutputVar == "0x000055")
            {
                b5x := xbox
                b5y := ybox
                b5  := true
            }
            else if(not b6 and OutputVar == "0x000066")
            {
                b6x := xbox
                b6y := ybox
                b6  := true
            }
            else if(not b7 and OutputVar == "0x000077")
            {
                b7x := xbox
                b7y := ybox
                b7  := true
            }
            else if(not b8 and OutputVar == "0x000088")
            {
                b8x := xbox
                b8y := ybox
                b8  := true
            }
            else if(not b9 and OutputVar == "0x000099")
            {
                b9x := xbox
                b9y := ybox
                b9  := true
            }
            else if(not bA and OutputVar == "0x0000AA")
            {
                bAx := xbox
                bAy := ybox
                bA  := true
            }
            else if(not bB and OutputVar == "0x0000BB")
            {
                bBx := xbox
                bBy := ybox
                bB  := true
            }
            else if(not bC and OutputVar == "0x0000CC")
            {
                bCx := xbox
                bCy := ybox
                bC  := true
            }
            else if(not bD and OutputVar == "0x0000DD")
            {
                bDx := xbox
                bDy := ybox
                bD  := true
            }
            else if(not bE and OutputVar == "0x0000EE")
            {
                bEx := xbox
                bEy := ybox
                bE  := true
            }

            xbox += 5
            if(xbox > 4096)
            {
                break
            }
    
            if(b1 and b2 and b3 and b4 and b5 and b6 and b7 and b8 and b9 and bA and bB and bC and bD and bE)
            {
                ControlSend clearKey, , target
                ybox := 2048
                break
            }
        }

        ybox += 5

        if(ybox > 2048)
        {
            break
        }

        xbox := 5
    }

    if(b1 and b2 and b3 and b4 and b5 and b6 and b7 and b8 and b9 and bA and bB and bC and bD and bE)
    {
        ControlSend clearKey, , target
        break
    }
    else
    {
        ControlSend "/btp{Shift down}_{Shift up}dbg Could not find frame command boxes trying again`n", , target
        Sleep 5000
        if(finit_cnt > 2)
        {
            MsgBox "Error: Could not configure your output boxes! WILL NOT WORK! AHK EXITING!"
            ExitApp 1
        }
        finit_cnt += 1
    }
}

SetKeyDelay 0

;
; run loop
;
needClear := false
fpause    := false
Loop
{
    if(not fpause and botOn)
    {
        ControlSend btpBotKey, , target
        Sleep 250
    }

    if (needClear and not fpause)
    {
        needClear := false
        ControlSend clearKey, , target
    }

    ;
    ; IT Frame
    ;
    OutputVar := PixelGetColor(b1x, b1y)

    if (OutputVar == "0x121212")
    {
        ControlSend "/btp{Shift down}_{Shift up}dbg stopping keys`n", , target
        Sleep 1000
        ControlSend clearKey, , target
        ExitApp 0
    }

    if (fpause)
    {
        if(OutputVar == "0x000000")
        {
            fpause := false
            ControlSend "/btp{Shift down}_{Shift up}dbg GO`n", , target
            needClear := false
            ControlSend clearKey, , target
        }

        Sleep 2000
        Continue
    }

    if (OutputVar == "0x984343")
    {
        ControlSend "/btp{Shift down}_{Shift up}dbg PAUSE`n", , target
        fpause := true 
        Sleep 1000
        Continue
    }

    if (OutputVar != "0xFFFFFF")
    {
        ; nothing to do yet
        Sleep 50
        Continue
    }

    ;
    ; we have input to process
    ;

    ;
    ; IA Frame
    ;
    OutputVar := PixelGetColor(b2x, b2y)
    i := 1
    Loop MAX_KEY
    {
        if (OutputVar == hexToIndex[i])
        {
            if (i == 2)
            {
                ControlSend "{Up Down}", , target
                Sleep 1000
                ControlSend "{Up Up}", , target
            }
            else if (i == 3)
            {
                ControlSend "{Down Down}", , target
                Sleep 1000
                ControlSend "{Down Up}", , target
            }
            else if (i == 4)
            {
                ControlSend "{Left Down}", , target
                Sleep 50
                ControlSend "{Left Up}", , target
            }
            else if (i == 5)
            {
                ControlSend "{Right Down}", , target
                Sleep 50
                ControlSend "{Right Up}", , target
            }
            else if (i == 8)
            {
                ControlClick "x" centerX " y" centerY, target, "Right"
                Sleep 10000
            }
            else
            {
                ControlSend keyPress[i], , target
            }

            needClear := true
            Break
        }
        else if (OutputVar == "0x101010")
        {
            ;
            ; Move Forward
            ;
            ControlSend "{Down Up}", , target
            ControlSend "{Space Up}", , target
            ControlSend moveDownUp, , target
            ControlSend "{Down Down}", , target
            needClear := true
            Break
        }
        else if (OutputVar == "0x202020")
        {
            ;
            ; Move Back
            ;
            ControlSend "{Up Up}", , target
            ControlSend "{Space Up}", , target
            ControlSend moveDownUp, , target
            ControlSend "{Down Down}", , target
            needClear := true
            Break
        }
        else if (OutputVar == "0x303030")
        {
            ;
            ; Turn Left
            ;
            ControlSend "{Up Up}", , target
            ControlSend "{Down Up}", , target
            ControlSend "{Space Up}", , target
            ControlSend moveDownUp, , target
            ControlSend "{Left Down}", , target
            Sleep 50
            ControlSend "{Left Up}", , target
            needClear := true
            Break
        }
        else if (OutputVar == "0x404040")
        {
            ;
            ; Turn Right
            ;
            ControlSend "{Up Up}", , target
            ControlSend "{Down Up}", , target
            ControlSend "{Space Up}", , target
            ControlSend moveDownUp, , target
            ControlSend "{Right Down}", , target
            Sleep 50
            ControlSend "{Right Up}", , target
            needClear := true
            Break
        }
        else if (OutputVar == "0x505050")
        {
            ;
            ; Jump / Fly Up
            ;
            ControlSend "{Up Up}", , target
            ControlSend "{Down Up}", , target
            ControlSend "{Space Up}", , target
            ControlSend moveDownUp, , target
            ControlSend "{Space Down}", , target
            Sleep 250
            needClear := true
            Break
        }
        else if (OutputVar == "0x606060")
        {
            ;
            ; Swim / Fly Down
            ;
            ControlSend "{Up Up}", , target
            ControlSend "{Down Up}", , target
            ControlSend "{Space Up}", , target
            ControlSend moveDownDown, , target
            needClear := true
            Break
        }
        else if (OutputVar == "0x909090")
        {
            ;
            ; Stop Moving / Do Nothing
            ;
            ControlSend "{Up Up}", , target
            ControlSend "{Down Up}", , target
            ControlSend "{Space Up}", , target
            ControlSend moveDownUp, , target
            needClear := true
            Break
        }
        
        i += 1
    }

    ;
    ; IPT Frame
    ;
    OutputVar := PixelGetColor(b3x, b3y)
    i := 1
    Loop MAX_TARGET
    {
        if (OutputVar == hexToIndex[i])
        {
            if (i <= MAX_KEY)
            {
                ControlSend keyPress[i], , target
            }
            else
            {
                if (not botOn)
                {
                    ControlSend targetToString[i], , target
                }
            }

            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; CT Frame
    ;
    OutputVar := PixelGetColor(b4x, b4y)
    i := 1
    Loop MAX_TARGET
    {
        if (OutputVar == hexToIndex[i])
        {
            if (i <= MAX_KEY)
            {
                ControlSend keyPress[i], , target
            }
            else
            {
                if (not botOn)
                {
                    ControlSend "/focus target`n", , target
                }

                ControlSend targetToString[i], , target
            }

            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; CA Frame
    ;
    OutputVar := PixelGetColor(b5x, b5y)
    i := 1
    Loop MAX_KEY
    {
        if (OutputVar == hexToIndex[i])
        {
            ControlSend keyPress[i], , target
            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; CPT Frame
    ;
    OutputVar := PixelGetColor(b6x, b6y)
    i := 1
    Loop MAX_TARGET
    {
        if (OutputVar == hexToIndex[i])
        {
            if (i <= MAX_KEY)
            {
                ControlSend keyPress[i], , target
            }
            else
            {
                if (not botOn)
                {
                    ControlSend targetToString[i], , target
                }
            }
              
            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; AT Frame
    ;
    OutputVar := PixelGetColor(b7x, b7y)
    i := 1
    Loop MAX_TARGET
    {
        if (OutputVar == hexToIndex[i])
        {
            if (i <= MAX_KEY)
            {
                ControlSend keyPress[i], , target
            }
            else
            {
                if (not botOn)
                {
                    ControlSend "/focus target`n", , target
                }

                ControlSend targetToString[i], , target
            }

            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; AA Frame
    ;
    OutputVar := PixelGetColor(b8x, b8y)
    i := 1
    Loop MAX_KEY
    {
        if (OutputVar == hexToIndex[i])
        {
            ControlSend keyPress[i], , target
            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; APT Frame
    ;
    OutputVar := PixelGetColor(b9x, b9y)
    i := 1
    Loop MAX_TARGET
    {
        if (OutputVar == hexToIndex[i])
        {
            if (i <= MAX_KEY)
            {
                ControlSend keyPress[i], , target
            }
            else
            {
                if (not botOn)
                {
                    ControlSend targetToString[i], , target
                }
            }
              
            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; PT Frame
    ;
    OutputVar := PixelGetColor(bAx, bAy)
    i := 1
    Loop MAX_TARGET
    {
        if (OutputVar == hexToIndex[i])
        {
            if (i <= MAX_KEY)
            {   
                ControlSend keyPress[i], , target
            }  
            else
            {   
                if (not botOn)
                {
                    ControlSend "/focus target`n", , target
                }
                
                ControlSend targetToString[i], , target
            }
                
            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; MA Frame
    ;
    OutputVar := PixelGetColor(bBx, bBy)
    i := 1
    Loop MAX_KEY
    {
        if (OutputVar == hexToIndex[i])
        {
            ControlSend keyPress[i], , target
            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; PA Frame
    ;
    OutputVar := PixelGetColor(bCx, bCy)
    i := 1
    Loop MAX_KEY
    {
        if (OutputVar == hexToIndex[i])
        {
            ControlSend keyPress[i], , target
            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; MP Frame
    ;
    OutputVar := PixelGetColor(bDx, bDy)
    i := 1
    Loop MAX_KEY
    {
        if (OutputVar == hexToIndex[i])
        {
            ControlSend keyPress[i], , target
            needClear := true
            Break
        }

        i += 1
    }

    ;
    ; PPT Frame
    ;
    OutputVar := PixelGetColor(bEx, bEy)
    i := 1
    Loop MAX_TARGET
    {
        if (OutputVar == hexToIndex[i])
        {
            if (i <= MAX_KEY)
            {
                ControlSend keyPress[i], , target
            }
            else
            {
                if (not botOn)
                {
                    ControlSend targetToString[i], , target
                }
            }
              
            needClear := true
            Break
        }

        i += 1
    }
}