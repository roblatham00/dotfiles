#!/bin/sh
#xset m 7 5
xset +dpms

if [ -r .xmodmap-`hostname` ]; then
	xmodmap ~/.xmodmap-`hostname`
fi

XDEFAULTS_GENERAL=.Xdefaults
XDEFAULTS_SPECIFIC=.Xdefaults-`hostname`

for XDEF in $XDEFAULTS_GENERAL $XDEFAULTS_SPECIFIC; do
	xrdb -merge $XDEF
done

# extra programs: sawfish only manages windows
${HOME}/.xinitrc-`hostname`
gkrellm &
lavaps &
exec sawfish

