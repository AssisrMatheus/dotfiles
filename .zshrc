#zmodload zsh/zprof

# ─── Editor ────────────────────────────────────────────────────────────────
alias vim="nvim"
alias vi="nvim"
export EDITOR="nvim"

export HOMEBREW_NO_ENV_HINTS=1

# ─── PATH ──────────────────────────────────────────────────────────────────
export PATH="/Users/assisrmatheus/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@17/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@17/include"
export PKG_CONFIG_PATH="/usr/local/opt/postgresql@17/lib/pkgconfig"

# ─── zinit (plugin manager) ────────────────────────────────────────────────
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

# Fish-like experience
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

zinit snippet OMZP::command-not-found

autoload -U compinit && compinit
zinit cdreplay -q

# ─── Prompt (starship) ─────────────────────────────────────────────────────
eval "$(starship init zsh)"

# ─── History ───────────────────────────────────────────────────────────────
HISTSIZE=10000
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

# ─── Completion styling ────────────────────────────────────────────────────
zstyle ':completion:*' matcher-list 'm:{a-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -l --color=always --icons --git $realpath 2>/dev/null || ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -l --color=always --icons --git $realpath 2>/dev/null || ls --color $realpath'

# Autosuggest: accept with Ctrl+Space
bindkey '^ ' autosuggest-accept

# ─── fzf + zoxide ──────────────────────────────────────────────────────────
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Use fd (faster, respects .gitignore) for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :200 {} 2>/dev/null || cat {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=2 --color=always --icons {} 2>/dev/null || ls -la {}'"

# History search with arrow keys (filter by current input)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ─── Env / vi mode ─────────────────────────────────────────────────────────
source ~/.zsh_env

alias nvm="fnm"
eval "$(fnm env --use-on-cd --corepack-enabled --resolve-engines --shell zsh)"

set -o vi

launchctl setenv CHROME_HEADLESS 1

# ─── Aliases ───────────────────────────────────────────────────────────────
alias ls="eza -l --icons --git -a"
alias lt="eza --tree --level=2 --long --icons --git"
alias lg="lazygit"

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'

# VSCode debug environment helpers
alias debug-on='source ~/.vscode-debug/enable-debug.sh'
alias debug-off='source ~/.vscode-debug/disable-debug.sh'
alias debug-ghostty='~/.vscode-debug/launch-ghostty.sh'
alias capture-debug='~/.vscode-debug/capture-debug-env.sh'

# ─── Functions ─────────────────────────────────────────────────────────────
# yazi: cd into the directory you exit on
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# aerospace window finder
function ff() {
  aerospace list-windows --all | fzf --bind 'enter:execute(bash -c "aerospace focus --window-id {2}")+abort'
}

# find-in-file - usage: fif <searchTerm>
fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

# ─── pnpm ──────────────────────────────────────────────────────────────────
export PNPM_HOME="/Users/assisrmatheus/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH="$HOME/Developer/bin:$PATH"

# ─── bun ───────────────────────────────────────────────────────────────────
[ -s "/Users/assisrmatheus/.bun/_bun" ] && source "/Users/assisrmatheus/.bun/_bun"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ─── Node TLS ──────────────────────────────────────────────────────────────
export NODE_EXTRA_CA_CERTS="$HOME/.mkcert-rootCA.pem"

# ─── direnv ────────────────────────────────────────────────────────────────
eval "$(direnv hook zsh)"

# ─── sentry ────────────────────────────────────────────────────────────────
fpath=("/Users/assisrmatheus/.local/share/zsh/site-functions" $fpath)

# ─── Tab key (must be last — overrides fzf-tab's own binding) ──────────────
# If an autosuggestion is showing, accept it. Otherwise run fzf-tab completion.
_tab_accept_or_complete() {
  if [[ -n "$POSTDISPLAY" ]]; then
    zle autosuggest-accept
  else
    zle fzf-tab-complete
  fi
}
zle -N _tab_accept_or_complete
bindkey '^I' _tab_accept_or_complete

#zprof
