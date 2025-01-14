export PATH=$HOME/.local/bin:$HOME/.nix-profile/bin:$HOME/.local/lib/:$PATH

source "$HOME"/.config/shell/variables

if [ $(tty) = /dev/tty1 ]; then
	# startx "$XDG_CONFIG_HOME/x11/xinitrc"
	# exec qtile start -b wayland
fi

# as a sidenote, .zprofile seems to not be preferred name
# for this kind of file
# on preconfigured artix installation I had to use .zshenv
# to achieve the same effect.
# TODO: analyze this further.
