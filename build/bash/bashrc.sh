# Export 'SHELL' to child processes.
# Programs such as 'screen' honor it and otherwise use /bin/sh.
export SHELL
export LIBGL_ALWAYS_INDIRECT=1
export LANG=en_US.UTF-8
export OSH="$HOME/Resources/code/oh-my-bash"
export OSH_THEME="agnoster"
alias ls='ls --color'

# We are being invoked from a non-interactive shell.  If this
# is an SSH session (as in \"ssh host command\"), source
# /etc/profile so we get PATH and other essential variables.
if [[ $- != *i* ]]
then
[[ -n "$SSH_CLIENT" ]] && source "$GUIX_PROFILE/etc/profile"

# Don't do anything else.
return
fi

# System wide configuration and oh-my-BASH!
source /etc/bashrc
source $OSH/oh-my-bash.sh
