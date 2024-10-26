return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      view = {
        width = {},
      },
      renderer = {
        group_empty = true,
      },
      sync_root_with_cwd = true,
      vim.keymap.set('n', '<C-t>', '<cmd>NvimTreeToggle<CR>', { silent = true }),
      vim.keymap.set({ 'n', 'i' }, '<C-Y>', ':NvimTreeFindFile<CR>', { silent = true }),
      vim.keymap.set('n', '<Tab>', ':BufferNext<CR>', { silent = true }),
      vim.keymap.set('n', '<S-Tab>', ':BufferPrevious<CR>', { silent = true }),
    },
  },
}
