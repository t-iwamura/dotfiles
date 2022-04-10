export PYENV_ROOT=${HOME}/.pyenv
export PATH=${PYENV_ROOT}/bin:${PATH}
eval "$(pyenv init --path)"

# Setting PATH for Python 3.9
# The original version is saved in .zprofile.pysave
if [[ $(hostname) = *"Mac"* ]]; then
    PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
    export PATH
fi

