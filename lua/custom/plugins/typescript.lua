vim.pack.add {
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/pmizio/typescript-tools.nvim' },
}

require('typescript-tools').setup {
  settings = {
    separate_diagnostic_server = true,
    expose_as_code_action = 'all',
    tsserver_plugins = {},
    tsserver_max_memory = 'auto',
    complete_function_calls = true,
    publish_diagnostic_on = 'insert_leave',
    tsserver_format_options = {
      allowIncompleteCompletions = false,
      allowRenameOfImportPath = true,
    },
  },
}
