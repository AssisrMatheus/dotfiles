-- Don't require plugins here since it is done by lazy itself
require 'custom.options'
require 'custom.keybinds'

-- vim.api.nvim_create_autocmd('ModeChanged', {
--   desc = 'Format on mode change',
--   group = vim.api.nvim_create_augroup('matheus-format-on-mode-change', { clear = true }),
--   callback = function()
--     if vim.api.nvim_get_mode().mode == 'i' then
--       return
--     end
--
--     -- Organize imports for TypeScript/JavaScript files before formatting
--     local filetype = vim.bo.filetype
--     if filetype == 'typescript' or filetype == 'typescriptreact' or filetype == 'javascript' or filetype == 'javascriptreact' then
--       -- Get the organize_imports function from keybinds
--       -- local bufnr = vim.api.nvim_get_current_buf()
--       -- local filename = vim.api.nvim_buf_get_name(bufnr)
--
--       -- Remove unused imports with typescript-tools
--       local has_ts_tools, ts_api = pcall(require, 'typescript-tools.api')
--       if has_ts_tools then
--         ts_api.organize_imports(false)
--       end
--
--       -- Fix import order with ESLint, then format
--       -- vim.defer_fn(function()
--       -- local cmd = { 'npx', 'eslint', '--fix', '--fix-type', 'layout', filename }
--       -- vim.fn.jobstart(cmd, {
--       --   cwd = vim.fn.fnamemodify(filename, ':h'),
--       --   on_exit = function(_, exit_code)
--       --     if exit_code == 0 then
--       --       vim.cmd 'checktime'
--       --     end
--       --     -- Format after ESLint fixes
--       --     vim.defer_fn(function()
--       --       require('conform').format { async = true, lsp_format = 'fallback' }
--       --     end, 50)
--       --   end,
--       -- })
--       -- end, 100)
--     else
--       -- For non-JS/TS files, just format normally
--       require('conform').format { async = true, lsp_format = 'fallback' }
--     end
--   end,
-- })

-- Better monorepo support
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  callback = function()
    -- Look for the nearest tsconfig.json
    local root_dir = vim.fs.dirname(vim.fs.find({ 'tsconfig.json', 'package.json' }, { upward = true })[1])
    if root_dir then
      vim.cmd('lcd ' .. root_dir)
    end
  end,
})

-- Reduce LSP log verbosity
vim.lsp.set_log_level 'warn'

-- Increase LSP timeout for large projects
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  timeout = 5000,
})

-- Debounce diagnostics
vim.diagnostic.config {
  virtual_text = {
    source = 'if_many',
    prefix = '●',
  },
  float = {
    source = 'if_many',
  },
  update_in_insert = false,
  underline = true,
  severity_sort = true,
}

-- Better monorepo support for typescript-tools
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  callback = function(ev)
    -- Find all tsconfig.json files in the path
    local tsconfigs = vim.fs.find('tsconfig.json', {
      upward = true,
      path = vim.fs.dirname(vim.api.nvim_buf_get_name(ev.buf)),
      limit = math.huge,
    })

    -- If we found a tsconfig, notify typescript-tools
    if #tsconfigs > 0 then
      -- The first one is the closest
      local root_dir = vim.fs.dirname(tsconfigs[1])

      -- For typescript-tools, we can specify workspace folders
      local clients = vim.lsp.get_active_clients { bufnr = ev.buf }
      for _, client in ipairs(clients) do
        if client.name == 'typescript-tools' then
          -- typescript-tools handles workspace folders automatically
          -- but we can help it by setting the root
          client.config.root_dir = root_dir
        end
      end
    end
  end,
})
