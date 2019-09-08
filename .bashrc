#!/bin/bash 

# Set Locale Variables (if system supports this - termux doesn't)
if [ -f /etc/locale.gen ]; then
	export LC_ALL=en_GB.UTF-8
	export LANG=en_GB.UTF-8
	export LANGUAGE=en_GB.UTF-8
fi

# Setup our dotconfig
alias dotconfig='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# aliases
alias lbdk-creds='. ~/lbdk/scripts/lbdk-creds.sh'
alias lbdk-cal='EDITOR="calcurse -c " lpass edit --notes calendar'
alias lbdk-gcp-instance='gcloud compute instances create debug --machine-type n1-standard-4 --image-project debian-cloud --image-family debian-9'

# source bash completion
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && . /usr/share/bash-completion/bash_completion

# Configure prompt
export PS1="♫ "

# Configure editor
export EDITOR="vim"

# Add to path
export PATH=~/.npm-global/bin:$PATH

# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "[${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	status=`git status 2>&1 | tee`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

if [ -f /.dockerenv ]; then
  export PS1="\[\e[36m\]♫\[\e[m\] \`parse_git_branch\` "
elif [ -z $SSH-TTY]; then
  export PS1="\[\e[36m\]♫\[\e[m\] \`parse_git_branch\` "
else
  export PS1="\[\e[36m\]ф\[\e[m\] \`parse_git_branch\` "
fi
export PATH=$PATH:$HOME/lbdk/scripts:$HOME/lbdk/target:/usr/local/go/bin:$HOME/.composer/vendor/bin:$HOME/.config/composer/vendor/bin


# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh
