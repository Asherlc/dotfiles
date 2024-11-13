set -a # automatically export all variables
[[ -s "$HOME/.env" ]] && source "$HOME/.env"
set +a

export CPATH=/usr/local/include

eval "$(/opt/homebrew/bin/brew shellenv)"

### Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh
### End Oh My Zsh

export PATH=/usr/local/bin:$PATH
# Set Knife editor
export EDITOR=vi

 ### pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
### end pyenv


eval $(thefuck --alias)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(rbenv init -)"

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
alias zcat=gzcat

 export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
 [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load av    n

export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

. ~/.aliases.sh
