export PATH="/usr/local/bin:/Users/rufo/.bin:/usr/local/share/npm/bin:/opt/android-sdk/tools:/opt/android-sdk/platforms/android-1.5/tools:/usr/local/libexec/git-core:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/opt/local/bin:$PATH:$HOME/.composer/vendor/bin:$PATH"
export MANPATH="/usr/local/man:/usr/local/mysql/man:$MANPATH"
export EDITOR="vim"
export CLICOLOR=true
export MENU_COMPLETE=false
export CDPATH=.:~/Dropbox/Projects:~/Projects:~/Dropbox/sandbox
export ARCHFLAGS="-arch x86_64"
export NODE_PATH="/usr/local/lib/node_modules"
export BUNDLE_EDITOR=mvim

bindkey -e

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
REPORTTIME=10
LISTMAX=0
setopt histignorespace
setopt sharehistory
setopt histexpiredupsfirst

autoload -Uz vcs_info

unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  . `brew --prefix`/etc/profile.d/z.sh
  PS1="%F{blue}rufo-mba%f%(1v.%F{red}%1v%f.-)%# "
  export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python2.7/site-packages
  export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
else
  . /home/rufo/.z.sh
  PS1="%F{red}rufo-z68%f%(1v.%F{red}%1v%f.-)%# "
fi

# this lets you do things like mmv *.txt *.erb to rename all .txts to .erb
autoload -U zmv
alias mmv="noglob zmv -W"

precmd() {
  psvar=()

  vcs_info
  [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
}

RPS1="%F{green}%~%f @ %F{yellow}%D{%H:%M}%f"

autoload -U compinit
compinit
setopt correctall

alias m="mvim"
alias m.="mvim ."
alias nt="new-terminal-tab"
alias sc="script/console"
alias sg="script/generate"
alias trt="touch tmp/restart.txt"
alias gcd='cd $(git rev-parse --show-cdup).'
alias gs="git status"
alias grh="git reset HEAD"
alias gp="git push"
alias gpl="git pull"
alias gd="git diff"
alias gdc="git diff --cached"
alias ga="git add"
alias gcam="git commit -a -m"
alias gcm="git commit -m"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias reload="source ~/.zshrc"
alias edit="$EDITOR ~/.zshrc"
alias twedit="/usr/local/bin/edit"
alias cd..="cd .."
alias cdp="cap deploy"
alias cdpm="cap deploy:migrations"
alias o="open"
alias "git-undo-commit"="git reset --soft 'HEAD^'"
alias olm='mvim db/migrate/`ls -t1 db/migrate | head -1`'
alias flushdns='dscacheutil -flushcache'
alias rdbd='rake db:migrate && RAILS_ENV=test rake db:migrate'
alias findswaps="find . -name '*.swp'"
alias recoverswaps="find . -name '*.swp' -exec $EDITOR -r -c DiffSaved {} \;"
alias update-macvim="brew reinstall macvim --HEAD --override-system-vim"
alias whatwasiworkingon="git status --porcelain | cut -c 4- | xargs ls -lct"
alias whataremydogesworth="suchvalue DExEt8Y8m3aVYwLEdYdAtA2tP7mgbuzxKC"
dash(){ command open dash://$1 }
alias fixynab="sed -i .bak 's/<renderMode>direct/<renderMode>cpu/' /Applications/YNAB\ 4.app/Contents/Resources/META-INF/AIR/application.xml"
alias migrate="rake db:migrate db:rollback && rake db:migrate"
alias resetfmtrial="rm ~/Library/Application\ Support/L84577891*"

reverselookupdns(){ command dig $1 +short | xargs -J % dig -x % +short }

# autocorrection disablement
alias vim='nocorrect vim'
alias git='nocorrect git'
alias sudo='nocorrect sudo'

git(){ if [ $1 = git ]; then shift; fi; command git "$@"; }

_rake_does_task_list_need_generating () {
  if [ ! -f .rake_tasks ]; then return 0;
  else
    accurate=$(stat -f%m .rake_tasks)
    changed=$(stat -f%m Rakefile)
    return $(expr $accurate '>=' $changed)
  fi
}

_rake () {
  if [ -f Rakefile ]; then
    if _rake_does_task_list_need_generating; then
      echo "\nGenerating .rake_tasks..." > /dev/stderr
      rake --silent --tasks | cut -d " " -f 2 > .rake_tasks
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake

eval "$(hub alias -s)" # activate hub helper script

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

# rvm-install added line:

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PM_CHEF="/Users/rufo/work/pm_chef"
export PATH=/opt/chefdk/bin:$PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
