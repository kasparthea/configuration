autoload -Uz promptinit
promptinit
source ~/.config/shell/aliases
source ~/.config/shell/functions

setopt histignorealldups sharehistory
setopt correct_all

#powerline-daemon -q
#source /usr/share/powerline/bindings/zsh/powerline.zsh

bindkey -v

HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.cache/zsh/zsh_history

# Use modern completion system
#_fix_cursor
# as per
# https://stackoverflow.com/questions/4416909/anyway-change-the-cursor-vertical-line-instead-of-a-box
# and also random comment (hence the name _fix_cursor, I did not come up with it on my 
# own) which I could not find again
# I already had similar function to this but removed it for troubleshooting
# as it turns out though it was not a source of any problems

#function _fix_cursor(){
#	echo -e -n "\x1b[6 q" # changes to steady bar
#}

function vu(){
	cd ~/University/
}
#autoload -U promptinit 
#promptinit
#prompt spaceship
autoload -Uz compinit
autoload -U colors && colors
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)
precmd_functions+=(_fix_cursor)

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# (1)
zle -N autosuggest-execute
zle -N autosuggest-accept

# at last after like maybe an hour of intense thinking I guessed  that:
# you have to add (1) if zle -la gives the name after zle -N
# and that this change required \r not \n as I found on the internet
# because man zshzle lists \r as carriage return not \n 
# no for some reason \r does not work as well
# why does it not work here I do not know
# bindkey '^\n' autosuggest-execute
bindkey '^A'  autosuggest-accept
bindkey '^E' autosuggest-execute

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
if [[ $(tty) = /dev/pts/* ]]; then
	#eval "$(starship init zsh)"
	alias ls='exa --icons --color=always'
	alias ll='exa -lah --icons --color=always'
	#PROMPT="%(?:%{$fg_bold[red]%}%{$fg_bold[green]%}%{$fg_bold[yellow]%} :%{$fg_bold[red]%} )%{$fg_bold[cyan]%} "
fi

# opam configuration
[[ ! -r "$OPAMROOT"/opam-init/init.zsh ]] || source "$OPAMROOT"/opam-init/init.zsh  > /dev/null 2> /dev/null

[ -f "/home/thea/.ghcup/env" ] && source "/home/thea/.ghcup/env" # ghcup-env