set -o vi
export PATH="/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/mongodb/bin:$PATH:~/bin:/Users/gboruk/Documents/Development/android-sdk-mac_x86"
#export PATH=$PATH:~/bin:/usr/local/mysql/bin:/usr/local/mongodb/bin
export PS1='[\u@\h \W]\$'
export JAVA_HOME=/Library/Java/Home
export EDITOR=subl
. ~/env_scripts/.env_settings
echo BASE_DIR=$BASE_DIR
echo BASE_IPHONE_DIR=$BASE_IPHONE_DIR
edit_env ()
{
 . edit_env
}

#define alias commands
alias cdd='. /Users/gboruk/bin/cdc'
alias cdm='. /Users/gboruk/bin/go_to_models_dir'
alias cdc='. /Users/gboruk/bin/go_to_controller_dir'
alias cdv='. /Users/gboruk/bin/go_to_view_dir'
alias cdt='cd $BASE_DIR/test'
alias cdi='cd $BASE_IPHONE_DIR'
alias depo='cd ~/Dev*/depot/'
alias doc='cd ~/Dropbox/Documents/'
alias gs='git status'
alias serv='rails s'
alias tserv='rails s -p 3001 -e test'
alias unlockmdb='sudo rm -rf /usr/local/mongodb_data/mongod.lock'
alias deploy='. /Users/gboruk/bin/_deploy'
alias release_notes='git log --pretty=%s'

#test aliases
alias rcov_units='rake test:units:rcov SHOW_ONLY="app/models"'
alias rcov_func='rake test:functionals:rcov SHOW_ONLY="app"'
alias rcov_test='rake test:test:rcov SHOW_ONLY="app"'

#
# Your previous .profile  (if any) is saved as .profile.mpsaved
# Setting the path for MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
export SHELL_SESSION_HISTORY=0
