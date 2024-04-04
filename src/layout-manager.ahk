#DefineCommand doesActiveWindowGetAdjustment, lblDoesActiveWindowGetAdjustment
lblDoesActiveWindowGetAdjustment:
windowsToAdjust = Brave-browser
WinGetClass, activeClass, A
if activeClass in %windowsToAdjust%
{
    %A_Param1% = true
}
else
{
    %A_Param1% = false
}
Return

;(adjustWidthAmount, adjustHeightAmount, &adjustmentWidth, &adjustmentHeight)
;(A_Param2         , A_Param3          , A_Param4        , A_Param5)
#DefineCommand getWidthHeightAdjustmentFactor, lblGetWidthHeightAdjustmentFactor
lblGetWidthHeightAdjustmentFactor:
doesActiveWindowGetAdjustment, needsAdjustment
if needsAdjustment = true
{
    %A_Param4% = %A_Param2%
    %A_Param5% = %A_Param3%
}
else
{
    %A_Param4% = 0
    %A_Param5% = 0
}
Return

;(adjustXAmount, adjustYAmount, &adjustmentX, &adjustmentY)
;(A_Param2     , A_Param3     , A_Param4    , A_Param5)
#DefineCommand getXYAdjustmentFactor, lblGetXYAdjustmentFactor
lblGetXYAdjustmentFactor:
doesActiveWindowGetAdjustment, needsAdjustment
if needsAdjustment = true
{
    %A_Param4% = %A_Param2%
    %A_Param5% = %A_Param3%
}
else
{
    %A_Param4% = 0
    %A_Param5% = 0
}
Return

; Win + Shift + H moves window to left half of screen
#+H::
    getWidthHeightAdjustmentFactor,, 20, 60, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, 20, 15, adjustmentX, adjustmentY
    marginX = 10
    marginX -= %adjustmentX%
    marginY = 45
    marginY -= %adjustmentY%
    newWidth = %A_ScreenWidth%
    newWidth /= 2
    newWidth -= %marginX%
    newWidth += %adjustmentWidth%
    newHeight = %A_ScreenHeight%
    ; Subtract marginY twice (once for top and bottom)
    newHeight -= %marginY%
    newHeight -= %marginY%
    newHeight += %adjustmentHeight%

    WinMove, A,, %marginX%, %marginY%, %newWidth%, %newHeight%
return

; Win + Shift + L moves window to right half of screen
#+L::
    getWidthHeightAdjustmentFactor,, 20, 60, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, 20, 15, adjustmentX, adjustmentY
    marginX = 10
    marginX -= %adjustmentX%
    marginY = 45
    marginY -= %adjustmentY%
    newX = %A_ScreenWidth%
    newX /= 2
    newX += %marginX%
    newWidth = %A_ScreenWidth%
    newWidth /= 2
    newWidth -= %marginX%
    newWidth -= %marginX%
    newWidth += %adjustmentWidth%
    newHeight = %A_ScreenHeight%
    ; Subtract marginY twice (once for top and bottom)
    newHeight -= %marginY%
    newHeight -= %marginY%
    newHeight += %adjustmentHeight%

    WinMove, A,, %newX%, %marginY%, %newWidth%, %newHeight%
    WinMove, A,, %newX%, %marginY%, %newWidth%, %newHeight%
return


; Win + Shift + U Maximizes current window with 10px margin
#+U::
    getWidthHeightAdjustmentFactor,, 20, 60, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, 20, 15, adjustmentX, adjustmentY
    marginX = 10
    marginX -= %adjustmentX%
    marginY = 45
    marginY -= %adjustmentY%
    newWidth = %A_ScreenWidth%
    ; Subtract marginX twice (once for left and right)
    newWidth -= %marginX%
    newWidth -= %marginX%
    newWidth += %adjustmentWidth%
    newHeight = %A_ScreenHeight%
    ; Subtract marginY twice (once for top and bottom)
    newHeight -= %marginY%
    newHeight -= %marginY%
    newHeight += %adjustmentHeight%

    WinMove, A,, %marginX%, %marginY%, %newWidth%, %newHeight%
return

; Win + U Moves current window to upper 68% of the screen with 10px margin
#U::
    getWidthHeightAdjustmentFactor,, 20, 60, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, 20, 15, adjustmentX, adjustmentY
    marginX = 10
    marginX -= %adjustmentX%
    marginYTop = 45
    marginYTop -= %adjustmentY%
    newWidth = %A_ScreenWidth%
    ; Subtract marginX twice (once for left and right)
    newWidth -= %marginX%
    newWidth -= %marginX%
    newWidth += %adjustmentWidth%
    newHeight = %A_ScreenHeight%
    ; 11 / 16 is roughly .68
    newHeight *= 11
    newHeight /= 16
    newHeight -= %marginYTop%
    newHeight += %adjustmentHeight%

    WinMove, A,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
return

; Win + B Moves current window to bottom 32% of the screen with 10px margin
#B::
    marginX = 10
    marginYBottom = 45
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
    WinMove, A,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
    WinMove, A,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
return


