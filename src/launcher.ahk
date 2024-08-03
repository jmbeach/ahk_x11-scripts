; Open the terminal with windows key and enter
#Enter::
    alacritty = %A_Home%/.cargo/bin/alacritty
    EnvGet, home, HOME
    Run, %alacritty% --title "", %home%
return
