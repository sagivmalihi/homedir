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
# export DISPLAY="tp-sagivm:0.0"
export EDITOR=vim
PATH=$HOME/.cabal/bin:$PATH:$HOME/bin

# MacPorts Installer addition on 2015-06-13_at_12:10:18: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
