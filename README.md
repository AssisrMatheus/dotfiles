# dotfiles

![image](https://github.com/user-attachments/assets/1195d50b-6034-44f4-9e92-8e1b34b5deaf)


# Terminal setup
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts)
  ```zsh
  git clone --depth 1 --filter=blob:none git@github.com:ryanoasis/nerd-fonts fonts &&
  chmod a+rx ./fonts/install.sh && \
  ./fonts/install.sh && \
  rm -rf fonts
  ```
- [nvm](https://github.com/nvm-sh/nvm#installing-and-updating)
- [Wezterm](https://wezfurlong.org/wezterm/index.html) (waiting on [Ghostty](https://ghostty.org/))
- [zinit](https://github.com/zdharma-continuum/zinit) for plugins
- [oh-my-posh](https://ohmyposh.dev/)

# Extra tools:
- [Timewarrior](https://timewarrior.net/docs/tutorial/)
- [nushell](https://www.nushell.sh/)
- [yazi](https://github.com/sxyazi/yazi)
- [eza](https://github.com/eza-community/eza/tree/main) (aliased to ls)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide#installation) (aliased to cd)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [lazydocker](https://github.com/jesseduffield/lazydocker)

# Neovim plugins:
- Telescope
- Trouble
- Zenmode+twilight
- mason for lsps

## Resources
Some places where I ~~copy~~get inspiration from 
- https://github.com/craftzdog/dotfiles-public
- https://github.com/wbthomason/dotfiles/blob/linux/neovim/.config/nvim/lua/plugins.lua
- https://driesvints.com/blog/getting-started-with-dotfiles/
- https://jogendra.dev/i-do-dotfiles
- https://dotfiles.github.io/
- https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb
