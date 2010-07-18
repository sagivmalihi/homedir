# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -t 0 ]; then
    stty stop  \^^
    stty start \^_
fi

# User specific aliases and functions
alias gvim="gvim -font 6x13"
function label () { echo -ne "\e]0;$*\a"; }
function lw () { less `which $*`; }
alias local_easy_install="easy_install -d $HOME/work/python -s $HOME/bin"
alias title=label
alias updisp="export DISPLAY=`echo $SSH_CLIENT | awk {'print $1'}`:0.0"
alias less='less -Rf'

function flog () { less -Rf /qa/tlib/logs/by_system/$*/last_test/full.log; }
function clog () { less -Rf /qa/tlib/logs/by_system/$*/last_test/console.log; }
function slog () { less -Rf /qa/tlib/logs/by_system/$*/story.log; }
function uncolor () { cat -v $1 | sed -r -e 's/\^\[\[([0-9];[0-9][0-9];[0-9][0-9])?m//g'; }


# git aliases
alias gs='git status'
alias gd='git diff'
alias gsu='git submodule update --init'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;36m\]\h\[\033[00m\]\[\033[01;31m\]$(git branch 2>/dev/null|grep -e ^* | tr "*" ":" | tr -d " ")\[\033[00m\]:\[\033[01;33m\]\w\[\033[00m\]> '

