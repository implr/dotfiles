# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

# Put your fun stuff here.

PATH="$HOME/bin/:$HOME/.local/bin/:$HOME/.cabal/bin/:${PATH}"
export EDITOR="/usr/bin/vim"
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export GOPATH=$HOME/go
export PATH="$GOPATH/bin:${PATH}"

export PATH="/opt/chefdk/bin:${PATH}"

alias shitssh="ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-dss"

. $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# The next line updates PATH for the Google Cloud SDK.
if [ -f $HOME/google-cloud-sdk/path.bash.inc ]; then
  source '$HOME/google-cloud-sdk/path.bash.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f $HOME/google-cloud-sdk/completion.bash.inc ]; then
  source '$HOME/google-cloud-sdk/completion.bash.inc'
fi
