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
# Cleanup
###############################################################################
brew cleanup
