-- ============================================================================
-- Options (VSCode branch)
-- ============================================================================
-- Most editor "look" options (relative line numbers, scrolloff, cursorline,
-- list chars, sign column, indent guides, ...) are owned by VSCode here and
-- are intentionally NOT set, per the extension's performance guidance:
-- decorators that re-render often cause cursor jitter inside VSCode.
--
-- We only keep options that affect Neovim's *editing semantics* (how motions,
-- search, undo and indentation behave), since those still run in the embedded
-- Neovim instance.
-- ============================================================================

-- Search behavior (matches terminal config)
vim.o.ignorecase = true
vim.o.smartcase = true

-- Persistent undo across sessions
vim.o.undofile = true

-- Decrease mapped sequence wait time (e.g. for `gg`, leader chords)
vim.o.timeoutlen = 300

-- Indentation defaults: 2 spaces (matches custom/options.lua).
-- VSCode controls visual rendering, but Neovim still performs `>>`, `==`,
-- auto-indent on `o`, etc., so these need to agree with the buffer.
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.softtabstop = 2

-- Use the system clipboard so y/p round-trip with VSCode and the OS.
-- Scheduled to keep startup fast (same approach as the terminal config).
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- File type detection carried over from the terminal config so that
-- GraphQL/.env filetypes are consistent (affects treesitter text objects,
-- comment strings, etc. that still run inside Neovim).
vim.filetype.add {
  extension = {
    graphql = 'graphql',
    gql = 'graphql',
  },
  pattern = {
    ['%.env.*'] = 'sh',
  },
}
