# Ask for the administrator password upfront
sudo -v

###############################################################################
# Brew
###############################################################################

####
# Default Apps
####

echo "Installing fonts"
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask font-meslo-nerd-font
brew install --cask font-dejavu-nerd-font

brew install git-lfs

brew install tree-sitter

brew install fsouza/prettierd/prettierd

brew install ripgrep

###############################################################################
# Terminal / shell tooling
###############################################################################

# Fish-flavored zsh: prompt, autosuggestions, fuzzy finding, dir jumper, modern ls
brew install starship
brew install fzf
brew install zoxide
brew install eza
brew install fd
brew install bat
brew install fnm
brew install lazygit
brew install jesseduffield/lazydocker/lazydocker
brew install yazi

# Pretty git diffs (used by both git and lazygit as pager + mergetool)
brew install git-delta


###############################################################################
# Mac settings
###############################################################################

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
#defaults write com.apple.spaces spans-displays -bool false

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# On mission control, group apps by type
#defaults write com.apple.dock expose-group-apps -bool false

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

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

# Safari: Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
defaults write -g NSAutoFillHeuristicControllerEnabled -bool false

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
# App store: Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Disable windows opening animations observable in Google Chrome
defaults write -g NSAutomaticWindowAnimationsEnabled -bool false

# Turn off control+space hotkeys to switch input since this is used for vscode autocompletion
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

git lfs install
git lfs install --system
  
###############################################################################
# Cleanup
###############################################################################
brew cleanup
