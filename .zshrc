### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
# zinit light-mode for \
#     zdharma-continuum/zinit-annex-as-monitor \
#     zdharma-continuum/zinit-annex-bin-gem-node \
#     zdharma-continuum/zinit-annex-patch-dl \
#     zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::command-not-found
zinit snippet https://raw.githubusercontent.com/Sparragus/zsh-auto-nvm-use/refs/heads/master/zsh-auto-nvm-use.plugin.zsh

autoload -U compinit && compinit

zinit cdreplay -q

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh)"
fi

HISTSIZE=500
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Autocomplete styles
zstyle ':completion:*' matcher-list 'm:{a-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Fzf shell
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

alias l="eza -l --icons --git -a"
alias lt="eza -tree --level=2 --long --icons --git"

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

################################################

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/assisrmatheus/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Fix for s3cmd ref https://github.com/s3tools/s3cmd/issues/1349
export PATH="/Users/assisrmatheus/Library/Python/3.9/bin:$PATH"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# bun completions
[ -s "/Users/assisrmatheus/.bun/_bun" ] && source "/Users/assisrmatheus/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"