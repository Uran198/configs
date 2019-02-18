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
# Menu completion.
setopt MENU_COMPLETE

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
zstyle ':completion:*' completer _complete _ignored _approximate

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

# virtualenvwrapper setup.
local venv_wrapper=/usr/local/bin/virtualenvwrapper_lazy.sh
if [[ -r $venv_wrapper ]]; then
    export WORKON_HOME=~/.virtualenvs
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    # TODO: Since I don't use it much, not sure if it's really worth to have it in
    # prompt, since it clutters stuff a little bit. Here is how to make it more
    # custom:
    # https://stackoverflow.com/questions/10406926/how-do-i-change-the-default-virtualenv-prompt/20026992
    # Disable prompt changes.
    export VIRTUAL_ENV_DISABLE_PROMPT=1

    # Use lazy for faster zsh startup.
    source /usr/local/bin/virtualenvwrapper_lazy.sh

    # Generic GNU command completion that works with everything that has --help.
    compdef _gnu_generic mkvirtualenv
fi

# Command aliases.
alias ll='ls -f -F --color=auto -lh'
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'
