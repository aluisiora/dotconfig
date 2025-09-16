# System environment variables
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Prepare XDG dirs
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh

export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh

# Set the directory we want to store zinit and plugins
ZINIT_HOME="$XDG_DATA_HOME/zinit/zinit.git"

# Download zinit, if it's not there yet
if [ ! -d $ZINIT_HOME ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# History
HISTFILE="$XDG_STATE_HOME"/zsh/history
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Add plugins
zinit ice depth=1
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit ice lucid wait
zinit snippet OMZP::fzf

zi ice as"completion"
zi snippet OMZP::docker/completions/_docker

# Load completions
autoload -U compinit && compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION
zinit cdreplay -q

# Completions
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no

# Aliases
alias ls="ls --color"
alias ll="ls -lah --color"

if [ -f $HOME/.zshrc_local ]; then
  source $HOME/.zshrc_local
fi

# Set custom prompt theme
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# vi mode
bindkey -v

# Keybindings
bindkey -s '^e' 'tmux-sessionizer^M'
