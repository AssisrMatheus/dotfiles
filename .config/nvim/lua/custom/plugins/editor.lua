-- General editor quality-of-life: indentation detection, sessions, auto-save.

-- Auto-detect indentation from file contents.
vim.pack.add { 'https://github.com/tpope/vim-sleuth' }

-- Session management.
vim.pack.add { 'https://github.com/rmagatti/auto-session' }
require('auto-session').setup {
  auto_restore_enabled = false,
  auto_session_suppress_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Documents', '~/Desktop/' },
}
vim.keymap.set('n', '<leader>wr', '<cmd>SessionRestore<CR>', { desc = 'Restore session for cwd' })
vim.keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { desc = 'Save session for auto session root dir' })

-- Auto-save buffers shortly after leaving insert / changing text.
vim.pack.add { { src = 'https://github.com/okuuva/auto-save.nvim', version = vim.version.range '1.*' } }
require('auto-save').setup {
  trigger_events = {
    defer_save = { 'InsertLeave' },
  },
  write_all_buffers = true,
  debounce_delay = 400,
}
