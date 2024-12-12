mkdir ~/Developer

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

brew install git-lfs

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

###############################################################################
# Mac settings
###############################################################################

# Turn off mouse acceleration
defaults write .GlobalPreferences com.apple.mouse.scaling -1 defaults write -g com.apple.mouse.scaling -1

# The shortcuts are stored in NSUserKeyEquivalents dictionaries in ~/Library/Preferences/.GlobalPreferences.plist and the property lists of applications.

# Allow to drag windows by clicking in it anywhere with cmd+ctrl
defaults write -g NSWindowShouldDragOnGesture -bool true

# mac: turns off dock animation
defaults write com.apple.dock autohide-time-modifier -int 0
# mac: makes it so dock appears instantly when mouse hovers
defaults write com.apple.Dock autohide-delay -float 0

# Disable the sound effects on boot
#sudo nvram SystemAudioVolume=" "

# Makes it so fullscreen or dragging windows don't create new spaces
defaults write com.apple.spaces spans-displays -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# On mission control, group apps by type
defaults write com.apple.dock expose-group-apps -bool true

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# TODO: Find setting that turns on three finger drag on accessibility

# Makes sure to use simple quotes
defaults write NSGlobalDomain KB_SingleQuoteOption -string "'abc'"
defaults write NSGlobalDomain KB_DoubleQuoteOption -string "\"abc\""

# Set language and text formats
defaults write NSGlobalDomain AppleLanguages -array "fr-CA" "en-CA"
defaults write NSGlobalDomain AppleLocale -string "fr_CA"
defaults write NSGlobalDomain NSLinguisticDataAssetsRequested -array "en" "fr" "pt" "es" "it"
defaults write NSGlobalDomain NSLinguisticDataAssetsRequestedByChecker -array "en" "fr" "pt" "es" "it"

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
#defaults write com.apple.finder QuitMenuItem -bool true
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

# Safari: Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

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
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Turn off control+space hotkeys to switch input since this is used for vscode autocompletion
plutil -replace AppleSymbolicHotKeys.60.enabled -bool NO ~/Library/Preferences/com.apple.symbolichotkeys.plist
plutil -replace AppleSymbolicHotKeys.61.enabled -bool NO ~/Library/Preferences/com.apple.symbolichotkeys.plist
# Makes sure the hotkeys we just set take effect (disabled because it's expected the user to restart after running this script anyway)
#/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

# mac: resets dock to read new settings
killall Dock
killall Safari
killall Finder
killall SystemUIServer

###############################################################################
# Git
###############################################################################

git config --global user.email "assisr.matheus@gmail.com"
git config --global user.name "AssisrMatheus"
git lfs install
git lfs install --system
  
###############################################################################
# Cleanup
###############################################################################
brew cleanup
