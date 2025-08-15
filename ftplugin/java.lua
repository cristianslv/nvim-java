-- If you started neovim within `~/dev/xy/project-1` this would resolve to `project-1`
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/Users/cristian.silva/jdtls_workspace/' .. project_name
--                                               ^^
--                                               string concattenation in Lua

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    '/Users/cristian.silva/.sdkman/candidates/java/21.0.8-tem/bin/java', -- or '/path/to/java21_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    '-javaagent:' .. vim.fn.expand '~/Downloads/lombok.jar',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens',
    'java.base/java.util=ALL-UNNAMED',
    '--add-opens',
    'java.base/java.lang=ALL-UNNAMED',

    -- 💀
    '-jar',
    '/opt/homebrew/Cellar/jdtls/1.49.0/libexec/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar',
    -- '/path/to/jdtls_install_location/plugins/org.eclipse.equinox.launcher_VERSION_NUMBER.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    '-configuration',
    '/opt/homebrew/Cellar/jdtls/1.49.0/libexec/config_mac_arm',
    -- '/path/to/jdtls_install_location/config_SYSTEM',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    '-data',
    workspace_dir,
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  --
  -- vim.fs.root requires Neovim 0.10.
  -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  root_dir = vim.fs.root(0, { '.git', 'mvnw', 'gradlew', 'pom.xml' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-11',
            path = '/Users/cristian.silva/.sdkman/candidates/java/11.0.23-amzn/',
          },
          {
            name = 'JavaSE-21',
            path = '/Users/cristian.silva/.sdkman/candidates/java/21.0.8-tem/',
          },
        },
        compile = {
          nullAnalysis = { enabled = true },
        },
        contentProvider = { preferred = 'fernflower' },
        configuration = { updateBuildConfiguration = 'automatic' },
      },
      compile = {
        annotationProcessing = {
          enabled = true,
        },
      },
      completion = {
        importOrder = { 'java', 'javax', 'org', 'com' },
      },
      showUnimplementedMethods = true,
      maven = { downloadSources = true },
      nullAnalysis = {
        reportPotentialNullProblems = true,
        reportExplicitNulls = true,
      },
      contentAssist = {
        guessMethodArguments = true,
      },
    },
  },
}

-- Language server `initializationOptions`
-- You need to extend the `bundles` with paths to jar files
-- if you want to use additional eclipse.jdt.ls plugins.
--
-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--
-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
local bundles = {
  vim.fn.glob('~/contaazul/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar', true),
}
vim.list_extend(bundles, vim.split(vim.fn.glob('~/contaazul/vscode-java-test/server/*.jar', true), '\n'))
config['init_options'] = {
  bundles = bundles,
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
require('jdtls').setup_dap { hotcodereplace = 'auto' }
