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

# ssh agent
if [ -x /usr/lib/ssh/x11-ssh-askpass ] ; then
	export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass
elif [ -x /usr/libexec/openssh/x11-ssh-askpass ] ; then
	export SSH_ASKPASS=/usr/libexec/openssh/x11-ssh-askpass
fi
[ ! "$SSH_AGENT_PID" ] && eval `ssh-agent`
DISPLAY=unix:0 ssh-add ${HOME}/.ssh/identity ${HOME}/.ssh/id_rsa ${HOME}/.ssh/id_dsa

/usr/bin/xscreensaver -lock-mode &

# extra programs: sawfish only manages windows
${HOME}/.xinitrc-`hostname`
gkrellm &
lavaps &
exec sawfish

