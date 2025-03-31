#!/bin/zsh

if ! command -v brew &> /dev/null; then
  echo "Error: Homebrew not found. Did you add it to the PATH?"
  exit 1
fi

brew update;



# repeated `brew install` for comments to work

brew install bat;  # better cat
brew install cask;
brew install coreutils;
brew install choose-rust;  # eg: easily get the 3rd item in each line https://github.com/theryangeary/choose
brew install difftastic;  # better git diff
brew install entr;  # do something when a file changes https://jvns.ca/blog/2020/06/28/entr/
brew install eza;  # better ls + tree with git and icons
brew install fd;  # better find https://github.com/sharkdp/fd
brew install fzf;  # filter in STDIN https://github.com/junegunn/fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install --all

brew install ffmpeg;
brew install gh;  # GitHub CLI
brew install git;  # newer version of git
brew install git-delta;  # git pager, works better for larger files as a pager than difftastic
brew install graphviz;  # turborepo uses this for visualizations
brew install imagemagick;
brew install jc;  # turn command outputs into JSON (so you can then use jq)
brew install jordanbaird-ice;  # hide items in the menu bar, better than HiddenBar?
brew install jq;  # JSON processor
brew install lnav;  # syntax highlighting log files
brew install mas;  # mac app store CLI
brew install pandoc;
brew install pgcli;
brew install pipx;  # for installing poetry
brew install pyenv;
brew install tealdeer;  # tldr in rust
tldr --update;  # initialize the tldr cache
brew install vim;
brew install wget;


brew install --cask anki;  # spaced repetition flash cards
brew install --cask clop;  # auto optimizes images, videos and PDFs
brew install --cask cursor;  # AI IDE
brew install --cask dbngin;  # UI to turn on/off databases
brew install --cask discord;
brew install --cask figma;
brew install --cask font-hack-nerd-font;  # font with icons (for eza)
brew install --cask font-jetbrains-mono;  # font with ligatures for coding
brew install --cask freedom; # App and internet blocker (freedom.to)
brew install --cask google-chrome;
brew install --cask google-drive;
brew install --cask handbrake;  # video compression
brew install --cask hyperkey;   # replace caps lock with hyper, need more -> use karabiner-elements
brew install --cask imageoptim;  # compress images
brew install --cask iterm2;
brew install --cask kap;  # screen recorder
brew install --cask karabiner-elements;  # key swapping, if just using caps lock as hyper, just use hyperkey
brew install --cask keycastr;  # record keys
brew install --cask messenger;
brew install --cask obsidian;
brew install --cask postman;
brew install --cask raycast;  # nicer app launcher/spotlight
brew install --cask rectangle;  # change window sizes, nicer than Raycast's keyboard shortcuts
brew install --cask todoist;
brew install --cask visual-studio-code;
brew install --cask vlc;
brew install --cask wechat;
brew install --cask whatsapp;
brew install --cask zoom;

mas install 6443941139; # 2FAS browser extension for Safari
mas install 1440147259; # ad guard for Safari
mas install 937984704;  # Amphetamine: keep mac working
mas install 1352778147; # BitWarden: app store version has more features, like TouchID
# mas install 1355679052; # Dropover: shake cursor when dragging files to bundle them
mas install 540348655;  # Monosnap
mas install 1122008420; # TableTool, view CSVs
mas install 1521432881; # Session (pomodoro timer)

# when brew installs postgres, need to create a postgres user manually
# https://stackoverflow.com/questions/15301826/psql-fatal-role-postgres-does-not-exist
/opt/homebrew/bin/createuser -s postgres

### Calendar
defaults write com.apple.iCal 'Default duration in minutes for new event' 30;
killall Calendar

### DOCK
# Speed up dock show/hide
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -int 0
# Dock to left
defaults write com.apple.dock orientation -string "left"
defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}';
defaults write com.apple.dock showhidden -bool TRUE;
defaults write com.apple.dock tilesize -int 36;
defaults write com.apple.dock persistent-apps -array;  # remove all the default permanent apps on the dock

# Add Chrome to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
# Add iTerm2 to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/iTerm.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
# Add Obsidian to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Obsidian.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
# Add VSCode to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Visual Studio Code.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
# Add Session to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Session.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'


# spacer tiles in the dock
defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add Messenger to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Messenger.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
# Add WeChat to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/WeChat.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
# Add WhatsApp to Dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/WhatsApp.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
# spacer tiles in the dock
defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
defaults write com.apple.dock wvous-br-corner -int 0  # remove hot corner to quickly create new note
killall Dock

### FINDER
# Path at the top of finder
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# show dotfiles in Finder
defaults write com.apple.finder AppleShowAllFiles YES;
killall Finder;


### Keyboard shortcuts

### Menu bar
# show bluetooth in menu bar
/usr/bin/defaults write com.apple.controlcenter.plist Bluetooth -int 18
killall ControlCenter

### Night Shift
defaults write com.apple.CoreBrightness CBBlueReductionSchedule -dict \
  enabled -bool true \
  start -float 20.0 \
  end -float 6.0;
killall CoreBrightness


### SAFARI
# Show the full website address in Safari's address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# Enable Safari's Develop menu and Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
killall Safari

### Screenshot
defaults write com.apple.screencapture type clipboard
killall SystemUIServer

### TRACKPAD
# increase trackpad sensitivity
defaults write -g com.apple.mouse.scaling 4.0
defaults write -g com.apple.trackpad.scaling 4.0
# Disable swipe between pages
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 0
# App Exposé: swipe down with three fingers
defaults write com.apple.dock showAppExposeGestureEnabled -bool true
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
# feedback sound when changing volume
defaults write -g com.apple.sound.beep.feedback -integer 1



# not sure if I need the following
# Tell system when Xcode utilities live:
sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer;


# install prezto
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' $@
rm -rf ~/.zprezto
rm -rf ~/.zprofile
git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
config config --local status.showUntrackedFiles no
echo 'source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"' >> ~/.zshrc
config reset --hard origin/main
touch ~/.lc_history

setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  ln -sf "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done


# install the latest stable Python version
pyenv init
LATEST_PYTHON_VERSION=$(pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$" | tail -1 | tr -d ' ')
pyenv install $LATEST_PYTHON_VERSION
pyenv global $LATEST_PYTHON_VERSION
pyenv local $LATEST_PYTHON_VERSION

pipx install poetry
poetry completions zsh > ~/.zprezto/modules/completion/external/src/_poetry
poetry self add poetry-dotenv-plugin

python -m pip install --user pipenv
python -m pip install --user ptpython  # better Python terminal CLI

# node
curl -fsSL https://fnm.vercel.app/install | bash;
fnm install --lts;
fnm default lts-latest;

npm install -g npm svgo

# create the folder if it doesn't exist
mkdir -p ~/learning
cd ~/learning
git clone git@github.com:Fullchee/notes.git
cd -

osascript -e 'tell app "System Events" to log out'
