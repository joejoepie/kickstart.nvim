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
      update_focused_file = {
        enable = true,
      },
      vim.keymap.set('n', '<C-t>', '<cmd>NvimTreeToggle<CR>', { silent = true }),
      -- No longer necessary as we've enabled "update_focused_file"
      -- vim.keymap.set({ 'n', 'i' }, '<C-Y>', ':NvimTreeFindFile<CR>', { silent = true }),
      vim.keymap.set('n', '<Tab>', ':BufferNext<CR>', { silent = true }),
      vim.keymap.set('n', '<S-Tab>', ':BufferPrevious<CR>', { silent = true }),
    },
  },
}
