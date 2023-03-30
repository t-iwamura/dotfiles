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
export HISTSIZE=40000
# how many lines to be saved in history file
export SAVEHIST=40000
# designate history file in zsh
export HISTFILE=${HOME}/.zsh_history


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

function rprompt-git-current-branch {
    local branch_name st branch_status

    branch='\ue0a0'
    color='%{\e[38;5;'
    green='114m%}'
    red='001m%}'
    yellow='227m%}'
    blue='033m%}'
    reset='%{\e[0m%}'

    if [ ! -e ".git" ]; then
        # return nothing when not in directory with .git
        return
    fi
    branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
    st=$(git status 2> /dev/null)
    if [[ -n $(echo "${st}" | grep "^nothing to") ]]; then
        branch_status="${color}${green}${branch}"
    elif [[ -n $(echo "${st}" | grep "^Untracked files") ]]; then
        branch_status="${color}${red}${branch}?"
    elif [[ -n $(echo "${st}" | grep "^Changes not staged for commit") ]]; then
        branch_status="${color}${red}${branch}+"
    elif [[ -n $(echo "${st}" | grep "^Changes to be committed") ]]; then
        branch_status="${color}${yellow}${branch}!"
    elif [[ -n $(echo "${st}" | grep "^rebase in progress") ]]; then
        branch_status="${color}${red}${branch}!(no branch)${reset}"
        return
    else
        branch_status="${color}${blue}${branch}"
    fi
    echo "${branch_status}${branch_name}${reset}"
}

PROMPT=$(left-prompt)
RPROMPT='$(rprompt-git-current-branch)'


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
elif [ ${machine_name} = 'Taikis-Mac-mini.local' ]; then
    export PATH=/usr/local/bin:${PATH}
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
# OpenMP setting for LAMMPS
if [ ${machine_name} = 'iwamura-srv' ]; then
    export OMP_NUM_THREADS=4
elif [ ${machine_name} = 'mormon' ]; then
    export OMP_NUM_THREADS=20
fi

# pyenv-virtualenv setting
export PYENV_ROOT=${HOME}/.pyenv
command -v pyenv >/dev/null || export PATH="${PYENV_ROOT}/bin:${PATH}"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# ASE settings
export ASE_LAMMPSRUN_COMMAND='lmp_serial'

# fzf settings
# Enable auto completion of fzf
fzf_completion_file=/usr/share/doc/fzf/examples/completion.zsh
if [ -f ${fzf_completion_file} ]; then
    source ${fzf_completion_file}
fi

# yarn settings
if [ -d ${HOME}/.yarn ]; then
    export PATH="${HOME}/.yarn/bin:${HOME}/.config/yarn/global/node_modules/.bin:${PATH}"
fi
