-- Tree style file explorer (netrw)
vim.cmd 'let g:netrw_liststyle = 3'
vim.opt.wrap = false
vim.opt.relativenumber = true

-- Default indentation: 2 spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

-- Faster diagnostics / CursorHold
vim.opt.updatetime = 100

-- Disable heavy features in large files
vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
  callback = function()
    local max_filesize = 100 * 1024 -- 100 KB
    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(0))
    if ok and stats and stats.size > max_filesize then
      vim.b.large_file = true
      vim.cmd 'syntax off'
      vim.opt_local.foldmethod = 'manual'
      vim.opt_local.spell = false
    end
  end,
})
