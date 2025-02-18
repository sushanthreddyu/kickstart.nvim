return {
  {
    'mfussenegger/nvim-jdtls',
    ft = 'java', -- Load only for Java files
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap', -- Optional: For debugging
    },
    config = function()
      -- Get JDT.LS path (installed via Mason)
      local jdtls_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'
      local config_path = jdtls_path .. '/config_mac' -- macOS-specific config

      -- Setup LSP
      local config = {
        cmd = {
          'java',
          '-Declipse.application=org.eclipse.jdt.ls.core.id1',
          '-Dosgi.bundles.defaultStartLevel=4',
          '-Declipse.product=org.eclipse.jdt.ls.core.product',
          '-Dlog.protocol=true',
          '-Dlog.level=ALL',
          '-Xmx4g',
          '--add-modules=ALL-SYSTEM',
          '--add-opens',
          'java.base/java.util=ALL-UNNAMED',
          '--add-opens',
          'java.base/java.lang=ALL-UNNAMED',
          '-jar',
          vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
          '-configuration',
          config_path,
          '-data',
          vim.fn.expand '~/java-workspace/' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t'),
        },
        root_dir = require('jdtls.setup').find_root { '.git', 'build.gradle', 'pom.xml' },
        settings = {
          java = {
            configuration = {
              runtimes = {
                { name = 'JavaSE-17', path = os.getenv 'JAVA_HOME' },
              },
            },
          },
        },
        on_attach = function(client, bufnr)
          -- Keymaps
          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end
          map('n', '<leader>co', "<Cmd>lua require('jdtls').organize_imports()<CR>", 'Organize Imports')
          map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', 'Go to Definition')
          map('n', '<leader>cr', "<Cmd>lua require('jdtls').rename()<CR>", 'Rename')
        end,
      }
      require('jdtls').start_or_attach(config)
      -- After the main JDT.LS config:
      local dap = require 'dap'
      dap.configurations.java = {
        {
          type = 'java',
          request = 'launch',
          name = 'Debug (Attach)',
          projectName = 'your_project_name',
          hostName = 'localhost',
          port = 5005,
        },
      }
    end,
  },
}
