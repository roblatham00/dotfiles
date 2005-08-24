#!/bin/sh -xv
xset +dpms

if [ -r .xmodmap-`hostname -s ` ]; then
	xmodmap ~/.xmodmap-`hostname -s`
fi

XDEFAULTS_GENERAL=.Xsession
XDEFAULTS_SPECIFIC=.Xsession-`hostname`

for XDEF in $XDEFAULTS_GENERAL $XDEFAULTS_SPECIFIC; do
	xrdb -merge $XDEF
done

# ssh agent
if [ -x /usr/lib/ssh/x11-ssh-askpass ] ; then
	export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass
elif [ -x /usr/libexec/openssh/x11-ssh-askpass ] ; then
	export SSH_ASKPASS=/usr/libexec/openssh/x11-ssh-askpass
elif [ -x /usr/lib/ssh/gnome-ssh-askpass ] ; then
	export SSH_ASKPASS=/usr/lib/ssh/gnome-ssh-askpass
elif [ -x ${HOME}/libexec/x11-ssh-askpass ] ; then
	export SSH_ASKPASS=${HOME}/libexec/x11-ssh-askpass
fi

[ ! "$SSH_AGENT_PID" ] && eval `ssh-agent -s`
# - some environments (like MCS) want me to keep a lifetime on my keys.  Most
#   of the time it's just annoying
# - evidenlty on some systems (gentoo for one), programs *do* have a
#   controlling terminal when run from xinit
DISPLAY=:0 ssh-add ${SSH_AGENT_TIMEOUT} ${HOME}/.ssh/identity ${HOME}/.ssh/id_rsa ${HOME}/.ssh/id_dsa </dev/null

# extra programs: sawfish only manages windows
${HOME}/.xinitrc-`hostname -s`
(sleep 1 && gkrellm )&
(sleep 1 && lavaps ) &
exec gnome-session