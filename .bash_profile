# .bash_profile

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

##
# Your previous /Users/sagiv/.bash_profile file was backed up as /Users/sagiv/.bash_profile.macports-saved_2012-01-02_at_17:02:11
##

# MacPorts Installer addition on 2012-01-02_at_17:02:11: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

