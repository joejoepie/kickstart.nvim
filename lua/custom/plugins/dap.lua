return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'nvim-neotest/nvim-nio',
      'williamboman/mason.nvim',
    },
    config = function()
      local dap = require 'dap'
      local ui = require 'dapui'
      local dapVl = require 'nvim-dap-virtual-text'

      ui.setup()
      dapVl.setup {}

      vim.keymap.set('n', '<leader>cdd', ui.toggle)
      vim.keymap.set('n', '<leader>cb', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })

      vim.keymap.set('n', '<F1>', ':DapContinue<CR>')
      vim.keymap.set('n', '<F2>', ':DapStepOver<CR>')
      vim.keymap.set('n', '<F3>', ':DapStepInto<CR>')
      vim.keymap.set('n', '<F4>', ':DapStepOut<CR>')
      vim.keymap.set('n', '<F4>', ':DapStepOut<CR>')

      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end

      dap.adapters['pwa-node'] = {
        type = 'server',
        host = 'localhost',
        port = '${port}',
        executable = {
          command = 'node',
          args = {
            vim.fn.expand '$HOME/.local/share/nvim/kickstart/dap/js-debug-dap-v1.95.0/js-debug/src/dapDebugServer.js',
            '${port}',
          },
        },
      }

      dap.adapters.gdb = {
        type = 'executable',
        command = 'gdb',
        args = {
          '--interpreter=dap',
          '--eval-command',
          'set print pretty on',
        },
      }

      dap.configurations.javascript = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
      }

      dap.configurations.rust = {
        {
          name = 'Launch',
          type = 'gdb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopAtBeginningOfMainSubprogram = false,
        },
      }
    end,
  },
}
