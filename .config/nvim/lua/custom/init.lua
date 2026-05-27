require 'custom.options'
require 'custom.keybinds'

-- Lower semantic token priority so treesitter injections (e.g. GraphQL in gql``) show through
vim.highlight.priorities.semantic_tokens = 75

-- File type detection for GraphQL and .env files
vim.filetype.add {
  extension = {
    graphql = 'graphql',
    gql = 'graphql',
  },
  pattern = {
    ['%.env.*'] = 'sh',
  },
}

-- Better monorepo support: lcd to nearest tsconfig/package.json
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
  callback = function()
    local root_dir = vim.fs.dirname(vim.fs.find({ 'tsconfig.json', 'package.json' }, { upward = true })[1])
    if root_dir then
      vim.cmd('lcd ' .. root_dir)
    end
  end,
})

-- Reduce LSP log verbosity
vim.lsp.log.set_level(vim.log.levels.WARN)

-- Diagnostic config overrides
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

-- Help typescript-tools find the right root in monorepos
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  callback = function(ev)
    local tsconfigs = vim.fs.find('tsconfig.json', {
      upward = true,
      path = vim.fs.dirname(vim.api.nvim_buf_get_name(ev.buf)),
      limit = math.huge,
    })

    if #tsconfigs > 0 then
      local root_dir = vim.fs.dirname(tsconfigs[1])
      local clients = vim.lsp.get_clients { bufnr = ev.buf }
      for _, client in ipairs(clients) do
        if client.name == 'typescript-tools' then
          client.config.root_dir = root_dir
        end
      end
    end
  end,
})
