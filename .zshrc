# Created by newuser for 5.8
# Common settings
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
# how many lines to be kept in memory
export HISTSIZE=10000
# how many lines to be saved in history file
export SAVEHIST=10000
# designate history file in zsh
export HISTFILE=${HOME}/.zsh_history

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set a fancy prompt (non-color, unless we know we "want" color)
#case "$TERM" in
#    xterm-color|*-256color) color_prompt=yes;;
#esac

# enable color support of ls and also add handy aliases
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
    env LESS_TERMCAP_mb=$'\e[1;32m' \
    LESS_TERMCAP_md=$'\e[1;32m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;4;31m' \
    man "$@"
}

# get machine name
machine_name=$(hostname)
# wsl setting
if [ ${machine_name} = 'DESKTOP-RKO1Q0T' ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi
# avoid libGL error
export LIBGL_ALWAYS_INDIRECT=1

# PATH settings
# add ~/bin to PATH
if [ -d ${HOME}/bin ]; then
    export PATH=${PATH}:${HOME}/bin
fi
# add lammps dir to PATH
lammps_src_dir=${HOME}/usr/local/lammps/src
if [ -d ${lammps_src_dir} ]; then
    export PATH=${PATH}:${lammps_src_dir}
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${lammps_src_dir}
fi

# PYTHONPATH
ph_plotter_dir=${HOME}/usr/local/ph_plotter/
if [ -d ${ph_plotter_dir} ]; then
    export PYTHONPATH=${PYTHONPATH}:${ph_plotter_dir}
fi
vega_tools=${HOME}/tools/
if [ -d ${vega_tools} ]; then
    export PYTHONPATH=${PYTHONPATH}:${vega_tools}
fi

# pyenv-virtualenv setting
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# lammps settings
if [ ${machine_name} = 'iwamura-srv' ]; then
    export OMP_NUM_THREADS=4
elif [ ${machine_name} = 'mormon' ]; then
    export OMP_NUM_THREADS=20
fi

# ASE settings
export ASE_LAMMPSRUN_COMMAND='lmp_serial'

# fzf settings
# Enable auto completion of fzf
source /usr/share/doc/fzf/examples/completion.zsh

