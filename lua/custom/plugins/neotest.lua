return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/neotest-jest',
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      -- {
      --   'rcasia/neotest-java',
      --   ft = 'java',
      --   dependencies = {
      --     'mfussenegger/nvim-jdtls',
      --   },
      -- },
    },
    config = function()
      local neotest = require 'neotest'
      neotest.setup {
        diagnostic = {
          enabled = true,
        },
        status = {
          enabled = true,
        },
        adapters = {
          require 'neotest-jest' {
            jestCommand = 'npm test --',
            env = { CI = true },
            cwd = function(path)
              return vim.fn.getcwd()
            end,
          },
          -- require 'neotest-java' {
          --   junit_jar = nil, -- default: stdpath("data") .. /nvim/neotest-java/junit-platform-console-standalone-[version].jar
          --   incremental_build = true,
          -- },
        },
      }
      vim.keymap.set('n', '<leader>nr', neotest.run.run, { desc = '[N]eoTest [R]un tests' })
      vim.keymap.set('n', '<leader>nd', '<cmd>lua require("neotest").run.run { strategy = "dap" }<CR>', { desc = '[N]eoTest [D]ebug tests' })
      vim.keymap.set('n', '<leader>no', neotest.output.open, { desc = '[N]eoTest test [O]utput' })
      vim.keymap.set('n', '<leader>ns', neotest.summary.toggle, { desc = '[N]eoTest [S]ummary' })
    end,
  },
}
