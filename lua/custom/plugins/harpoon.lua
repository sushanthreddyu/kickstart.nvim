vim.pack.add {
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'
harpoon:setup()

vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = 'Harpoon add file' })
vim.keymap.set('n', '<C-m>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon menu' })
vim.keymap.set('n', '<C-z>', function() harpoon:list():select(1) end)
vim.keymap.set('n', '<C-x>', function() harpoon:list():select(2) end)
vim.keymap.set('n', '<C-c>', function() harpoon:list():select(3) end)
vim.keymap.set('n', '<C-v>', function() harpoon:list():select(4) end)
vim.keymap.set('n', '<C-S-P>', function() harpoon:list():prev() end)
vim.keymap.set('n', '<C-S-N>', function() harpoon:list():next() end)
