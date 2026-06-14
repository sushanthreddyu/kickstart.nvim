-- Java IDE via nvim-java (all-in-one: jdtls + lombok + java-test + java-debug-adapter + spring-boot-tools).
-- IMPORTANT: `require('java').setup()` must run BEFORE `vim.lsp.enable('jdtls')`, and the
-- nvim-java Mason registry must be configured (see `require('mason').setup` in init.lua SECTION 6).
-- Do NOT install nvim-jdtls alongside this; they conflict.
vim.pack.add {
  { src = 'https://github.com/JavaHello/spring-boot.nvim', version = '218c0c26c14d99feca778e4d13f5ec3e8b1b60f0' },
  { src = 'https://github.com/MunifTanjim/nui.nvim' },
  { src = 'https://github.com/mfussenegger/nvim-dap' },
  { src = 'https://github.com/nvim-java/nvim-java' },
}

require('java').setup {
  jdk = {
    -- Java 21 is already on PATH; don't let nvim-java install its own JDK.
    auto_install = false,
  },
}

vim.lsp.enable 'jdtls'
