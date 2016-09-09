# .bash_profile

export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/2.7/bin:$PATH
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

export PATH
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"


test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
