# Created by newuser for 5.8
# Common settings
########################## zsh history settings ########################
# don't put duplicate lines or lines starting with space in the history.
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
# Immediately append to history file
setopt inc_append_history
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
export HISTSIZE=40000
# how many lines to be saved in history file
export SAVEHIST=40000
# Ignore these commands in history
export HISTORY_IGNORE="(ls|pwd|cd)*"
# designate history file in zsh
export HISTFILE=${HOME}/.zsh_history


########################## basic settings ##########################
# have zsh correct wrong command name
setopt correct
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
# pyenv-virtualenv setting
export PYENV_ROOT=${HOME}/.pyenv
if [ -d ${PYENV_ROOT} ]; then
    command -v pyenv >/dev/null || export PATH="${PYENV_ROOT}/bin:${PATH}"
    eval "$(pyenv init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    eval "$(pyenv virtualenv-init -)"
fi

if [ -e ${HOME}/.cargo/bin/starship ] || [ -e /opt/homebrew/bin/starship ]; then
    eval "$(starship init zsh)"
fi


####################### Alias definitions ##########################
# You may want to put all your additions into a separate file like
# ~/.zsh_aliases, instead of adding them here directly.
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [[ $(hostname) = *"Mac"* ]] || [ $(hostname) = 'h115.7.232.10.10875.vlan.kuins.net' ]; then
    export LSCOLORS="gxfxcxdxbxexexabagacad"
    alias ls='ls -FG'
else
    alias ls='ls --color=auto -F'
fi
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'


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
# convert lowercase filename to uppercase by completion
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
elif [[ ${machine_name} = *"Mac"* ]]; then
    export PATH=/usr/local/bin:${PATH}
fi
# avoid libGL error
export LIBGL_ALWAYS_INDIRECT=1

# PATH settings
# add ~/bin to PATH
export PATH=${PATH}:${HOME}/.local/bin
if [ -d ${HOME}/bin ]; then
    export PATH=${PATH}:${HOME}/bin
fi
if [ -d "/opt/homebrew" ]; then
    export PATH="/opt/homebrew/opt/unzip/bin:$PATH"
fi
# add lammps dir to PATH
lammps_src_dir=${HOME}/usr/local/lammps/src
if [ -d ${lammps_src_dir} ]; then
    export PATH=${PATH}:${lammps_src_dir}
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${lammps_src_dir}
fi
# OpenMP setting for LAMMPS
if [ ${machine_name} = 'iwamura-srv' ]; then
    export OMP_NUM_THREADS=4
elif [ ${machine_name} = 'mormon' ]; then
    export OMP_NUM_THREADS=20
fi

# CDPATH settings
if [ ${machine_name} = 'iwamura-srv' ]; then
    export CDPATH=${HOME}:/mnt/wd/backup/my_source_code:/mnt/wd/backup/PM-Fe_mlp
fi

# ASE settings
export ASE_LAMMPSRUN_COMMAND='lmp_serial'

# fzf settings
# Enable auto completion of fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# yarn settings
if [ -d ${HOME}/.yarn ]; then
    export PATH="${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${PATH}"
fi

# mojo settings
export MODULAR_HOME=${HOME}/.modular
export PATH=${HOME}/.modular/pkg/packages.modular.com_mojo/bin:${PATH}

# Go settings
export GOPATH=${HOME}/.go
export PATH=${PATH}:${GOPATH}/bin
