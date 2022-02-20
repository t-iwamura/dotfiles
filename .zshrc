# Created by newuser for 5.8
########################## zsh history settings ########################
# don't put duplicate lines or lines starting with space in the history.
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
# don't save history command
setopt hist_no_store
# automatically expand the command by history completion
setopt hist_expand
# enable to edit completed command
setopt hist_verify
# key binding about history completion
bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward
# append to the history file, don't overwrite it
setopt append_history
# share the history between opened zshs
setopt share_history
# the number of commands that are loaded into memory from the history file
export HISTSIZE=10000
# the number of commands that are stored in the zsh history file
export SAVEHIST=10000
# refer to the path/location of the history file
export HISTFILE=${HOME}/.zsh_history

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color|*-256color) color_prompt=yes;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
alias ls='ls --color=auto -F -w 77'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

########################## basic settings ##########################
# have zsh correct wrong command name
setopt correct
# change directory just by typing directory name
setopt auto_cd
# cd iwamura -> cd /home/iwamura/
setopt cdable_vars
# prohibit duplicated directory stack
setopt pushd_ignore_dups
# prompt substitution
setopt prompt_subst
# extend variable expansion
setopt extended_glob
# smart field split when completion is done
setopt sh_word_split
# complete name of variables
setopt auto_param_keys
# list all the completion candidates, but clear them when exit
setopt always_last_prompt
# verification before 'rm *'
setopt rm_star_wait
# don't ring beep
unsetopt beep
# key binding
bindkey '^[u' undo
bindkey '^[r' redo

####################### prompt customization #######################
function left-prompt {
    # color settings
    name_t='226m%}'
    name_b='009m%}'
    path_t='195m%}'
    path_b='031m%}'
    arrow='214m%}'
    text_color='%{\e[38;5;'
    back_color='%{\e[30;48;5;'
    reset='%{\e[0m%}'
    sharp='\uE0B0'

    user="${back_color}${name_b}${text_color}${name_t}"
    dir="${back_color}${path_b}${text_color}${path_t}"
    echo "${user}%n@%m${back_color}${path_b}${text_color}${name_b}${sharp} ${dir}%~${reset}${text_color}${path_b}${sharp}${reset}\n${text_color}${arrow}> ${reset}"
}

PROMPT=$(left-prompt)

####################### Alias definitions ##########################
# You may want to put all your additions into a separate file like
# ~/.zsh_aliases, instead of adding them here directly.
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

#################### zsh-completions settings ######################
# when directory name is completed, automatically add slash at the end
setopt auto_param_slash
# when the conditions are fulfilled, automatically remove slash at the end
setopt auto_remove_slash
# show file type when file name list is completed
setopt list_types

#fpath=(~/.zsh/completion/src ${fpath})

# zstyle settings
zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%BCompleting %d%b'
zstyle ':completion:*' group-name ''
# make VASP input files(e.g. POSCAR, INCAR,..) easy to treat
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}'

autoload -Uz compinit && compinit -u


man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

# avoid libGL error
export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
export LIBGL_ALWAYS_INDIRECT=1

# pyenv-virtualenv setting
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# PYTHONPATH
export PYTHONPATH=${PYTHONPATH}:${HOME}/mlp-Fe/
cd
