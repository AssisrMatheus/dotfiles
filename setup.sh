# Ask for the administrator password upfront
sudo -v

###############################################################################
# Brew
###############################################################################

# Checks if brew is installed
if [[ $(command -v brew) == "" ]]; then
    echo "Installing brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Updating brew"
    brew update
fi

echo "Updating brew formulae"
brew upgrade

####
# Default Apps
####

echo "Installing fonts"
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-meslo-nerd-font
brew install --cask font-dejavu-nerd-font

echo "Installing iterm2"
brew install --cask iterm2

if [[ $(command -v docker) == "" ]]; then
    echo "Installing docker"
    brew install docker
else
    echo "Updating docker"
    brew upgrade docker
fi

if [[ $(command -v gh) == "" ]]; then
    echo "Installing gh cli"
    brew install gh
else
    echo "Updating gh cli"
    brew upgrade gh
fi

if [[ $(command -v nvm) == "" ]]; then
    echo "Installing nvm"
    brew install nvm
else
    echo "Updating nvm"
    brew upgrade nvm
fi

# Editors

if [[ $(command -v code) == "" ]]; then
    echo "Installing vscode" 
    brew install --cask visual-studio-code
else
    echo "Updating vscode"
    brew upgrade visual-studio-code
fi

# TODO check if neovim exists
echo "Installing neovim"
brew install neovim
alias vim="nvim"
alias vi="nvim"

# TODO check if tree-sitter exists
brew install tree-sitter

# TODO check if prettierd exists
brew install fsouza/prettierd/prettierd

###############################################################################
# Node
###############################################################################

nvm install --lts
nvm use --lts

npm i -g typescript@latest
npm i -g typescript-language-server@latest

###############################################################################
# Terminal
###############################################################################

# iterm2: Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"
# iterm2: Load the preferences from the directory we just set
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

###############################################################################
# Mac settings
###############################################################################

# mac: turns off dock animation
defaults write com.apple.dock autohide-time-modifier -int 0
# mac: makes it so dock appears instantly when mouse hovers
defaults write com.apple.Dock autohide-delay -float 0
# mac: resets dock to read new settings
killall Dock

# Disable the sound effects on boot
#sudo nvram SystemAudioVolume=" "

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true
# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true
# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Finder: When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Finder: Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
killall Finder

# Safari: Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
killall Safari

# App store: Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true
# App store: Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true
# App store: Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true
# App store: Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# App store: Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# App store: Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
# App store: Enable the WebKit Developer Tools in the Mac App Store
defaults write com.apple.appstore WebKitDeveloperExtras -bool true
# App store: Enable Debug Menu in the Mac App Store
defaults write com.apple.appstore ShowDebugMenu -bool true
# App store: Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# App store: Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# App store: Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1
# App store: Install System data files & security updates
#defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

###############################################################################
# Git
###############################################################################

git config --global user.email "assisr.matheus@gmail.com"
git config --global user.name "AssisrMatheus"
  
###############################################################################
# Cleanup
###############################################################################
brew cleanup
