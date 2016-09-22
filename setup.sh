DOT_FILES=(.irbrc .xbindkeysrc .xmobarrc .zlogin 
.rainbow_config.json .Xauthority .xinitrc .Xmodmap .zshrc)

for file in ${DOT_FILES[@]}
do
	ln -s $HOME/dotfiles/$file $HOME/$file
done

