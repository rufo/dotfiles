exists() { type "$1" > /dev/null 2>&1; }

export PATH="$HOME/.linuxbrew/bin:/usr/local/bin:/Users/rufo/.bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:/usr/local/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:/usr/local/share/info:$INFOPATH"
export EDITOR="vim"
export CLICOLOR=true
export MENU_COMPLETE=false
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

if exists brew; then
  Z_PATH="`brew --prefix`/etc/profile.d/z.sh"
  if [[ -e $Z_PATH ]]; then
    . $Z_PATH
  fi
fi

if [[ "$unamestr" == 'Darwin' ]]; then
  PS1_COLOR="blue"
else
  PS1_COLOR="red"
fi
PS1="%F{$PS1_COLOR}%n@%m%f%(1v.%F{red}%1v%f.-)%# "

# this lets you do things like mmv *.txt *.erb to rename all .txts to .erb
autoload -U zmv
alias mmv="noglob zmv -W"

precmd() {
  psvar=()

  vcs_info
  [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"

  # sets the tab title to current dir
  echo -ne "\e]1;${PWD##*/}\a"
}

RPS1="%F{green}%~%f @ %F{yellow}%D{%H:%M}%f"

autoload -U compinit
compinit
setopt nocorrectall

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
alias update-macvim="brew reinstall macvim --HEAD --with-override-system-vim"
alias whatwasiworkingon="git status --porcelain | cut -c 4- | xargs ls -lct"
alias whataremydogesworth="suchvalue DExEt8Y8m3aVYwLEdYdAtA2tP7mgbuzxKC"
dash(){ command open dash://$1 }
alias fixynab="sed -i .bak 's/<renderMode>direct/<renderMode>cpu/' /Applications/YNAB\ 4.app/Contents/Resources/META-INF/AIR/application.xml"
alias migrate="rake db:migrate db:rollback && rake db:migrate"
alias resetfmtrial="rm ~/Library/Application\ Support/L84577891*"
alias youtube-dl-mp4 'youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]"'
alias be='bundle exec'
alias get-sfmono='cp -R /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/* ~/Library/Fonts'

reverselookupdns(){ command dig $1 +short | xargs -J % dig -x % +short }

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
      bundle exec rake --silent --tasks | cut -d " " -f 2 > .rake_tasks
    fi
    compadd `cat .rake_tasks`
  fi
}

compdef _rake rake

if exists brew; then
  eval "$(hub alias -s)" # activate hub helper script
fi

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

unalias run-help &> /dev/null
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

# rvm-install added line:

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PM_CHEF="/Users/rufo/work/pm_chef"
export PATH=/opt/chefdk/bin:$PATH

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if exists rbenv; then
  eval "$(rbenv init -)"
fi

if exists nodenv; then
  eval "$(nodenv init -)"
fi

# fzf via Homebrew
if [ -e /usr/local/opt/fzf/shell/completion.zsh ]; then
  source /usr/local/opt/fzf/shell/key-bindings.zsh
  source /usr/local/opt/fzf/shell/completion.zsh
fi

# fzf via local installation
if [ -e ~/.fzf ]; then
  _append_to_path ~/.fzf/bin
  source ~/.fzf/shell/key-bindings.zsh
  source ~/.fzf/shell/completion.zsh
fi

# fzf + ag configuration
if exists fzf && exists rg; then
  export FZF_DEFAULT_COMMAND='rg --color never -g "" --files'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  # export FZF_DEFAULT_OPTS='
  # --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
  # --color info:108,prompt:109,spinner:108,pointer:168,marker:168
  # '
fi
