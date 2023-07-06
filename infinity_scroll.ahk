STRENGTH := 10
DECAY := 1

#MaxThreadsPerHotkey 1

infScroll := 0
momentum := 0


*XButton2::
    infScroll := 1
    while (GetKeyState("XButton2", "P"))
    {
        if (momentum < 0) {
            Send, {WheelUp}
            momentum += DECAY
        } else if (momentum > 0) {
            Send, {WheelDown}
            momentum -= DECAY
        }
        Sleep, 20 + 70 - Max(Min(35, Abs(momentum)), 0)*2
    }
    momentum := 0
    infScroll := 0
return


#If infScroll
    *WheelDown::
        momentum += STRENGTH
    return

    *WheelUp::
        momentum -= STRENGTH
    return
#If

