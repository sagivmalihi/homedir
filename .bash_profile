# .bash_profile

export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/3.5/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export LS_OPTIONS="$LS_OPTIONS -F"
export EDITOR=vim
PATH=$HOME/.cabal/bin:$PATH:$HOME/bin

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# MacPorts Installer addition on 2016-11-14_at_11:47:01: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

