#SingleInstance Force
defaultPadding := 10
defaultAnimationSpeed := 10
defaultSnapResizeAmount := 20
defaultWindowTransparency := 255
defaultSnapThreshold := 15
defaultMaximizedPadding := 5
defaultAutoMaximizeOnOpen := 0

WindowTags := Map()

; Config file path
configFile := A_ScriptDir "\styrene.ini"

if FileExist(configFile)
{
    padding := IniRead(configFile, "Settings", "Padding", 10)
    animationSpeed := IniRead(configFile, "Settings", "AnimationSpeed", 10)
    snapResizeAmount := IniRead(configFile, "Settings", "SnapResizeAmount", 20)
    windowTransparency := IniRead(configFile, "Settings", "WindowTransparency", 255)
    snapThreshold := IniRead(configFile, "Settings", "SnapThreshold", 15)
    maximizedPadding := IniRead(configFile, "Settings", "MaximizedPadding", 5)
    autoMaximizeOnOpen := IniRead(configFile, "Settings", "AutoMaximizeOnOpen", 0)
}
else
{
    FileAppend(
    (
    "[Settings]
    Padding=5
    AnimationSpeed=10
    SnapResizeAmount=20
    WindowTransparency=255
    SnapThreshold=15
    MaximizedPadding=5
    AutoMaximizeOnOpen=0"
    ), configFile)
}

MoveWindow(x := "", y := "", w := "", h := "") {
    global padding
    WinGetPos(&winX, &winY, &winW, &winH, "A")
    if (x = "")
        x := winX
    if (y = "")
        y := winY
    if (w = "")
        w := winW
    if (h = "")
        h := winH
    WinMove(x + padding, y + padding, w - (padding * 2), h - (padding * 2), "A")
}

ResizeWindow(dw := 0, dh := 0) {
    WinGetPos(&x, &y, &w, &h, "A")
    w += dw
    h += dh
    WinMove(x, y, w, h, "A")
}

screenWidth := A_ScreenWidth
screenHeight := A_ScreenHeight

#Left::MoveWindow(0, 0, screenWidth // 2, screenHeight)
#Right::MoveWindow(screenWidth // 2, 0, screenWidth // 2, screenHeight)
#Up::MoveWindow(0, 0, screenWidth, screenHeight // 2)
#Down::MoveWindow(0, screenHeight // 2, screenWidth, screenHeight // 2)

#^Left::ResizeWindow(-20, 0)
#^Right::ResizeWindow(20, 0)
#^Up::ResizeWindow(0, -20)
#^Down::ResizeWindow(0, 20)

#m::
{
    global
    winState := WinGetMinMax("A")
    if (winState = 1)
        WinRestore("A")
    else
        WinMaximize("A")
    return
}

#HotIf
#z::
{
    global
    currentWin := WinGetID("A")
    if (LastWindow && LastWindow != currentWin)
        WinActivate("ahk_id " LastWindow)
    LastWindow := currentWin
    return
}
#HotIf

#!0::TagWindow(0)
#!1::TagWindow(1)
#!2::TagWindow(2)
#!3::TagWindow(3)
#!4::TagWindow(4)
#!5::TagWindow(5)
#!6::TagWindow(6)
#!7::TagWindow(7)
#!8::TagWindow(8)
#!9::TagWindow(9)

#^0::ActivateTaggedWindow(0)
#^1::ActivateTaggedWindow(1)
#^2::ActivateTaggedWindow(2)
#^3::ActivateTaggedWindow(3)
#^4::ActivateTaggedWindow(4)
#^5::ActivateTaggedWindow(5)
#^6::ActivateTaggedWindow(6)
#^7::ActivateTaggedWindow(7)
#^8::ActivateTaggedWindow(8)
#^9::ActivateTaggedWindow(9)

TagWindow(index) {
    global WindowTags
    id := WinGetID("A")
    if (WindowTags.Has(index)) {
        hwnd := WindowTags[index]
        oldTitle := WinGetTitle("ahk_id " hwnd)
        msgResult := MsgBox("Already tagged: `"" oldTitle "`"`nReplace it?", "Slot " index " Occupied", 4)
        if (msgResult = "No")
            return
    }
    WindowTags[index] := id
    title := WinGetTitle("ahk_id " id)
    ToolTip("Tagged [" index "]: " title)
    SetTimer(RemoveToolTip,-1000)
}

ActivateTaggedWindow(index) {
    global WindowTags
    if (!WindowTags.Has(index)) {
        TrayTip("Slot Empty", "No window is tagged to [" index "]")
        return
    }
    hwnd := WindowTags[index]
    if !WinExist("ahk_id " . hwnd) {
        TrayTip("Invalid HWND", "Tagged window no longer exists. Clearing slot.")
        WindowTags.Delete(index)
        return
    }
    title := WinGetTitle("ahk_id " hwnd)
    TrayTip("Switching", "[" index "] 	 `"" title "`"")
    WinActivate("ahk_id " hwnd)
}

RemoveToolTip() {
    global
    ToolTip()
    return
}

#p::
{
    global
    style := WinGetExStyle("A")
    if (style & 0x8)
        WinSetAlwaysOnTop(0, "A")
    else
        WinSetAlwaysOnTop(1, "A")
    return
}

GetActiveMonitorWorkArea(&x, &y, &w, &h) {
    hwnd := WinExist("A")
    MonitorGetWorkArea(hwnd, &monitorLeft, &monitorTop, &monitorRight, &monitorBottom)
    x := monitorLeft
    y := monitorTop
    w := monitorRight - monitorLeft
    h := monitorBottom - monitorTop
}

#q::
{
    global
    activeTitle := WinGetTitle("A")
    msgResult := MsgBox("Are you sure you want to close this window?`n" activeTitle, , 4)
    if (msgResult = "Yes")
        WinClose("A")
    return
}

#s::Reload()
