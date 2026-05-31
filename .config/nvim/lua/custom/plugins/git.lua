-- Git tooling: LazyGit, Diffview, and none-ls (for gitsigns code actions).

-- LazyGit integration.
vim.pack.add { 'https://github.com/kdheepak/lazygit.nvim' }
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

-- Diffview: JetBrains/Kraken-style side-by-side diffs and 3-way merge conflict UI.
-- Used from lazygit (custom command) and as git mergetool.
vim.pack.add { 'https://github.com/sindrets/diffview.nvim' }
require('diffview').setup {
  enhanced_diff_hl = true,
  view = {
    merge_tool = {
      layout = 'diff3_mixed', -- LOCAL | MERGED | REMOTE (JetBrains-ish)
      disable_diagnostics = true,
    },
  },
  keymaps = {
    view = {
      { 'n', '<leader>co', '<cmd>diffget //2<CR>', { desc = 'Choose OURS' } },
      { 'n', '<leader>ct', '<cmd>diffget //3<CR>', { desc = 'Choose THEIRS' } },
      { 'n', '<leader>cb', '<cmd>diffget //1<CR>', { desc = 'Choose BASE' } },
    },
  },
}
vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<cr>', { desc = 'Diffview: working tree vs HEAD' })
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', { desc = 'Diffview: file history' })
vim.keymap.set('n', '<leader>gH', '<cmd>DiffviewFileHistory<cr>', { desc = 'Diffview: branch history' })
vim.keymap.set('n', '<leader>gq', '<cmd>DiffviewClose<cr>', { desc = 'Diffview: close' })

-- none-ls: exposes gitsigns hunk actions as LSP code actions.
vim.pack.add { 'https://github.com/nvimtools/none-ls.nvim' }
local null_ls = require 'null-ls'
null_ls.setup {
  sources = {
    null_ls.builtins.code_actions.gitsigns,
  },
}
