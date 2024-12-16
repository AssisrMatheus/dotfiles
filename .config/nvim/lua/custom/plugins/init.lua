-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Automatically close brackets, quotes, etc
  require 'kickstart.plugins.autopairs',
  -- Explorer like file treeg
  require 'kickstart.plugins.neo-tree',
  -- {
  --   'pmizio/typescript-tools.nvim',
  --   dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  --   opts = {},
  -- },
  { 'JoosepAlviste/nvim-ts-context-commentstring', opts = { enable_autocmd = false } },
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },
  {
    {
      'zbirenbaum/copilot.lua',
      cmd = 'Copilot',
      event = 'InsertEnter',
      opts = {
        -- I don't find the panel useful.
        panel = { enabled = false },
        suggestion = {
          auto_trigger = true,
          -- Use alt to interact with Copilot.
          keymap = {
            -- Disable the built-in mapping, we'll configure it in nvim-cmp.
            accept = false,
            accept_word = '<M-w>',
            accept_line = '<M-l>',
            next = '<M-]>',
            prev = '<M-[>',
            dismiss = '/',
          },
        },
        filetypes = { markdown = true },
      },
      config = function(_, opts)
        local cmp = require 'cmp'
        local copilot = require 'copilot.suggestion'
        local luasnip = require 'luasnip'

        require('copilot').setup(opts)

        local function set_trigger(trigger)
          vim.b.copilot_suggestion_auto_trigger = trigger
          vim.b.copilot_suggestion_hidden = not trigger
        end

        -- Hide suggestions when the completion menu is open.
        cmp.event:on('menu_opened', function()
          if copilot.is_visible() then
            copilot.dismiss()
          end
          set_trigger(false)
        end)

        -- Disable suggestions when inside a snippet.
        cmp.event:on('menu_closed', function()
          set_trigger(not luasnip.expand_or_locally_jumpable())
        end)
        vim.api.nvim_create_autocmd('User', {
          pattern = { 'LuasnipInsertNodeEnter', 'LuasnipInsertNodeLeave' },
          callback = function()
            set_trigger(not luasnip.expand_or_locally_jumpable())
          end,
        })
      end,
    },
  }, -- Ai autocomplete
  {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = true,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = 'copilot',
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      'stevearc/dressing.nvim',
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      --- The below dependencies are optional,
      'hrsh7th/nvim-cmp', -- autocompletion for avante commands and mentions
      'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
      'zbirenbaum/copilot.lua', -- for providers='copilot'
      {
        -- support for image pasting
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { 'markdown', 'Avante' },
        },
        ft = { 'markdown', 'Avante' },
      },
    },
  },
  -- Auto tag on html/jsx
  {
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Auto close on trailing </
        },
        -- Also override individual filetype configs, these take priority.
        -- Empty by default, useful if one of the "opts" global settings
        -- doesn't work well in a specific filetype
        per_filetype = {
          ['html'] = {
            enable_close = false,
          },
        },
      }
    end,
  },
  -- auto saving sessions before exiting Neovim and getting back to work when you come back.
  {
    'rmagatti/auto-session',
    config = function()
      local auto_session = require 'auto-session'

      auto_session.setup {
        auto_restore_enabled = false,
        auto_session_suppress_dirs = { '~/', '~/Dev/', '~/Downloads', '~/Documents', '~/Desktop/' },
      }

      local keymap = vim.keymap

      keymap.set('n', '<leader>wr', '<cmd>SessionRestore<CR>', { desc = 'Restore session for cwd' }) -- restore last workspace session for current directory
      keymap.set('n', '<leader>ws', '<cmd>SessionSave<CR>', { desc = 'Save session for auto session root dir' }) -- save workspace session for current working directory
    end,
  },
  -- bufferline for better looking tabs
  -- {
  --   'akinsho/bufferline.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   version = '*',
  --   opts = {
  --     options = {
  --       mode = 'tabs',
  --       separator_style = 'slant',
  --     },
  --   },
  -- },
  -- Debugging
  { 'rcarriga/nvim-dap-ui', dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' } },
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    keys = {
      {
        '<leader>d',
        function()
          require('dap').toggle_breakpoint()
        end,
      },
      {
        '<leader>c',
        function()
          require('dap').continue()
        end,
      },
    },
    config = function()
      require('dapui').setup()
    end,
  },
  { 'theHamsta/nvim-dap-virtual-text', opts = {} },
  {
    'okuuva/auto-save.nvim',
    version = '^1.0.0', -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = 'ASToggle', -- optional for lazy loading on command
    event = { 'InsertLeave', 'TextChanged' }, -- optional for lazy loading on trigger events
    opts = {
      trigger_events = {
        defer_save = { 'InsertLeave' },
      },
      write_all_buffers = true,
      debounce_delay = 400,
    },
  },
  {
    'nvimtools/none-ls.nvim', -- null-ls
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          -- ESLint code actions (e.g., `eslint-disable-next-line`)
          null_ls.builtins.code_actions.eslint,

          -- Custom code action for adding @ts-ignore
          null_ls.builtins.code_actions.gitsigns.with {
            method = null_ls.methods.CODE_ACTION, -- Enable code actions
            generator = {
              fn = function(context)
                return {
                  {
                    title = 'Add @ts-ignore to ignore TypeScript error',
                    action = function()
                      local row = context.row
                      vim.api.nvim_buf_set_lines(0, row - 1, row, false, { '// @ts-ignore' })
                    end,
                  },
                }
              end,
            },
          },
        },
      }
    end,
  },
  -- {
  --   'Chaitanyabsprip/fastaction.nvim',
  --   ---@type FastActionConfig
  --   opts = {},
  -- },
}
