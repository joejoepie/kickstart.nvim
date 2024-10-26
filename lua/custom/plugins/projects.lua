return {
  {
    'coffebar/neovim-project',
    opts = {
      projects = { -- define project roots
        '~/IdeaProjects/*',
      },
      picker = {
        type = 'telescope', -- or "fzf-lua"
      },
      last_session_on_startup = false,
    },
    init = function()
      -- enable saving the state of plugins in the session
      -- vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
      vim.keymap.set('n', '<leader>ww', '<cmd>NeovimProjectDiscover<CR>', { desc = 'Select out of all project' })
      vim.keymap.set('n', '<leader>wh', '<cmd>NeovimProjectHistory<CR>', { desc = 'Select out of project history' })
    end,
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      -- optional picker
      { 'nvim-telescope/telescope.nvim' },
      -- optional picker
      { 'ibhagwan/fzf-lua' },
      { 'Shatur/neovim-session-manager' },
    },
    lazy = false,
    priority = 100,
  },
}
