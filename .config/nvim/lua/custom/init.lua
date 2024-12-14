-- Don't require plugins here since it is done by lazy itself
require 'custom.options'
require 'custom.keybinds'

vim.api.nvim_create_autocmd('ModeChanged', {
  desc = 'Format on mode change',
  group = vim.api.nvim_create_augroup('matheus-format-on-mode-change', { clear = true }),
  callback = function()
    if vim.api.nvim_get_mode().mode == 'i' then
      return
    end

    require('conform').format { async = true, lsp_format = 'fallback' }
    -- if vim.bo.filetype == 'typescript' or vim.bo.filetype == 'typescriptreact' then
    --   vim.cmd 'TSLspOrganize'
    -- end
  end,
})
