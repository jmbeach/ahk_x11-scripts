# AHK_X11 Scripts I Use

(See my Windows AHK scripts [here](https://github.com/jmbeach/autohotkey-scripts))

> 🗒 Some hotkeys I use, such as using `Super + <num>` to switch desktops are done using out of the box GNOME configuration. See my GNOME settings [here](https://github.com/jmbeach/dotfiles/tree/main/gnome).

The [index](./index.ahk) file just imports all the other scripts that I want to use on a regular basis. That way, I only see a single AHK_X11 symbol in my top bar and not a bunch.

---

## [Layout Manager](./src/layout-manager.ahk)

This script makes it easy to move windows around to fixed positions on the screen. One of the main reasons I like it is that it leaves a little gap between windows. This is not only aesthetically pleasing, but makes it easy to adjust the window sizes with the mouse.

| Key binding | Description |
| --- | --- |
| `Win + Shift + U` | Makes the active window take up the majority of the screen, but leaves a ten pixel margin around the edges. |
| `Win + U` | Moves and resizes the active window to the upper half of the screen |
| `Win + Shift + C` | Centers the active window on the screen |
| `Win + B` | Moves and resizes the active window to the bottom of the screen |
| `Win + Shift + H` | Moves and resizes the active window to the left half of the screen. The choice of `H` is Vim-inspired. |
| `Win + Shift + L` | Moves and resizes the active window to the right half of the screen. The choice of `L` is Vim-inspired. |

---

## [Launcher](./src/launcher.ahk) 🚀

The launcher script is for launching commonly used programs using hotkeys.

| Key binding | Description |
| --- | --- |
| `Win + Enter` |  Launches the terminal (alacritty) |

---

## [Other](./src/other.ah2)

This script has more miscellaneous utilities.

| Key binding | Description |
| --- | --- |
| `Win + A` | Performs ctrl + a. This helps me not get too tripped up when switching back and forth from a mac. |
| `Win + C` | Performs ctrl + c. This helps me not get too tripped up when switching back and forth from a mac. |
| `Win + V` | Performs ctrl + v. This helps me not get too tripped up when switching back and forth from a mac. |
| `Win + F` | Performs ctrl + f. This helps me not get too tripped up when switching back and forth from a mac. |
| `Win + Q` | Sends alt + F4. This helps me not get too tripped up when switching back and forth from a mac. |
| `Win + W` | Sends ctrl + w. This helps me not get too tripped up when switching back and forth from a mac. |
| `Capslock` | Sends the down arrow key. This is especially useful with context menus to quickly cycle through options without needing the mouse. |
| `Shift + Capslock` | Sends the up arrow key. This is especially useful with context menus to quickly cycle through options without needing the mouse. |

