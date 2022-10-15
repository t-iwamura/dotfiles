# Setting PATH for Python 3.9
# The original version is saved in .zprofile.pysave
if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
if [[ $(hostname) = *"Mac"* ]]; then
    PATH="/Library/Frameworks/Python.framework/Versions/3.9/bin:${PATH}"
    export PATH
fi
if [[ $(hostname) = "h115.7.232.10.10875.vlan.kuins.net" ]]; then
    export LC_CTYPE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
fi
