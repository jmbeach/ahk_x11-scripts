; Win + Shift + H moves window to left half of screen
#+H::
    WinGetTitle, activeTitle, A
    marginX = 10
    marginY = 45
    newWidth = %A_ScreenWidth%
    newWidth /= 2
    newWidth -= %marginX%
    newHeight = %A_ScreenHeight%
    ; Subtract marginY twice (once for top and bottom)
    newHeight -= %marginY%
    newHeight -= %marginY%

    WinMove, %activeTitle%,, %marginX%, %marginY%, %newWidth%, %newHeight%
return

; Win + Shift + L moves window to right half of screen
#+L::
    WinGetTitle, activeTitle, A
    marginX = 10
    marginY = 45
    newX = %A_ScreenWidth%
    newX /= 2
    newWidth = %A_ScreenWidth%
    newWidth /= 2
    newWidth -= %marginX%
    newHeight = %A_ScreenHeight%
    ; Subtract marginY twice (once for top and bottom)
    newHeight -= %marginY%
    newHeight -= %marginY%

    WinMove, %activeTitle%,, %newX%, %marginY%, %newWidth%, %newHeight%
    WinMove, %activeTitle%,, %newX%, %marginY%, %newWidth%, %newHeight%
return


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

; Win + U Moves current window to upper 68% of the screen with 10px margin
#U::
    WinGetTitle, activeTitle, A
    marginX = 10
    marginYTop = 45
    newWidth = %A_ScreenWidth%
    ; Subtract marginX twice (once for left and right)
    newWidth -= %marginX%
    newWidth -= %marginX%
    newHeight = %A_ScreenHeight%
    ; 11 / 16 is roughly .68
    newHeight *= 11
    newHeight /= 16
    newHeight -= %marginYTop%

    WinMove, %activeTitle%,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
return

; Win + B Moves current window to bottom 32% of the screen with 10px margin
#B::
    WinGetTitle, activeTitle, A
    marginX = 10
    marginYBottom = 10
    marginYTop = %A_ScreenHeight%
    ; 11 / 16 is roughly .68
    marginYTop *= 11
    marginYTop /= 16

    newWidth = %A_ScreenWidth%
    ; Subtract marginX twice (once for left and right)
    newWidth -= %marginX%
    newWidth -= %marginX%
    newHeight = %A_ScreenHeight%
    newHeight -= %marginYTop%
    newHeight -= %marginYBottom%
    WinMove, %activeTitle%,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
    WinMove, %activeTitle%,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
return
