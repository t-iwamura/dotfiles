# Setting PATH for Python 3.9
# The original version is saved in .zprofile.pysave
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [[ $(hostname) = *"Mac"* ]]; then
    PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
    export PATH
fi
