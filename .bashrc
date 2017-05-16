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
if [ -f "~/bin/vimpager" ];
then
    export PAGER="~/bin/vimpager"
    alias less=$PAGER
    alias zless=$PAGER
fi
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
export GOPATH=$HOME/go;
export PATH="$GOPATH/bin:$PATH:";

alias shitssh="ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 -oHostKeyAlgorithms=+ssh-dss"

if which ruby >/dev/null && which gem >/dev/null; then
    PATH="$(ruby -rubygems -e 'puts Gem.user_dir')/bin:$PATH"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm
