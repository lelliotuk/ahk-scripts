STRENGTH := 30            ; Higher = longer scrolling
SENSITIVITY := 200        ; Time sensitivity (time between scrolls affects strength; lower will require faster finger)
SENSITIVITY_EXP := 5      ; Value to make it feel more natural
DECAY := 1                ; Decay per scroll

#MaxThreadsPerHotkey 1

infScroll := 0
momentum := 0
lastTick := 0

*XButton2::
    infScroll := 1
    while (GetKeyState("XButton2", "P"))
    {
        if (momentum < 0) {
            Send, {WheelUp}
            momentum := Min(0, momentum + DECAY)
        } else if (momentum > 0) {
            Send, {WheelDown}
            momentum := Max(0, momentum - DECAY)
        }
        Sleep, 10 + 80 - Max(Min(40, Abs(momentum)), 0)*2
    }
    momentum := 0
    infScroll := 0
    return


#If infScroll
    *WheelDown::
        momentum += 1 + STRENGTH * ((SENSITIVITY - Max(Min(SENSITIVITY, A_TickCount - lastTick), 0)) / SENSITIVITY) ** SENSITIVITY_EXP
        lastTick := A_TickCount
        return

    *WheelUp::
        momentum -= 1 + STRENGTH * ((SENSITIVITY - Max(Min(SENSITIVITY, A_TickCount - lastTick), 0)) / SENSITIVITY) ** SENSITIVITY_EXP
        lastTick := A_TickCount
        return
    #If

