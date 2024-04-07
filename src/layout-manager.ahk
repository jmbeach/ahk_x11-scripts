; Constants
MARGIN_X = 13
MARGIN_Y_TOP = 40
MARGIN_Y_BOTTOM = 50
WIDTH_ADJUSTMENT = 2
WIDTH_ADJUSTMENT_HALF_SCREEN = 28
HEIGHT_ADJUSTMENT = 70
X_ADJUSTMENT = -15
Y_ADJUSTMENT = -10

#DefineCommand doesActiveWindowGetAdjustment, lblDoesActiveWindowGetAdjustment
lblDoesActiveWindowGetAdjustment:
; Interestingly, Brave started acting normal when I turned on "Use system title bar and borders"
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
    getWidthHeightAdjustmentFactor,, %WIDTH_ADJUSTMENT_HALF_SCREEN%, %HEIGHT_ADJUSTMENT%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %X_ADJUSTMENT%, %Y_ADJUSTMENT%, adjustmentX, adjustmentY
    halfMarginX = %MARGIN_X%
    halfMarginX /= 2
    marginX = %MARGIN_X%
    marginYTop = %MARGIN_Y_TOP%
    marginYTop += %adjustmentY%
    newWidth = %A_ScreenWidth%
    newWidth /= 2
    newWidth -= %marginX%
    newWidth -= %halfMarginX%
    newWidth += %adjustmentWidth%
    newHeight = %A_ScreenHeight%
    newHeight -= %marginYTop%
    newHeight -= %MARGIN_Y_BOTTOM%
    newHeight += %adjustmentHeight%
    newX = %marginX%
    newX += %adjustmentX%

    WinMove, A,, %newX%, %marginYTop%, %newWidth%, %newHeight%
return

; Win + Shift + L moves window to right half of screen
#+L::
    getWidthHeightAdjustmentFactor,, %WIDTH_ADJUSTMENT_HALF_SCREEN%, %HEIGHT_ADJUSTMENT%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %X_ADJUSTMENT%, %Y_ADJUSTMENT%, adjustmentX, adjustmentY
    marginX = %MARGIN_X%
    halfMarginX = %MARGIN_X%
    halfMarginX /= 2
    marginYTop = %MARGIN_Y_TOP%
    marginYTop += %adjustmentY%
    newX = %A_ScreenWidth%
    newX /= 2
    newX += %halfMarginX%
    newX += %adjustmentX%
    newWidth = %A_ScreenWidth%
    newWidth /= 2
    newWidth -= %marginX%
    newWidth -= %halfMarginX%
    newWidth += %adjustmentWidth%
    newHeight = %A_ScreenHeight%
    newHeight -= %marginYTop%
    newHeight -= %MARGIN_Y_BOTTOM%
    newHeight += %adjustmentHeight%

    WinMove, A,, %newX%, %marginYTop%, %newWidth%, %newHeight%
    WinMove, A,, %newX%, %marginYTop%, %newWidth%, %newHeight%
return


; Win + Shift + U Maximizes current window with 10px margin
#+U::
    getWidthHeightAdjustmentFactor,, %WIDTH_ADJUSTMENT%, %HEIGHT_ADJUSTMENT%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %X_ADJUSTMENT%, %Y_ADJUSTMENT%, adjustmentX, adjustmentY
    marginX = %MARGIN_X%
    marginX += %adjustmentX%
    marginYTop = %MARGIN_Y_TOP%
    marginYTop += %adjustmentY%
    newWidth = %A_ScreenWidth%
    ; Subtract marginX twice (once for left and right)
    newWidth -= %marginX%
    newWidth -= %marginX%
    newWidth += %adjustmentWidth%
    newHeight = %A_ScreenHeight%
    newHeight -= %marginYTop%
    newHeight -= %MARGIN_Y_BOTTOM%
    newHeight += %adjustmentHeight%

    WinMove, A,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
Return

; Win + U Moves current window to upper 68% of the screen with 10px margin
#U::
    getWidthHeightAdjustmentFactor,, %WIDTH_ADJUSTMENT%, %HEIGHT_ADJUSTMENT%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %X_ADJUSTMENT%, %Y_ADJUSTMENT%, adjustmentX, adjustmentY
    marginX = %MARGIN_X%
    marginX += %adjustmentX%
    marginYTop = %MARGIN_Y_TOP%
    marginYTop += %adjustmentY%
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
    newHeight -= %MARGIN_Y_BOTTOM%
    newHeight += %adjustmentHeight%

    WinMove, A,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
return

; Win + B Moves current window to bottom 32% of the screen with 10px margin
#B::
    getWidthHeightAdjustmentFactor,, %WIDTH_ADJUSTMENT%, 75, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %X_ADJUSTMENT%, %Y_ADJUSTMENT%, adjustmentX, adjustmentY
    marginX = %MARGIN_X%
    marginX += %adjustmentX%
    marginYTop = %A_ScreenHeight%
    marginYTop += %adjustmentY%
    ; 11 / 16 is roughly .68
    marginYTop *= 11
    marginYTop /= 16

    newWidth = %A_ScreenWidth%
    ; Subtract marginX twice (once for left and right)
    newWidth -= %marginX%
    newWidth -= %marginX%
    newWidth += %adjustmentWidth%
    newHeight = %A_ScreenHeight%
    newHeight -= %marginYTop%
    newHeight -= %MARGIN_Y_BOTTOM%
    newHeight += %adjustmentHeight%
    WinMove, A,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
    WinMove, A,, %marginX%, %marginYTop%, %newWidth%, %newHeight%
return


