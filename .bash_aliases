. ~/bin/make-completer-wrapper.sh
alias idle='/home/sagiv/bin/idle.py -s &'
function lsw()
{
 ls -lah `which $*`
}
function label () { echo -ne "\x1B]0;$*\a"; }
function lw () { less `which $*`; }
function say () { echo $* | festival --tts; }
function preview() { open https://account.heatintelligence.com/#/preview?task_id=$1; }
function show_task() { curl -s -H 'x-crunch-api-key: 4180232113ff4104727c5b115d0f0790' https://api.heatintelligence.com/v1/requests/$1 | json_pp; }
function show_token() {
    $HOME/crunchable/api-server/app/scripts/update_user.py --email $1 | grep token | awk '{print $2;}' | tr -d '",';
}
function show_user_id() {
    $HOME/crunchable/api-server/app/scripts/update_user.py --email $1 | grep \"_id\" | awk '{print $2;}' | tr -d '",';
}
function latest_tasks() {
    curl -H "x-heat-api-key: `show_token $1`" "https://api.heatintelligence.com/users/developer/tasks/complete?limit=10&reverse=1" | json_pp;
}

alias update_user=$HOME/crunchable/api-server/app/scripts/update_user.py
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
