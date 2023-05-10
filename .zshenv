# never make duplicated path be set
typeset -U path
if [ -d ${HOME}/.cargo ]; then
    . "$HOME/.cargo/env"
fi
