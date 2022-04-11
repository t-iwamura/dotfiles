# Setting PATH for Python 3.9
# The original version is saved in .zprofile.pysave
if [[ $(hostname) = *"Mac"* ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
    export PATH
fi

export PYENV_ROOT=${HOME}/.pyenv
export PATH=${PYENV_ROOT}/bin:${PATH}
eval "$(pyenv init --path)"

