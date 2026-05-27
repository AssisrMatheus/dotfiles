return {
  -- Auto-detect indentation from file contents
  { 'tpope/vim-sleuth' },

  -- Tailwind CSS class preview, color hints, sorting, and concealing
  {
    'luckasRanarison/tailwind-tools.nvim',
    name = 'tailwind-tools',
    build = ':UpdateRemotePlugins',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {
      server = {
        override = false, -- don't set up LSP, already configured via mason
      },
    },
  },

  -- GraphQL syntax highlighting in template strings and .graphql files
  {
    'jparise/vim-graphql',
    ft = { 'graphql', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  },

  -- TypeScript tooling (replaces ts_ls with better monorepo support)
  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {
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
        -- Filter out node_modules from go-to-definition results in monorepos
        ['textDocument/definition'] = function(err, result, ctx, config)
          if vim.islist(result) and #result > 1 then
            local filtered = vim.tbl_filter(function(v)
              return not string.find(v.targetUri or v.uri, 'node_modules')
            end, result)
            if #filtered > 0 then
              result = filtered
            end
          end
          vim.lsp.handlers['textDocument/definition'](err, result, ctx, config)
        end,
      },
    },
  },

  -- JSX-aware comment strings
  { 'JoosepAlviste/nvim-ts-context-commentstring', opts = { enable_autocmd = false } },

  -- LazyGit integration
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  -- Diffview: JetBrains/Kraken-style side-by-side diffs and 3-way merge conflict UI.
  -- Used from lazygit (custom command) and as git mergetool.
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles', 'DiffviewFileHistory' },
    keys = {
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Diffview: working tree vs HEAD' },
      { '<leader>gh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Diffview: file history' },
      { '<leader>gH', '<cmd>DiffviewFileHistory<cr>', desc = 'Diffview: branch history' },
      { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Diffview: close' },
    },
    opts = {
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
    },
  },

  -- Auto close/rename HTML & JSX tags
  {
    'windwp/nvim-ts-autotag',
    config = function()
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
    end,
  },

  -- Session management
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Documents', '~/Desktop/' },
      }
      vim.keymap.set('n', '<leader>wr', '<cmd>SessionRestore<CR>', { desc = 'Restore session for cwd' })
      vim.keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { desc = 'Save session for auto session root dir' })
    end,
  },

  -- DAP Debugging
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      { '<leader>d', function() require('dap').toggle_breakpoint() end },
      { '<leader>c', function() require('dap').continue() end },
    },
    config = function()
      require('dapui').setup()
    end,
  },
  { 'theHamsta/nvim-dap-virtual-text', opts = {} },

  -- Auto-save
  {
    'okuuva/auto-save.nvim',
    version = '^1.0.0',
    cmd = 'ASToggle',
    event = { 'InsertLeave', 'TextChanged' },
    opts = {
      trigger_events = {
        defer_save = { 'InsertLeave' },
      },
      write_all_buffers = true,
      debounce_delay = 400,
    },
  },

  -- null-ls for gitsigns code actions
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require 'null-ls'
      null_ls.setup {
        sources = {
          null_ls.builtins.code_actions.gitsigns,
        },
      }
    end,
  },
}
