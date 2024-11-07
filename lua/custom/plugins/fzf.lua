return {
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      -- calling `setup` is optional for customization
      local fzf = require 'fzf-lua'
      fzf.setup { 'telescope' }

      vim.keymap.set('n', '<leader>sj', function()
        fzf.lsp_live_workspace_symbols { fzf_opts = { ['--layout'] = 'reverse' } }
      end, { silent = true })
    end,
  },
}
