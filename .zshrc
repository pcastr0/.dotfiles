export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8

if command -v fastfetch &> /dev/null; then
    # Only run fastfetch if we're in an interactive shell
    if [[ $- == *i* ]]; then
        fastfetch
    fi
fi

ZSH_THEME="robbyrussell"
DISABLE_MAGIC_FUNCTIONS="true"

fpath+="${ZSH_CUSTOM:-"$ZSH/custom"}/plugins/zsh-completions/src"
plugins=(git zsh-syntax-highlighting zsh-bat fzf-tab zsh-autosuggestions you-should-use)

autoload -Uz compinit && compinit

source "$ZSH/oh-my-zsh.sh"

# History configuration
HIST_STAMPS="mm/dd/yyyy"
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE

# Recommended history options
setopt appendhistory         # Append history to the history file
setopt sharehistory          # Share history between all sessions
setopt hist_ignore_space     # Do not store commands starting with a space
setopt hist_ignore_dups      # Do not store duplicates
setopt hist_save_no_dups     # When saving, do not save duplicates
setopt hist_ignore_all_dups  # Remove all duplicates from history
setopt hist_expire_dups_first # Expire duplicates first when history limit is reached
setopt hist_verify           # Show history command before executing
setopt hist_find_no_dups     # Do not store duplicates when searching history

# Keybindings
bindkey -e                   # Use emacs-like key bindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region    # Kill word backwards

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' # Case-insensitive completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}" # Use LS_COLORS for completion coloring
zstyle ':completion:*' menu no       # Disable completion menu
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' # FZF preview for cd
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath' # FZF preview for zoxide

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Custom Aliases

# Zsh configuration aliases
alias vim="nvim"
alias eshrc="nvim ~/.zshrc"
alias sshrc="source ~/.zshrc"
alias ohmyzsh="nvim ~/.oh-my-zsh"

# Pomodoro timers
alias pukos="timer 30m && terminal-notifier -message 'Pomodoro'\\\
        -title 'Work Timer is up! Take a Break 😊'\\\
        -appIcon '~/Pictures/pumpkin.png'\\\
        -sound Crystal"
        
alias rest="timer 10m && terminal-notifier -message 'Pomodoro'\\\
        -title 'Break is over! Get back to work 😬'\\\
        -appIcon '~/Pictures/pumpkin.png'\\\
        -sound Crystal"

# Navigation and file management aliases
alias home="cd ~"
alias lsa="ls -la"
alias rm="trash -v" # Use trash-cli for safe removal
alias speedtest="speedtest-cli"

# Application specific aliases
alias ff="fastfetch"
alias lzg="lazygit"
alias lzd='lazydocker'

# Redis aliases
# If Redis is installed in a custom location, define REDIS_HOME.
# Otherwise, ensure redis-server and redis-cli are in your PATH.
export REDIS_HOME="${HOME}/redis" # Example: adjust this path if yours is different

alias redis-server="${REDIS_HOME}/bin/redis-server"
alias redis-cli="${REDIS_HOME}/bin/redis-cli"
alias redis-cluster="${REDIS_HOME}/redis-8.0.0/utils/create-cluster/create-cluster" # Adjust version if needed
alias flush-redis="redis-cli --cluster call 127.0.0.1:30001 FLUSHALL"

# Functions

# Automatically do an ls after each cd, z, or zoxide
cd ()
{
	if [ -n "$1" ]; then
    builtin cd "$@" && ls -la
  else
		builtin cd ~ && ls -la
	fi
}

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(zellij setup --generate-auto-start zsh)"
