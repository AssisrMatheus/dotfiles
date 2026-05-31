-- DAP debugging (lightweight setup; see `kickstart.plugins.debug` for a fuller one).

vim.pack.add {
  'https://github.com/mfussenegger/nvim-dap',
  'https://github.com/nvim-neotest/nvim-nio',
  'https://github.com/rcarriga/nvim-dap-ui',
  'https://github.com/theHamsta/nvim-dap-virtual-text',
}

require('dapui').setup()
require('nvim-dap-virtual-text').setup {}

local dap = require 'dap'
vim.keymap.set('n', '<leader>d', function() dap.toggle_breakpoint() end, { desc = 'DAP: toggle breakpoint' })
vim.keymap.set('n', '<leader>c', function() dap.continue() end, { desc = 'DAP: continue' })
