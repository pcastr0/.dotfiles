# if [ -n "${GHOSTTY_RESOURCES_DIR}" ]; then
#     builtin source ${GHOSTTY_RESOURCES_DIR}/shell-integration/zsh/ghostty-integration
# fi
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

DISABLE_MAGIC_FUNCTIONS="true"

HIST_STAMPS="mm/dd/yyyy"

plugins=(git zsh-syntax-highlighting you-should-use zsh-bat fzf-tab)

fpath+="${ZSH_CUSTOM:-"$ZSH/custom"}/plugins/zsh-completions/src"

autoload -Uz compinit && compinit

source "$ZSH/oh-my-zsh.sh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

if command -v fastfetch &> /dev/null; then
    # Only run fastfetch if we're in an interactive shell
    if [[ $- == *i* ]]; then
        fastfetch
    fi
fi

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#
alias vim="nvim"
alias eshrc="nvim ~/.zshrc"
alias sshrc="source ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

alias pukos="timer 30m && terminal-notifier -message 'Pomodoro'\
        -title 'Work Timer is up! Take a Break 😊'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"
        
alias rest="timer 10m && terminal-notifier -message 'Pomodoro'\
        -title 'Break is over! Get back to work 😬'\
        -appIcon '~/Pictures/pumpkin.png'\
        -sound Crystal"

alias home="cd ~"
alias lsa="ls -la"

alias="cd ~"
alias rm="trash -v"
alias speedtest="speedtest-cli"

alias lzg="lazygit"
alias lzd='lazydocker'

alias redis-server="~/redis/bin/redis-server"
alias redis-cli="~/redis/bin/redis-cli"
alias redis-cluster="~/redis/redis-8.0.0/utils/create-cluster/create-cluster"
alias flush-redis="redis-cli --cluster call 127.0.0.1:30001 FLUSHALL"


# Automatically do an ls after each cd, z, or zoxide
cd ()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && ls -la
	else
		builtin cd ~ && ls -la
	fi
}

eval "$(/Users/patrickpaul.castro/.local/bin/mise activate zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
