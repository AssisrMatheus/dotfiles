-- Save current file
vim.keymap.set('n', '<D-s>', ':w<CR>', { noremap = true, silent = true, desc = 'Save file' })

-- Save all files
vim.keymap.set('n', '<D-S>', ':wa<CR>', { noremap = true, silent = true, desc = 'Save all files' })

-- Close current buffer
vim.keymap.set('n', '<D-w>', ':bd<CR>', { noremap = true, silent = true, desc = 'Close buffer' })

-- Close all other buffers
vim.keymap.set('n', '<D-S-Tab>', ':%bd|e#|bd#<CR>', { noremap = true, silent = true, desc = 'Close other buffers' })

-- Format with ESLint
vim.keymap.set('n', '<leader>fp', function()
  vim.lsp.buf.format {
    async = false,
    filter = function(client)
      return client.name == 'eslint'
    end,
  }
end, { desc = 'Format with ESLint' })

-- Find git changed files
vim.keymap.set('n', '<leader>fg', function()
  require('telescope.builtin').git_status()
end, { desc = 'Find Git Changed Files' })
