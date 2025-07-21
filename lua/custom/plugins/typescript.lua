return {
    {
        'pmizio/typescript-tools.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            'nvim-lua/plenary.nvim',
            'neovim/nvim-lspconfig',
        },
        opts = {
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
        },
    },
}
