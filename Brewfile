# frozen_string_literal: true

cask_args appdir: '/Applications'

brew 'asdf'
brew 'bat'
brew 'dokku/repo/dokku'
brew 'exa'
brew 'fd'
brew 'ffmpeg'
brew 'fzf'
brew 'gh'
brew 'git-lfs'
brew 'git'
brew 'imagemagick'
brew 'iperf'
brew 'iperf3'
brew 'jq'
brew 'mosh'
brew 'pigz'
brew 'ripgrep'
brew 'shellcheck'
brew 'tmux'
brew 'wakeonlan'
brew 'xz'
brew 'yt-dlp/taps/yt-dlp'
brew 'z'
brew 'zsh-syntax-highlighting'
brew 'zsh'

# Mac only formulae
if OS.mac?
  brew 'macvim'
  brew 'mas'
  brew 'switchaudio-osx'
  brew 'robotsandpencils/made/xcodes'
else
  brew 'vim'
end

# ASi-unclean formulae
if OS.mac? && Hardware::CPU.arm?
  # doesn't compile for ASi yet
  # but can be downloaded and run from https://github.com/koalaman/shellcheck/releases
  brew "shellcheck"
end

cask "1password"
cask "arq"
cask "iterm2"
cask "firefox"
cask "bbedit"
cask "alfred"
cask "dropbox"
cask "transmit"
cask "soulver"
cask "devonthink"
cask "screens"
cask "microsoft-office"
cask "istat-menus"
cask "steam"
cask "discord"
cask "hammerspoon"
cask "omnifocus"
cask "google-chrome"
cask "microsoft-edge"
cask "anylist"
cask "bartender"
cask "spotify"
cask "chatology"
cask "moom"
cask "visual-studio-code"
cask "acorn"
cask "dash"
cask "vlc"
cask "iina"
cask "zerotier-one"
cask "betterzip"
cask "steam"
cask "omnioutliner"
cask "obsidian"
cask "synergy"
cask "alacritty"
cask "docker"
cask "soundsource"
cask "audio-hijack"
cask "slack"
# cask "setapp" # setapp doesn't seem to install correctly?

# cask "kensington-works" # trackball works doesn't seem to exist, might need to be updated?
cask "logitech-options"

mas "Deliveries", id: 924726344
mas "Paprika Recipe Manager 3", id: 1303222628
mas "Speedtest by Ookla", id: 1153157709
mas "Bear", id: 1091189122
mas "Yoink - Improved Drag and Drop", id: 457622435
mas "DaisyDisk", id: 411643860
mas "Day One", id: 1055511498
mas "Things 3", id: 904280696
mas "Drafts", id: 1435957248
mas "Fantastical 3", id: 975937182

mas "1Blocker", id: 1365531024
mas "SmileAllDay", id: 1180442868
mas "PIPifier", id: 1160374471

# drivers that might not be needed but I wanted to save the name for
# cask "silicon-labs-vcp-driver"
