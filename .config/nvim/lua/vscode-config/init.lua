-- ============================================================================
-- VSCode (vscode-neovim) configuration
-- ============================================================================
-- Loaded from init.lua only when `vim.g.vscode` is set, i.e. when Neovim is
-- embedded inside the vscode-neovim extension.
--
-- Philosophy:
--   * Let Neovim own everything it is best at: modal editing, motions,
--     text objects, registers, macros, dot-repeat, surround, etc.
--   * Defer to VSCode natives for everything VSCode does better and that the
--     extension already integrates: LSP, completion, file picker, search,
--     diagnostics, explorer, git, formatting, multi-cursor.
--   * Keep keymaps as close as possible to the terminal-nvim config so muscle
--     memory carries over, but route the *action* to the VSCode command.
--
-- The `require('vscode')` module is provided by the extension at runtime. We
-- access it lazily inside each mapping so this file still loads cleanly if the
-- module is ever missing.
-- ============================================================================

require 'vscode-config.options'
require 'vscode-config.plugins'
require 'vscode-config.keymaps'
