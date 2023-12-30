autoload -Uz promptinit
promptinit

source ~/.config/shell/aliases
source ~/.config/shell/functions

bindkey -v

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

HISTSIZE=100000000
SAVEHIST=100000000
HISTFILE=~/.cache/zsh/zsh_history

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

zle -N autosuggest-execute
zle -N autosuggest-accept

bindkey '^A' autosuggest-accept
bindkey '^E' autosuggest-execute

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 
if [[ $(tty) = /dev/pts/* ]]; then
	#eval "$(starship init zsh)"
	alias ls='eza --icons --color=always'
	alias ll='eza -lah --icons --color=always'
	#PROMPT="%(?:%{$fg_bold[red]%}%{$fg_bold[green]%}%{$fg_bold[yellow]%} :%{$fg_bold[red]%} )%{$fg_bold[cyan]%} "
fi

#setopt histignorealldups
setopt extendedhistory
setopt sharehistory

# https://old.reddit.com/r/tmux/comments/ghld8p/why_my_tmux_doesnt_sync_command_history_between/?sort=old
# need to click + next to "deleted" to see actually relevant information
# though the following link is much better
# https://askubuntu.com/questions/23630/how-do-you-share-history-between-terminals-in-zsh
# I needed to source .zshrc manually for this changes to take effect, simply running new
# shell instance did not change anything
# https://superuser.com/questions/519596/share-history-in-multiple-zsh-shell
# turns out that I need to press enter for the command to be available when scrolling upwards
# https://github.com/junegunn/fzf/issues/50
# no hope
