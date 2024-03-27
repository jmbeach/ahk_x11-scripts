; Win + Shift + U Maximizes current window with 10px margin
#+U::
    WinGetTitle, activeTitle, A
    marginX = 10
    marginY = 45
    newWidth = %A_ScreenWidth%
    ; Subtract marginX twice (once for left and right)
    newWidth -= %marginX%
    newWidth -= %marginX%
    newHeight = %A_ScreenHeight%
    ; Subtract marginY twice (once for top and bottom)
    newHeight -= %marginY%
    newHeight -= %marginY%

    WinMove, %activeTitle%,, %marginX%, %marginY%, %newWidth%, %newHeight%
return
