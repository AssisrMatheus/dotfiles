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

echo "Installing vscode"
brew install --cask visual-studio-code

echo "Installing iterm2"
brew install --cask iterm2

echo "Installing docker"
brew install docker


###############################################################################
# Terminal
###############################################################################

# iterm2: Specify the preferences directory
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.iterm2"
# iterm2: Load the preferences from the directory we just set
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true

###############################################################################
# Cleanup
###############################################################################
brew cleanup
