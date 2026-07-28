-- ============================================================================
-- Plugins (VSCode branch) — managed with the built-in `vim.pack`
-- ============================================================================
-- `vim.pack` is Neovim 0.12+'s native plugin manager. We use it here instead
-- of lazy.nvim because the VSCode branch only needs a tiny, hand-picked set of
-- *editing* plugins that run cleanly inside the embedded Neovim instance.
--
-- We deliberately DO NOT install anything that:
--   * renders decorations frequently (statuslines, indent guides, gitsigns,
--     todo-comments) — VSCode owns the UI and these cause cursor jitter,
--   * provides LSP / completion / pickers / file trees / git UIs — VSCode
--     and the extension already integrate those natively.
--
-- Kept (all are pure editing/text-object plugins):
--   * mini.nvim       -> mini.ai, mini.surround, mini.move, mini.comment
--   * nvim-ts-autotag -> auto close/rename JSX/HTML tags
--   * ts-context-commentstring -> JSX-aware `gc` comment strings
--   * vim-sleuth      -> auto-detect indentation from file contents
--   * nvim-treesitter -> parsers only, for the text objects / commentstring
--                        above (NOT highlighting — VSCode handles that)
-- ============================================================================

-- Guard: `vim.pack` requires Neovim 0.12+. If somehow unavailable, skip
-- plugins entirely rather than erroring — keymaps below still give a usable
-- experience on their own.
if not vim.pack then
  vim.notify('[vscode] vim.pack unavailable; skipping editing plugins', vim.log.levels.WARN)
  return
end

vim.pack.add {
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/JoosepAlviste/nvim-ts-context-commentstring' },
  { src = 'https://github.com/tpope/vim-sleuth' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
}

-- ---------------------------------------------------------------------------
-- ts-context-commentstring: JSX-aware comment strings, no autocmd (we feed it
-- into mini.comment below, same as the terminal config).
-- ---------------------------------------------------------------------------
local ok_ctx = pcall(require, 'ts_context_commentstring')
if ok_ctx then
  require('ts_context_commentstring').setup { enable_autocmd = false }
end

-- ---------------------------------------------------------------------------
-- mini.nvim modules — text objects, surround, move, comment.
-- These are the editing super-powers that VSCode's own Vim emulations lack,
-- and they run entirely inside Neovim so they work seamlessly here.
-- ---------------------------------------------------------------------------
local ok_mini_ai = pcall(require, 'mini.ai')
if ok_mini_ai then
  -- Better Around/Inside text objects: va), yinq, ci', ...
  require('mini.ai').setup { n_lines = 500 }
end

local ok_mini_surround = pcall(require, 'mini.surround')
if ok_mini_surround then
  -- saiw), sd', sr)' ...
  require('mini.surround').setup()
end

local ok_mini_comment = pcall(require, 'mini.comment')
if ok_mini_comment then
  -- JSX-aware commenting via ts-context-commentstring
  require('mini.comment').setup {
    options = {
      custom_commentstring = function()
        local has_ctx, ctx = pcall(require, 'ts_context_commentstring')
        if has_ctx then return ctx.calculate_commentstring() or vim.bo.commentstring end
        return vim.bo.commentstring
      end,
    },
  }
end

local ok_mini_move = pcall(require, 'mini.move')
if ok_mini_move then
  -- Move lines/selections with Cmd+Alt+hjkl (matches terminal config).
  -- NOTE: <D-M-…> must be passed through from VSCode via keybindings.json,
  -- see vscode/keybindings.json in this repo.
  require('mini.move').setup {
    mappings = {
      left = '<D-M-h>',
      right = '<D-M-l>',
      down = '<D-M-j>',
      up = '<D-M-k>',
      line_left = '<D-M-h>',
      line_right = '<D-M-l>',
      line_down = '<D-M-j>',
      line_up = '<D-M-k>',
    },
  }
end

-- ---------------------------------------------------------------------------
-- nvim-ts-autotag: auto close/rename HTML & JSX tags (same opts as terminal).
-- ---------------------------------------------------------------------------
local ok_autotag = pcall(require, 'nvim-ts-autotag')
if ok_autotag then
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
end

-- ---------------------------------------------------------------------------
-- nvim-treesitter (main branch): install parsers only.
-- We do NOT call vim.treesitter.start() for highlighting (VSCode handles
-- syntax). Parsers are still needed so mini.ai's treesitter text objects and
-- ts-context-commentstring can query the tree.
-- ---------------------------------------------------------------------------
local ok_ts, ts = pcall(require, 'nvim-treesitter')
if ok_ts then
  pcall(function()
    ts.install { 'bash', 'graphql', 'html', 'javascript', 'json', 'lua', 'markdown', 'markdown_inline', 'tsx', 'typescript' }
  end)
end
