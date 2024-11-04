return {
  {
    'gbprod/yanky.nvim',
    dependencies = {
      'kkharji/sqlite.lua',
    },
    config = function()
      require('yanky').setup {
        storage = 'sqlite',
      }

      vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(YankyPutAfter)')
      vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(YankyPutBefore)')

      vim.keymap.set('n', '<c-p>', '<Plug>(YankyPreviousEntry)')
      vim.keymap.set('n', '<c-n>', '<Plug>(YankyNextEntry)')
    end,
  },
}
