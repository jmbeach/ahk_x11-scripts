; These values configure the amount of gap to leave.
MARGIN_X = 13
; This value is so high because of the top bar in GNOME
MARGIN_Y_TOP = 40
; There's only a 10px-ish gap at the bottom.
; This had to be so high to compensate for how much top margin there is.
MARGIN_Y_BOTTOM = 50

WIDTH_ADJUSTMENT = 0
; These values configure adjustments made to specific windows that do not look right using the
; default settings. Brave browser is an example
; Comma-separated values of configs. Alacritty:0 means alacritty gets no adjustment for width
; Add a comma and your config (such as Terminal:50) to create your own custom adjustments
;
; I do this because Alacritty without the title bar decoration needs more height than
; normal, but everything else about it looks right.
WIDTH_ADJUSTMENT_CUSTOM = Brave-browser:5
; When sending the window to half the sreen left or right,
; need a different width adjustment
WIDTH_ADJUSTMENT_HALF_SCREEN = 28
WIDTH_ADJUSTMENT_HALF_SCREEN_CUSTOM = PLACEHOLDER:0
HEIGHT_ADJUSTMENT = 0
HEIGHT_ADJUSTMENT_CUSTOM = Brave-browser:70
; When sending the window to bottom portion of screen
; need a different height adjustment
HEIGHT_ADJUSTMENT_BOTTOM = 0
HEIGHT_ADJUSTMENT_BOTTOM_CUSTOM = Brave-browser:70
X_ADJUSTMENT = 0
X_ADJUSTMENT_CUSTOM = Brave-browser:-15
Y_ADJUSTMENT = 0
Y_ADJUSTMENT_CUSTOM = Brave-browser:-10

;(result  )
;(A_Param1)
#DefineCommand getXAdjustment, lblGetXAdjustment
lblGetXAdjustment:
%A_Param1% = %X_ADJUSTMENT%
WinGetClass, activeClass, A
StringSplit, xAdjustment, X_ADJUSTMENT_CUSTOM, `,
Loop, %xAdjustment0%
{
    StringTrimLeft, config, xAdjustment%a_index%, 0
    StringSplit, parts, config, :
    ; (index 0, index 1 , index 2)
    ; (length , app name, amount)
    if parts1 = %activeClass%
    {
        %A_Param1% = %parts2%
    }
}
Return

;(result  )
;(A_Param1)
#DefineCommand getYAdjustment, lblGetYAdjustment
lblGetYAdjustment:
%A_Param1% = %Y_ADJUSTMENT%
WinGetClass, activeClass, A
StringSplit, yAdjustment, Y_ADJUSTMENT_CUSTOM, `,
Loop, %yAdjustment0%
{
    StringTrimLeft, config, yAdjustment%a_index%, 0
    StringSplit, parts, config, :
    ; (index 0, index 1 , index 2)
    ; (length , app name, amount)
    if parts1 = %activeClass%
    {
        %A_Param1% = %parts2%
    }
}
Return

;(result  )
;(A_Param1)
#DefineCommand getHeightAdjustment, lblGetHeightAdjustment
lblGetHeightAdjustment:
%A_Param1% = %HEIGHT_ADJUSTMENT%
WinGetClass, activeClass, A
StringSplit, heightAdjustment, HEIGHT_ADJUSTMENT_CUSTOM, `,
Loop, %heightAdjustment0%
{
    StringTrimLeft, config, heightAdjustment%a_index%, 0
    StringSplit, parts, config, :
    ; (index 0, index 1 , index 2)
    ; (length , app name, amount)
    if parts1 = %activeClass%
    {
        %A_Param1% = %parts2%
    }
}
Return

;(result  )
;(A_Param1)
#DefineCommand getHeightAdjustmentBottom, lblGetHeightAdjustmentBottom
lblGetHeightAdjustmentBottom:
%A_Param1% = %HEIGHT_ADJUSTMENT_BOTTOM%
WinGetClass, activeClass, A
StringSplit, heightAdjustmentBottom, HEIGHT_ADJUSTMENT_BOTTOM_CUSTOM, `,
Loop, %heightAdjustmentBottom0%
{
    StringTrimLeft, config, heightAdjustmentBottom%a_index%, 0
    StringSplit, parts, config, :
    ; (index 0, index 1 , index 2)
    ; (length , app name, amount)
    if parts1 = %activeClass%
    {
        %A_Param1% = %parts2%
    }
}
Return

;(result  )
;(A_Param1)
#DefineCommand getWidthAdjustment, lblGetWidthAdjustment
lblGetWidthAdjustment:
%A_Param1% = %WIDTH_ADJUSTMENT%
WinGetClass, activeClass, A
StringSplit, widthAdjustment, WIDTH_ADJUSTMENT_CUSTOM, `,
Loop, %widthAdjustment0%
{
    StringTrimLeft, config, widthAdjustment%a_index%, 0
    StringSplit, parts, config, :
    ; (index 0, index 1 , index 2)
    ; (length , app name, amount)
    if parts1 = %activeClass%
    {
        %A_Param1% = %parts2%
    }
}
Return

;(result  )
;(A_Param1)
#DefineCommand getWidthAdjustmentHalfScreen, lblGetWidthAdjustmentHalfScreen
lblGetWidthAdjustmentHalfScreen:
%A_Param1% = %WIDTH_ADJUSTMENT_HALF_SCREEN%
WinGetClass, activeClass, A
StringSplit, widthAdjustmentHalfScreen, WIDTH_ADJUSTMENT_HALF_SCREEN_CUSTOM, `,
Loop, %widthAdjustmentHalfScreen0%
{
    StringTrimLeft, config, widthAdjustmentHalfScreen%a_index%, 0
    StringSplit, parts, config, :
    ; (index 0, index 1 , index 2)
    ; (length , app name, amount)
    if parts1 = %activeClass%
    {
        %A_Param1% = %parts2%
    }
}
Return

;(result  )
;(A_Param1)
#DefineCommand doesActiveWindowGetAdjustment, lblDoesActiveWindowGetAdjustment
lblDoesActiveWindowGetAdjustment:
; Interestingly, Brave started acting normal when I turned on "Use system title bar and borders"
windowsToAdjust = Brave-browser,Alacritty
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

;For some reason A_Param1 was not getting set (probably a bug in AHK_X11), so I just skip it now
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

;For some reason A_Param1 was not getting set (probably a bug in AHK_X11), so I just skip it now
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
    getWidthAdjustmentHalfScreen, widthAdjustmentHalfScreenParam
    getHeightAdjustment, heightAdjustmentParam
    getXAdjustment, xAdjustmentParam
    getYAdjustment, yAdjustmentParam
    getWidthHeightAdjustmentFactor,, %widthAdjustmentHalfScreenParam%, %heightAdjustmentParam%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %xAdjustmentParam%, %yAdjustmentParam%, adjustmentX, adjustmentY
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
    getWidthAdjustmentHalfScreen, widthAdjustmentHalfScreenParam
    getHeightAdjustment, heightAdjustmentParam
    getXAdjustment, xAdjustmentParam
    getYAdjustment, yAdjustmentParam
    getWidthHeightAdjustmentFactor,, %widthAdjustmentHalfScreenParam%, %heightAdjustmentParam%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %xAdjustmentParam%, %yAdjustmentParam%, adjustmentX, adjustmentY
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
    getWidthAdjustment, widthAdjustmentParam
    getHeightAdjustment, heightAdjustmentParam
    getXAdjustment, xAdjustmentParam
    getYAdjustment, yAdjustmentParam
    getWidthHeightAdjustmentFactor,, %widthAdjustmentParam%, %heightAdjustmentParam%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %xAdjustmentParam%, %yAdjustmentParam%, adjustmentX, adjustmentY
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
    getWidthAdjustment, widthAdjustmentParam
    getHeightAdjustment, heightAdjustmentParam
    getXAdjustment, xAdjustmentParam
    getYAdjustment, yAdjustmentParam
    getWidthHeightAdjustmentFactor,, %widthAdjustmentParam%, %heightAdjustmentParam%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %xAdjustmentParam%, %yAdjustmentParam%, adjustmentX, adjustmentY
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
    getWidthAdjustment, widthAdjustmentParam
    getXAdjustment, xAdjustmentParam
    getYAdjustment, yAdjustmentParam
    getHeightAdjustmentBottom, heightAdjustmentBottomParam

    getWidthHeightAdjustmentFactor,, %widthAdjustmentParam%, %heightAdjustmentBottomParam%, adjustmentWidth, adjustmentHeight
    getXYAdjustmentFactor,, %xAdjustmentParam%, %yAdjustmentParam%, adjustmentX, adjustmentY
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


