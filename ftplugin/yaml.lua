local lspconfig = require 'lspconfig'

local root_pattern = lspconfig.util.root_pattern 'Chart.yaml'
local root = root_pattern(vim.fn.expand '%:p')

if root then
  vim.bo.filetype = 'helm'
end
