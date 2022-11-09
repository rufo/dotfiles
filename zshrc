exists() { type "$1" > /dev/null 2>&1; }

export PATH="$PATH:$HOME/.dotfiles/bin"

# set up homebrew wherever it may exist

possible_brew_paths=( /usr/local/bin/brew /home/linuxbrew/.linuxbrew/bin/brew $HOME/.linuxbrew/bin/brew /opt/homebrew/bin/brew )
for brewpath in $possible_brew_paths; do
  if exists $brewpath; then
    eval "$($brewpath shellenv)"
    break
  fi
done

if exists brew; then
  brew_prefix_e() { test -e $HOMEBREW_PREFIX/$1 }
else
  echo "warning: homebrew not present."
  brew_prefix_e() { false }
fi

if [[ -e "/snap/bin" ]]; then
  export PATH="/snap/bin:$PATH"
fi

if brew_prefix_e /share/zsh/site-functions; then
  FPATH=$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH
fi

if exists nvim; then
  export EDITOR="nvim"
elif exists vim; then
  export EDITOR="nvim"
fi
export CLICOLOR=true
export MENU_COMPLETE=false
export BUNDLE_EDITOR=mvim

if exists batcat; then
  alias bat="batcat"
fi
if exists bat; then
  export PAGER="bat -p"
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

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
  . $HOMEBREW_PREFIX/etc/profile.d/z.sh
fi

if [[ "$unamestr" == 'Darwin' ]]; then
  PS1_COLOR="blue"
else
  PS1_COLOR="red"
fi
if [[ "$CODESPACES" == "true" ]]; then
  PS1_COLOR="green"
  PS1_HOSTNAME="  $(cat $HOME/.friendly_name)"
else
  PS1_HOSTNAME="%n@%m"
fi
PS1="%F{$PS1_COLOR}$PS1_HOSTNAME%f%(1v.%F{red}%1v%f.-)%# "

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

if ! (( $+commands[tailscale] )); then
  alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
fi

if exists fdfind; then
  alias fd="fdfind"
fi

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

whatport() {
  lsof -i :$1
}

unalias run-help &> /dev/null
autoload run-help

source "${HOME}/.iterm2_shell_integration.zsh"

# enables Erlang history
export ERL_AFLAGS="-kernel shell_history enabled"

if exists rbenv; then
  eval "$(rbenv init -)"
fi

if exists nodenv; then
  eval "$(nodenv init -)"
fi

if exists pyenv; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

if brew_prefix_e /opt/asdf/libexec/asdf.sh; then
  source $HOMEBREW_PREFIX/opt/asdf/libexec/asdf.sh
fi

# fzf via Homebrew
if brew_prefix_e /opt/fzf/shell/completion.zsh && brew_prefix_e /opt/fzf/shell/key-bindings.zsh; then
  source $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh
  source $HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh
elif [ -e /usr/share/doc/fzf/examples/key-bindings.zsh ] && [ -e /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
  source /usr/share/doc/fzf/examples/completion.zsh
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

safari-url() {
  osascript -e 'tell application "Safari" to get URL of current tab of front window'
}

if brew_prefix_e /share/zsh-autosuggestions/zsh-autosuggestions.zsh; then
  source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

export VAULT_URL="none"

if brew_prefix_e /share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh; then
  source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

declare -A replacements
replacements=( ls exa cat bat )

for command replacement in ${(kv)replacements}; do
  if exists $replacement; then
    alias $command=$replacement
  else
    echo "$replacement doesn't exist, using standard $command"
  fi
done

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

ports() {
    (
        echo 'PROC PID USER x IPV x x PROTO BIND PORT'
        (
            sudo lsof +c 15 -iTCP -sTCP:LISTEN -P -n | tail -n +2
            sudo lsof +c 15 -iUDP -P -n | tail -n +2 | egrep -v ' (127\.0\.0\.1|\[::1\]):'
        ) | sed -E 's/ ([^ ]+):/ \1 /' | sort -k8,8 -k5,5 -k1,1 -k10,10n
    ) | awk '{ printf "%-16s %-6s %-9s %-5s %-7s %s:%s\n",$1,$2,$3,$5,$8,$9,$10 }'
}
