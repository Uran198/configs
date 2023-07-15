# Set options:
# Options are returned to what they were after a function call.
setopt LOCAL_OPTIONS
# Better prompt parameters, in particular, can use vcs_info.
setopt PROMPT_SUBST
# Do not show an errors on one of the globs.
setopt CSH_NULL_GLOB
# Verify commands with !!* before executing.
setopt HIST_VERIFY
# Multiple sessions save history as commands are executed (and not on exit),
# but doesn't read history from other shells.
setopt INC_APPEND_HISTORY
# Ignore adjacent duplicates.
setopt HIST_IGNORE_DUPS
# Do not show duplicates in searches.
setopt HIST_FIND_NO_DUPS
# Correct commands.
setopt CORRECT

# Don't do automatic substitution of the first match.
# setopt MENU_COMPLETE

# Keep long history.
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Get information about VCS.
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn p4 hg
zstyle ':vcs_info:*' formats '[%F{142}%s%f@%F{112}%B%b%%b%f] '

precmd() {
    vcs_info
    # Change title to display current directory.
    print -P '\e]2;%~\a'
}

# Set nice prompts.
# ^Xu is a reminder of a shortcut to undo !! expansion after <TAB> and other
# stuff.
PS1='
%K{236}%F{112}%D{%b %d %H:%M:%S} %f %n@%M %F{174}%~
%k%f^Xu${vcs_info_msg_0_}%B(%h) %# %b'

# Need to call to init when first started.
# Cannot call zle-line-init, or zle-keymap-select, because they would error on
# zle.
function setRPS1 {
    # Show return code of the last call if error and vi bindings mode.
    RPS1="%(?..%F{160}err(%?%)) %F{221}${${KEYMAP/(viins|main)/--INSERT--}/vicmd/[NORMAL]}%f"
}
function zle-keymap-select zle-line-init {
    setRPS1
    zle reset-prompt
}
setRPS1

zle -N zle-keymap-select
zle -N zle-line-init

# Use emacs bindings for insert mode. Still can get to vicmd with <Esc> or ^[.
bindkey -e

bindkey -a '?' history-incremental-search-backward
bindkey -a '/' history-incremental-search-forward
# Map forward backward to ^arrows.
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
# Reverse match with Shift+Tab.
bindkey "^[[Z" reverse-menu-complete
# Use convenient escape.
bindkey '^[' vi-cmd-mode

# Small lag after changing keymap.
export KEYTIMEOUT=1

# Disable XON/XOFF flow control, that makes ^Q and ^S unavailable.
# ^Q is useful for push-line.
stty -ixon

autoload -Uz compinit
compinit

# Have menu-like completion.
zstyle ':completion:*' menu select

# Use cache to speed things up.
zstyle ':completion::complete:*' use-cache 1

# Enable approximate completions.
# FIXME Can be VERY slow when trying completing long and complex directories
#zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' completer _complete _ignored

# Verbose completion results.
zstyle ':completion:*' verbose yes

# Group results by category.
zstyle ':completion:*' group-name ''

# Set pretty descriptions for categories.
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:messages' format '%U%B%d%b%u'

# Show when waiting for completion.
zstyle ':completion:*' show-completer true

# Use ls colors for path completion.
zstyle ':completion:*:default' list-colors ''

# Path entries should be unique.
typeset -U path
# Rust package manager.
path=(~/.cargo/bin $path)
# go binary
path=(/usr/local/go/bin $path)
path=($(go env GOPATH)/bin $path)
# pip
path=(~/.local/bin $path)

# Command aliases.
alias ll='ls -f -F --color=auto -lh'
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'

# Test slow completion.
tsc_hello() {
    echo "Test completion: Hello World: $@"
}
_tsc_hello_compl() {
    sleep 2
    _arguments "1:This is a test first argument:(ololololo right)"
}

compdef _tsc_hello_compl tsc_hello


to_image() {
    # "FreeMono" -border 300
    convert -size 15000x30000 xc:white -density 300 -font "Courier-BoldOblique" -pointsize 12 -interline-spacing 60 -fill black -annotate +150+150 "@$1" -trim  -bordercolor "#FFF" -border 300 +repage "$2"
}


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# python alias
# alias python=python3.7
# alias pip=pip3.7



# -----------------------------
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# Enables fzf
source /usr/share/doc/fzf/examples/key-bindings.zsh
source /usr/share/doc/fzf/examples/completion.zsh

export TERM='xterm-256color'
export EDITOR=vim

# Tmux windows renaming
function tmux_title() {
  tmux rename-window "$(basename `pwd`)"
}
if [[ ! -z "$TMUX" ]]; then
  precmd_functions+=(tmux_title)
fi

start_work() {
    tmux new-session -A -s work
}
zle -N start_work{,}
# Ctrl+s to start work.
bindkey -s '^s' 'start_work\n'

export PATH=$HOME/go/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
