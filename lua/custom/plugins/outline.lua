return {
  {
    'hedyhli/outline.nvim',
    opts = {
      vim.keymap.set('n', '<leader>o', ':Outline<CR>', { desc = 'Toggle outline', silent = true }),
    },
  },
}
