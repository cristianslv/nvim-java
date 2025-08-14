return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
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
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = 'fallback',
        }
      end
    end,
    formatters = {
      ['google-java-format'] = {
        command = '/Users/cristian.silva/.sdkman/candidates/java/21.0.8-tem/bin/java',
        args = { '-jar', '/opt/homebrew/Cellar/google-java-format/1.28.0/libexec/google-java-format.jar', '-' },
        stdin = true,
      },
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      json = { 'jq' },
      terraform = { 'terraform_fmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      java = { 'google-java-format' },
    },
  },
}
