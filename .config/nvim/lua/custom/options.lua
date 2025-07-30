-- Makes the file explorer have a tree style
vim.cmd 'let g:netrw_liststyle = 3'
vim.opt.wrap = false -- disable line wrapping
vim.opt.relativenumber = true

-- Reduce updatetime for faster diagnostics
vim.opt.updatetime = 100

-- Disable some features in large files
vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
  callback = function()
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
      vim.b.large_file = true
      vim.cmd 'syntax off'
      vim.opt_local.foldmethod = 'manual'
      vim.opt_local.spell = false
    end
  end,
})
