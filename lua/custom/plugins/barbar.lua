return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      auto_hide = 1,
      animation = true,
      tabpages = true,
      clickable = true,
    },
  },
}
