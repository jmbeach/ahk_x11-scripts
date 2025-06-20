CapsLock::Send, {Down}

+CapsLock::Send, {Up}

; Makes Windows key + f perform ctrl + f
; Make sure to disable default behavior of `Super + f`
#f::Send, ^f

; Makes windows key + c perform ctrl + c
#c::Send, ^c

; Makes Super + v perform ctrl + shift + v (use this because works in terminal)
; Make sure to disable default behavior of `Super + v`
#v::Send, ^+v

; Makes Super + a perform ctrl + a
; Make sure to disable default behavior of `Super + a`
#a::Send, ^a

; Super + q sends alt + F4
#q::Send, !{F4}

; Makes Super + w perform ctrl + w
#w::Send, ^w

; ^n::Send, {Down}
; ^p::Send, {Up}
