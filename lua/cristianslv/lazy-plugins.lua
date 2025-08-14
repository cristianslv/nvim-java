require('lazy').setup({
  require 'cristianslv.plugins.nvim-treesitter',
  require 'cristianslv.plugins.todo-comments',
  require 'cristianslv.plugins.guess-indent',
  require 'cristianslv.plugins.nvim-jdtls',
  require 'cristianslv.plugins.tokyonight',
  require 'cristianslv.plugins.which-key',
  require 'cristianslv.plugins.telescope',
  require 'cristianslv.plugins.nvim-dap',
  require 'cristianslv.plugins.gitsigns',
  require 'cristianslv.plugins.copilot',
  require 'cristianslv.plugins.lualine',
  require 'cristianslv.plugins.harpoon',
  require 'cristianslv.plugins.conform',
  require 'cristianslv.plugins.lazydev',
  require 'cristianslv.plugins.blink',
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

require('guess-indent').setup {}
