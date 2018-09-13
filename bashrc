export CPATH=/usr/local/include

export PATH=/usr/local/bin:$PATH
# Set Knife editor
export EDITOR=vi
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\u@\h \W \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi
eval $(thefuck --alias)
export NVM_DIR="$HOME/.nvm" 
. $(brew --prefix nvm)/nvm.sh
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion 
eval "$(rbenv init -)"

PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
alias zcat=gzcat

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/ashercohen/src/content-api/node_modules/tabtab/.completions/serverless.bash ] && . /Users/ashercohen/src/content-api/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/ashercohen/src/content-api/node_modules/tabtab/.completions/sls.bash ] && . /Users/ashercohen/src/content-api/node_modules/tabtab/.completions/sls.bash
 
 export PATH="/usr/local/opt/qt@5.5/bin:$PATH"
 [[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load av    n
 
. ~/.bash_aliases.sh
