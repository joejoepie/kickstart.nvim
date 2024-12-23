-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
-- local workspace_dir = vim.fn.expand '$HOME/.cache/jdtls/workspace/' .. project_name
-- local dap_dir = vim.fn.expand '$HOME/.local/share/nvim/kickstart/dap'
-- local java_debug_plugin = vim.fn.glob(dap_dir .. '/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', true)
--
-- local status, jdtls = pcall(require, 'jdtls')
-- if not status then
--   return
-- end
--
-- -- if not vim.fn.filereadable(java_debug_plugin) then
-- --   local scriptfile = vim.fn.stdpath 'config' .. 'scripts/get_java_debug.sh'
-- --   vim.fn.system('sh ' .. scriptfile .. dap_dir)
-- --   print 'JE MOEDER'
-- -- end
--
-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {
--
--     'java', -- or '/path/to/java17_or_newer/bin/java'
--     -- depends on if `java` is in your $PATH env variable and if it points to the right version.
--
--     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
--     '-Dosgi.bundles.defaultStartLevel=4',
--     '-Declipse.product=org.eclipse.jdt.ls.core.product',
--     '-Dlog.protocol=true',
--     '-Dlog.level=ALL',
--     '-Xmx1g',
--     '--add-modules=ALL-SYSTEM',
--     '--add-opens',
--     'java.base/java.util=ALL-UNNAMED',
--     '--add-opens',
--     'java.base/java.lang=ALL-UNNAMED',
--     vim.fn.expand '-javaagent:$MASON/packages/jdtls/lombok.jar',
--
--     -- 💀
--     '-jar',
--     vim.fn.glob(vim.fn.expand '$MASON/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
--     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
--     -- Must point to the                                                     Change this to
--     -- eclipse.jdt.ls installation                                           the actual version
--
--     -- 💀
--     '-configuration',
--     vim.fn.expand '$MASON/packages/jdtls/config_linux',
--     -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
--     -- Must point to the                      Change to one of `linux`, `win` or `mac`
--     -- eclipse.jdt.ls installation            Depending on your system.
--
--     -- 💀
--     -- See `data directory configuration` section in the README
--     '-data',
--     workspace_dir,
--   },
--
--   -- 💀
--   -- This is the default if not provided, you can remove it. Or adjust as needed.
--   -- One dedicated LSP server & client will be started per unique root_dir
--   --
--   -- vim.fs.root requires Neovim 0.10.
--   -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
--   -- root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' }),
--   root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]),
--
--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- for a list of options
--   settings = {
--     java = {
--       signatureHelp = { enabled = true },
--       extendedClientCapabilities = jdtls.extendedClientCapabilities,
--     },
--   },
--
--   -- Language server `initializationOptions`
--   -- You need to extend the `bundles` with paths to jar files
--   -- if you want to use additional eclipse.jdt.ls plugins.
--   --
--   -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--   --
--   -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--   init_options = {
--     bundles = {
--       vim.fn.glob(
--         vim.fn.expand '$HOME/.local/share/nvim/kickstart/dap/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
--         true
--       ),
--     },
--   },
-- }
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- require('jdtls').start_or_attach(config)
--
-- local f = io.open '.settings/launch.lua'
-- if f ~= nil then
--   f:close()
--   vim.notify('Loaded launch.lua file', vim.log.levels.INFO, nil)
--   vim.cmd ':luafile .settings/launch.lua'
-- end
-- --
-- -- local dap = require 'dap'
-- -- dap.configurations.java = {
-- --   {
-- --     projectName = 'bootstrap',
-- --     javaExec = 'java',
-- --     mainClass = 'be.vdab.rollenbeheer.LocalApplicationWithKeycloak',
-- --     env = {
-- --       TESTCONTAINERS_RYUK_DISABLED = true,
-- --     },
-- --     name = 'Custom launch LocalApplication',
-- --     request = 'launch',
-- --     type = 'java',
-- --   },
-- -- }

local init_file = io.open('.settings/init.lua', 'r')
if init_file then
  init_file:close()
else
  return
end

local dap = require 'dap'
if dap.configurations.java == nil then
  dap.configurations.java = {}
end

local function config_already_exists(configs, name)
  for _, value in ipairs(dap.configurations.java) do
    if value.name == name then
      return true
    end
  end
  return false
end

local configs = dofile '.settings/init.lua'
for _, value in ipairs(configs) do
  if not config_already_exists(dap.configurations.java, value.name) then
    table.insert(dap.configurations.java, {
      projectName = value.project,
      javaExec = 'java',
      mainClass = value.class,
      env = value.env,
      name = value.name,
      request = 'launch',
      type = 'java',
    })
    print 'Added custom dap configs'
  end
end
