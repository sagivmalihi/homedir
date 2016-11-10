. ~/bin/make-completer-wrapper.sh
alias idle='/home/sagiv/bin/idle.py -s &'
function lsw()
{
 ls -lah `which $*`
}
function label () { echo -ne "\x1B]0;$*\a"; }
function lw () { less `which $*`; }
function say () { echo $* | festival --tts; }
alias local_easy_install="easy_install -d $HOME/work/python -s $HOME/bin"
alias title=label
alias updisp="export DISPLAY=`echo $SSH_CLIENT | awk {'print $1'}`:0.0"
# git aliases
gitalias gc 'git checkout'
gitalias gs 'git status'
gitalias gd 'git diff'
alias gsu='git submodule update --init'
alias ls="ls -F"
alias less="less -Rf"
alias zen_activate="source /intucell/latest/bin/activate"

# nginx
alias nginx_start='sudo launchctl load -w /Library/LaunchDaemons/org.macports.nginx.plist'
alias nginx_stop='sudo launchctl unload -w /Library/LaunchDaemons/org.macports.nginx.plist'
alias nginx_restart='nginx_stop; nginx_start;'
