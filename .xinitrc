#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# numlock
numlockx on

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# im
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"
fcitx &

# be quiet
amixer set Master 0%

# wallpaper
# feh --bg-center /home/honoka/picture/wallpaper/Serial_Experiments_Lain_anime_series_cyberpunk_horror_sci_fi_drama_1sel_1920x1080.jpg &
# feh --bg-center /home/honoka/picture/wallpaper/19736_serial_experiments_lain.jpg &
feh --bg-center /home/honoka/picture/wallpaper/horizon_1649.png

# screensaver
xset dpms; xset s off

# fix Java GUI
wmname LG3D

# xmonad
xsetroot -curser_name left_ptr
setxkbmap -layout us
xmobar &
xbindkeys &
exec xmonad
