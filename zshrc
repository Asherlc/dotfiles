export CPATH=/usr/local/include

export PATH=/usr/local/bin:$PATH
# Set Knife editor
export EDITOR=vi

eval $(thefuck --alias)
export NVM_DIR="$HOME/.nvm" 
. $(brew --prefix nvm)/nvm.sh
eval "$(rbenv init -)"

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
alias zcat=gzcat

 export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
 [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load av    n
 
. ~/.aliases.sh
