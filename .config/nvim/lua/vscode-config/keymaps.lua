-- ============================================================================
-- Keymaps (VSCode branch)
-- ============================================================================
-- These mirror the terminal-nvim keymaps as closely as possible, but route the
-- *action* to a VSCode native command via `require('vscode').action()` /
-- `.call()`. The rule of thumb: same chord you already press in terminal nvim,
-- but VSCode does the work it's best at (LSP, search, explorer, git, ...).
--
-- vscode.action(cmd, opts)  -> async, fire-and-forget (most UI commands)
-- vscode.call(cmd, opts)    -> sync, when we need the result / ordering
--
-- Reference: extension README "Code navigation bindings" already maps
-- gd/gr/K/gO/=/gh and friends to VSCode natives out of the box, so we only add
-- what's missing or what differs from your terminal config.
-- ============================================================================

local ok, vscode = pcall(require, 'vscode')
if not ok then
  vim.notify('[vscode] require("vscode") failed; native command keymaps disabled', vim.log.levels.ERROR)
  return
end

local map = vim.keymap.set

--- Convenience: build a function that runs a VSCode command (async).
---@param cmd string
---@param opts table|nil
local function action(cmd, opts)
  return function() vscode.action(cmd, opts) end
end

-- ---------------------------------------------------------------------------
-- Basic
-- ---------------------------------------------------------------------------

-- Clear search highlight on <Esc> (matches terminal config).
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- ---------------------------------------------------------------------------
-- File / buffer management  (terminal: custom/keybinds.lua)
-- ---------------------------------------------------------------------------
-- <D-…> (Cmd) keys must be passed through from VSCode; see vscode/keybindings.json.

-- Save file / save all  (:w / :wa are natively supported by the extension,
-- but we keep the Cmd bindings so muscle memory matches the terminal config).
map('n', '<D-s>', action 'workbench.action.files.save', { desc = 'Save file' })
map('n', '<D-S>', action 'workbench.action.files.saveAll', { desc = 'Save all files' })

-- Close current editor  (terminal: :bd)
map('n', '<D-w>', action 'workbench.action.closeActiveEditor', { desc = 'Close editor' })

-- Close all other editors  (terminal: :%bd|e#|bd#)
map('n', '<D-S-Tab>', action 'workbench.action.closeOtherEditors', { desc = 'Close other editors' })

-- ---------------------------------------------------------------------------
-- Formatting  (terminal: conform <leader>f, eslint <leader>fp)
-- ---------------------------------------------------------------------------
map({ 'n', 'x' }, '<leader>f', action 'editor.action.formatDocument', { desc = '[F]ormat buffer' })
map('n', '<leader>fp', action 'eslint.executeAutofix', { desc = 'Format with ESLint' })

-- ---------------------------------------------------------------------------
-- Search / navigation  (terminal: telescope <leader>s…)
-- Routed to VSCode's quick-open / search, which the extension drives natively.
-- ---------------------------------------------------------------------------
map('n', '<leader>sf', action 'workbench.action.quickOpen', { desc = '[S]earch [F]iles' })
map('n', '<leader>sg', action 'workbench.action.findInFiles', { desc = '[S]earch by [G]rep' })
map('n', '<leader>sr', action 'workbench.action.openRecent', { desc = '[S]earch [R]ecent' })
map('n', '<leader>s.', action 'workbench.action.openRecent', { desc = '[S]earch Recent Files' })
map('n', '<leader>sc', action 'workbench.action.showCommands', { desc = '[S]earch [C]ommands' })
map('n', '<leader>ss', action 'workbench.action.showCommands', { desc = '[S]earch [S]elect' })
map('n', '<leader>sd', action 'workbench.actions.view.problems', { desc = '[S]earch [D]iagnostics' })
map('n', '<leader>sm', action 'workbench.view.scm', { desc = '[S]earch Git [M]odified' })
map('n', '<leader>sk', action 'workbench.action.openGlobalKeybindings', { desc = '[S]earch [K]eymaps' })

-- Search word under cursor across files  (terminal: <leader>sw grep_string)
map({ 'n', 'v' }, '<leader>sw', function()
  vscode.action('workbench.action.findInFiles', { args = { query = vim.fn.expand '<cword>' } })
end, { desc = '[S]earch current [W]ord' })

-- Fuzzy find within current buffer  (terminal: <leader>/)
map('n', '<leader>/', action 'actions.find', { desc = '[/] Search in current buffer' })

-- Buffers / open editors  (terminal: <leader><leader>)
map('n', '<leader><leader>', action 'workbench.action.showAllEditors', { desc = '[ ] Find open editors' })

-- ---------------------------------------------------------------------------
-- LSP-ish actions  (terminal: gr… / grn / gra)
-- Most g-prefixed nav (gd, gr, K, gO, gI, gy) is provided by the extension
-- already. We add rename + code action under the same chords you use.
-- ---------------------------------------------------------------------------
map('n', 'grn', action 'editor.action.rename', { desc = '[R]e[n]ame' })
map({ 'n', 'x' }, 'gra', action 'editor.action.quickFix', { desc = '[G]oto Code [A]ction' })
map('n', 'grr', action 'references-view.findReferences', { desc = '[G]oto [R]eferences' })
map('n', 'gri', action 'editor.action.goToImplementation', { desc = '[G]oto [I]mplementation' })
map('n', 'grd', action 'editor.action.revealDefinition', { desc = '[G]oto [D]efinition' })
map('n', 'grt', action 'editor.action.goToTypeDefinition', { desc = '[G]oto [T]ype Definition' })
map('n', 'grD', action 'editor.action.revealDeclaration', { desc = '[G]oto [D]eclaration' })
map('n', 'gO', action 'workbench.action.gotoSymbol', { desc = 'Document Symbols' })
map('n', 'gW', action 'workbench.action.showAllSymbols', { desc = 'Workspace Symbols' })

-- Diagnostics navigation  (terminal: [d / ]d, <leader>q)
map('n', ']d', action 'editor.action.marker.next', { desc = 'Next diagnostic' })
map('n', '[d', action 'editor.action.marker.prev', { desc = 'Prev diagnostic' })
map('n', '<leader>q', action 'workbench.actions.view.problems', { desc = 'Open diagnostics list' })

-- Toggle inlay hints  (terminal: <leader>th)
map('n', '<leader>th', action 'editor.action.toggleInlayHints', { desc = '[T]oggle Inlay [H]ints' })

-- ---------------------------------------------------------------------------
-- File explorer  (terminal: \ -> Neotree reveal)
-- ---------------------------------------------------------------------------
map('n', '\\', action 'workbench.files.action.focusFilesExplorer', { desc = 'Focus file explorer', silent = true })

-- ---------------------------------------------------------------------------
-- Git  (terminal: <leader>lg LazyGit, <leader>gd Diffview, <leader>fg)
-- VSCode's SCM view + built-in diff cover these.
-- ---------------------------------------------------------------------------
map('n', '<leader>lg', action 'workbench.view.scm', { desc = 'Git (Source Control)' })
map('n', '<leader>gd', action 'git.openChange', { desc = 'Git: open change/diff' })
map('n', '<leader>gh', action 'git.viewFileHistory', { desc = 'Git: file history' })
map('n', '<leader>fg', action 'workbench.view.scm', { desc = 'Find Git Changed Files' })

-- ---------------------------------------------------------------------------
-- Window navigation  (terminal: <C-hjkl> wincmd)
-- Route to VSCode editor-group navigation so it works with VSCode splits.
-- The control keys are forwarded by the extension's normal-mode passthrough.
-- ---------------------------------------------------------------------------
map('n', '<C-h>', action 'workbench.action.navigateLeft', { desc = 'Focus left group' })
map('n', '<C-l>', action 'workbench.action.navigateRight', { desc = 'Focus right group' })
map('n', '<C-j>', action 'workbench.action.navigateDown', { desc = 'Focus lower group' })
map('n', '<C-k>', action 'workbench.action.navigateUp', { desc = 'Focus upper group' })

-- ---------------------------------------------------------------------------
-- Multi-cursor (visual line / block) — provided by the extension's `m`
-- mappings (ma/mi/mA/mI). Nothing to add; documented here for discoverability.
-- ---------------------------------------------------------------------------
