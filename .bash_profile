# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export LS_OPTIONS="$LS_OPTIONS -F"
# export DISPLAY="tp-sagivm:0.0"
export PYTHONPATH="/a/home/sagivm/work/python/"
export EDITOR=vim
PATH=$HOME/.cabal/bin:$PATH:$HOME/bin

export PATH
