return {
  {
    'MunifTanjim/nui.nvim',
    config = function()
      local popup = require 'nui.popup'
      local event = require('nui.utils.autocmd').event

      local openLgit = function()
        local lgitPopup = popup {
          enter = true,
          border = {
            style = 'rounded',
          },
          position = '50%',
          size = {
            width = '92%',
            height = '92%',
          },
        }
        lgitPopup:mount()

        vim.api.nvim_set_current_win(lgitPopup.winid)

        vim.fn.termopen 'lazygit'
        vim.cmd 'startinsert'

        lgitPopup:on(event.BufLeave, function()
          lgitPopup:unmount()
        end)

        local close = function()
          lgitPopup:unmount()
        end

        vim.keymap.set('t', '<C-c>', close)
      end

      vim.keymap.set('n', '<leader>gg', openLgit)
    end,
  },
}
