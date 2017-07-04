# TODO: Clean this file
# TODO: Read arch linux docs https://wiki.archlinux.org/index.php/zsh#Making_Zsh_your_default_shell

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/attila/.zshrc'

# End of lines added by compinstall
autoload -Uz compinit
compinit

autoload -U promptinit
promptinit
prompt clint

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export PATH="/usr/local/heroku/bin:$PATH" # Add Heroku
export PATH="/home/attila/Projects/git/codeforces-helper:$PATH" # Add maker
export PATH="/$PATH:/home/attila/Downloads/pmd-bin-5.4.1/bin/"
export PATH="/$PATH:/usr/local/cuda-8.0/bin/"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
export CUDA_HOME=/usr/local/cuda

# # add pyenv
# export PATH="/home/attila/.pyenv/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"


#   # added by Anaconda3 2.3.0 installer
#   export PATH="/home/attila/anaconda3/bin:$PATH"
#   # need this because vim was compiled with system python
#   export PYTHONPATH=/home/attila/anaconda3/lib/python3.4/site-packages

# virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export VIRTUALENVWRAPPER_VIRTUALENV=virtualenv-3.4
source /usr/local/bin/virtualenvwrapper.sh

# # Enable bash autocompetion for coala
# autoload bashcompinit
# bashcompinit
# workon coala_test
# eval "$(register-python-argcomplete `which coala`)"


# virtualenv
# source /home/attila/.virtualenvs/qa-project/bin/activate
# export PYTHONPATH=/home/attila/.virtualenvs/qa-project/lib/python3.4/site-packages/
# source /home/attila/.virtualenvs/djangodev/bin/activate
# export PYTHONPATH=/home/attila/.virtualenvs/djangodev/lib/python3.4/site-packages/
# source /home/attila/.virtualenvs/coala/bin/activate
# export PYTHONPATH=/home/attila/.virtualenvs/coala/lib/python3.4/site-packages/
# source /home/attila/.virtualenvs/organizator/bin/activate
# export PYTHONPATH=/home/attila/.virtualenvs/organizator/lib/python3.4/site-packages/

# remove anoying pop-ups
unset SSH_ASKPASS

## added by Anaconda 2.3.0 installer
#export PATH="/home/attila/anaconda/bin:$PATH"


# Backwardkill bash-like
autoload -U select-word-style
select-word-style bash

#-------- grml-zsh-config handeles this and more
## command alias
alias ll='ls -f -F --color=auto -lh'
alias ls='ls -F --color=auto'
alias grep='grep --color=auto'

## create a zkbd compatible hash;
## to add other keys to this hash, see: man 5 terminfo
#typeset -A key
#
#key[Home]=${terminfo[khome]}
#
#key[End]=${terminfo[kend]}
#key[Insert]=${terminfo[kich1]}
#key[Delete]=${terminfo[kdch1]}
#key[Up]=${terminfo[kcuu1]}
#key[Down]=${terminfo[kcud1]}
#key[Left]=${terminfo[kcub1]}
#key[Right]=${terminfo[kcuf1]}
#key[PageUp]=${terminfo[kpp]}
#key[PageDown]=${terminfo[knp]}
#
## setup key accordingly
#[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
#[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
#[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
#[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
#[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
#[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
#[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
#[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
#[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
#[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history
#
## Finally, make sure the terminal is in application mode, when zle is
## active. Only then are the values from $terminfo valid.
#if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
#    function zle-line-init () {
#        printf '%s' "${terminfo[smkx]}"
#    }
#    function zle-line-finish () {
#        printf '%s' "${terminfo[rmkx]}"
#    }
#    zle -N zle-line-init
#    zle -N zle-line-finish
#fi

rvm_autoupdate_flag=2
