#!/bin/sh

if [ "$1" != "" ]; then
    var=`readlink -f $1`
    var="`echo ${var} | sed 's/\//\\\/g'`"
    var="Z:${var}"
    utorrent.exe "$var"
else
    utorrent.exe
fi

