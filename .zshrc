# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle :compinstall filename '/home/rob/.zshrc'

autoload -U compinit
compinit
# End of lines added by compinstall

for RC in ${HOME}/.zsh/*; do
	. $RC
done
