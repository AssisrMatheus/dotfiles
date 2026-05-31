-- TypeScript / web-dev tooling.
--
-- These plugins are loaded eagerly by `vim.pack` (there is no lazy-loading like
-- lazy.nvim). Dependencies such as `plenary.nvim` and `nvim-lspconfig` are
-- already installed by the core sections of `init.lua`, which run first.

-- Tailwind CSS class preview, color hints, sorting, and concealing.
vim.pack.add { 'https://github.com/luckasRanarison/tailwind-tools.nvim' }
require('tailwind-tools').setup {
  server = {
    override = false, -- don't set up the LSP, it's already configured via mason (tailwindcss)
  },
}

-- GraphQL syntax highlighting in template strings and .graphql files.
vim.pack.add { 'https://github.com/jparise/vim-graphql' }

-- JSX-aware comment strings (consumed by `mini.comment`, configured in init.lua).
vim.pack.add { 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' }
require('ts_context_commentstring').setup { enable_autocmd = false }

-- Auto close/rename HTML & JSX tags.
vim.pack.add { 'https://github.com/windwp/nvim-ts-autotag' }
require('nvim-ts-autotag').setup {
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
  per_filetype = {
    ['html'] = { enable_close = false },
  },
}

-- TypeScript tooling (replaces ts_ls with better monorepo support).
vim.pack.add { 'https://github.com/pmizio/typescript-tools.nvim' }
require('typescript-tools').setup {
  settings = {
    tsserver_file_preferences = {
      includeInlayParameterNameHints = 'all',
      includeCompletionsForModuleExports = true,
      quotePreference = 'auto',
      includePackageJsonAutoImports = 'on',
      importModuleSpecifierPreference = 'shortest',
      allowIncompleteCompletions = true,
      includeCompletionsForImportStatements = true,
    },
    tsserver_format_options = {
      allowIncompleteCompletions = false,
      allowRenameOfImportPath = true,
    },
    tsserver_max_memory = 8192,
    separate_diagnostic_server = true,
    publish_diagnostic_on = 'insert_leave',
    expose_as_code_action = 'all',
    complete_function_calls = true,
  },
  handlers = {
    -- Filter out node_modules from go-to-definition results in monorepos.
    ['textDocument/definition'] = function(err, result, ctx, config)
      if vim.islist(result) and #result > 1 then
        local filtered = vim.tbl_filter(function(v) return not string.find(v.targetUri or v.uri, 'node_modules') end, result)
        if #filtered > 0 then result = filtered end
      end
      vim.lsp.handlers['textDocument/definition'](err, result, ctx, config)
    end,
  },
}
