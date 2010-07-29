alias idle='/home/sagiv/bin/idle.py -s &'
function lsw()
{
 ls -lah `which $*`
}
function label () { echo -ne "\e]0;$*\a"; }
function lw () { less `which $*`; }
function say () { echo $* | festival --tts; }
alias local_easy_install="easy_install -d $HOME/work/python -s $HOME/bin"
alias title=label
alias updisp="export DISPLAY=`echo $SSH_CLIENT | awk {'print $1'}`:0.0"
# git aliases
alias gs='git status'
alias gd='git diff'
alias gsu='git submodule update --init'
