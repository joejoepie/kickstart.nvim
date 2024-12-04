return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo', 'ConformToggle', 'ConformToggleBuffer' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    config = function()
      require('conform').setup {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable "format_on_save lsp_fallback" for languages that don't
          -- have a well standardized coding style. You can add additional
          -- languages here or re-enable it for the disabled ones.
          local disable_filetypes = { c = true, cpp = true, java = true }
          local lsp_format_opt
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end
          if disable_filetypes[vim.bo[bufnr].filetype] then
            lsp_format_opt = 'never'
          else
            lsp_format_opt = 'fallback'
          end
          return {
            timeout_ms = 500,
            lsp_format = lsp_format_opt,
          }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          -- java = { 'google-java-format' },
          yaml = { 'yamlfmt' },
          -- Conform can also run multiple formatters sequentially
          -- python = { "isort", "black" },
          --
          -- You can use 'stop_after_first' to run the first available formatter from the list
          -- javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      }
      vim.api.nvim_create_user_command('ConformToggle', function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
      end, { desc = 'Disable autoformat for current buffer' })
      vim.api.nvim_create_user_command('ConformToggleBuffer', function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
      end, { desc = 'Toggle autoformat for current buffer' })
    end,
  },
}
