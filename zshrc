exists() { type "$1" > /dev/null 2>&1; }

export PATH="$PATH:~/.dotfiles/bin"

# set up homebrew wherever it may exist
export PATH="/usr/local/bin:$PATH"
if [[ -e "/home/linuxbrew/.linuxbrew" ]]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
elif [[ -e "$HOME/.linuxbrew" ]]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
fi

if [[ -e "/snap/bin" ]]; then
  export PATH="/snap/bin:$PATH"
fi

if exists brew; then
  export BREW_PREFIX="$(brew --prefix)"

  export MANPATH="$BREW_PREFIX/share/man:$MANPATH"
  export INFOPATH="$BREW_PREFIX/share/info:$INFOPATH"
  FPATH=$BREW_PREFIX/share/zsh/site-functions:$FPATH
  export PATH="$BREW_PREFIX/sbin:$PATH"

  brew_prefix_e() { test -e $BREW_PREFIX/$1 }
else
  echo "warning: homebrew not present."
  brew_prefix_e() { false }
fi

if exists vim; then
  export EDITOR="vim"
fi
export CLICOLOR=true
export MENU_COMPLETE=false
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

export DOKKU_HOST=dokku.lan

autoload -Uz vcs_info

unamestr=`uname`

if brew_prefix_e /etc/profile.d/z.sh; then
  . $BREW_PREFIX/etc/profile.d/z.sh
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
alias cd..="cd .."
alias cdp="cap deploy"
alias cdpm="cap deploy:migrations"
alias o="open"
alias git-undo-commit="git reset --soft 'HEAD^'"
alias olm='$EDITOR db/migrate/`ls -t1 db/migrate | head -1`'
alias flushdns='dscacheutil -flushcache'
alias rdbd='rake db:migrate && RAILS_ENV=test rake db:migrate'
alias findswaps="find . -name '*.swp'"
alias recoverswaps="find . -name '*.swp' -exec $EDITOR -r -c DiffSaved {} \;"
alias update-macvim="brew upgrade macvim"
alias whatwasiworkingon="git status --porcelain | cut -c 4- | xargs ls -lct"
alias whataremydogesworth="suchvalue DExEt8Y8m3aVYwLEdYdAtA2tP7mgbuzxKC"
dash(){ command open dash://$1 }
alias fixynab="sed -i .bak 's/<renderMode>direct/<renderMode>cpu/' /Applications/YNAB\ 4.app/Contents/Resources/META-INF/AIR/application.xml"
alias migrate="rake db:migrate db:rollback && rake db:migrate"
alias resetfmtrial="rm ~/Library/Application\ Support/L84577891*"
alias youtube-dl-mp4='youtube-dl -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]"'
alias be='bundle exec'
alias setup-ssh='eval "$(ssh-agent)" && ssh-add'
alias fix-homebrew-ffi='echo "note, this wipes your PKG_CONFIG_PATH + LDFLAGS env vars"; export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"; export LDFLAGS="-L/usr/local/opt/libffi/lib"'

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

if exists hub; then
  eval "$(hub alias -s)" # activate hub helper script
fi

get-sfmono() {
  if [ -d /Applications/Utilities/Terminal.app ]; then
    TERMINALDIR=/Applications/Utilities/Terminal.app
  elif [ -d /System/Applications/Utilities/Terminal.app ]; then
    TERMINALDIR=/System/Applications/Utilities/Terminal.app
  else
    echo "Couldn't find a Terminal.app, bailing"
    return 1
  fi

  cp -R $TERMINALDIR/Contents/Resources/Fonts/* ~/Library/Fonts
  echo "Copied SF Mono from $TERMINALDIR"
}

unalias run-help &> /dev/null
autoload run-help

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# enables Erlang history
export ERL_AFLAGS="-kernel shell_history enabled"

if exists rbenv; then
  eval "$(rbenv init -)"
fi

if exists nodenv; then
  eval "$(nodenv init -)"
fi

if brew_prefix_e /opt/asdf/asdf.sh; then
  source $BREW_PREFIX/opt/asdf/asdf.sh
fi

# fzf via Homebrew
if brew_prefix_e /opt/fzf/shell/completion.zsh && brew_prefix_e /opt/fzf/shell/key-bindings.zsh; then
  source $BREW_PREFIX/opt/fzf/shell/key-bindings.zsh
  source $BREW_PREFIX/opt/fzf/shell/completion.zsh
fi

# fzf configuration
if exists fzf; then
  if exists fd; then
    export FZF_DEFAULT_COMMAND='fd --type file --color=always'
  elif exists rg; then
    export FZF_DEFAULT_COMMAND='rg --color always -g "" --files'
  fi

  if (( ${+FZF_DEFAULT_COMMAND} )); then
    export FZF_DEFAULT_OPTS="--ansi"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
  fi
fi

test-truecolor() {
  awk 'BEGIN{
      s="/\\/\\/\\/\\/\\"; s=s s s s s s s s;
      for (colnum = 0; colnum<77; colnum++) {
          r = 255-(colnum*255/76);
          g = (colnum*510/76);
          b = (colnum*255/76);
          if (g>255) g = 510-g;
          printf "\033[48;2;%d;%d;%dm", r,g,b;
          printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
          printf "%s\033[0m", substr(s,colnum+1,1);
      }
      printf "\n";
  }'
  echo "Colors should be smooth and not banded"
}

256-color-codes() {
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}m${i} "
  done
}

if brew_prefix_e /share/zsh-autosuggestions/zsh-autosuggestions.zsh; then
  source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

export VAULT_URL="none"

if brew_prefix_e /share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; then
  source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

declare -A replacements
replacements=( ls exa cat bat find fd )

for command replacement in ${(kv)replacements}; do
  if exists $replacement; then
    alias $command=$replacement
  else
    echo "$replacement doesn't exist, using standard $command"
  fi
done
