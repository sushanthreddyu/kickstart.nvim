vim.pack.add {
  { src = 'https://github.com/nvim-lua/plenary.nvim' },
  { src = 'https://github.com/ThePrimeagen/harpoon', version = 'harpoon2' },
}

local harpoon = require 'harpoon'

-- 1. Setup with Branch-Aware Logic
harpoon:setup {
  settings = {
    save_on_toggle = true,
    sync_on_ui_close = true,

    -- The Secret Weapon: Override the save key to include the Git branch
    key = function()
      -- Silently ask Git for the current branch, stripping the trailing newline
      local branch = vim.fn.system('git branch --show-current 2>/dev/null'):gsub('\n', '')

      -- If we are in a Git repo, append the branch name. Otherwise, fallback to the folder path.
      if branch ~= '' then
        return vim.fn.getcwd() .. '-' .. branch
      else
        return vim.fn.getcwd()
      end
    end,
  },
}

-- ==========================================
-- OPTIMIZED HARPOON KEYMAPS
-- ==========================================

-- Add current file to Harpoon
vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end, { desc = '[A]dd to Harpoon' })

-- Toggle the Quick Menu (<C-e> is the community standard to avoid <C-m> Enter conflicts)
vim.keymap.set('n', '<C-e>', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = 'Harpoon Menu' })

-- Fast File Navigation (Using the Leader number row to avoid Visual Mode / Tmux conflicts)
vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end, { desc = 'Harpoon File 1' })
vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end, { desc = 'Harpoon File 2' })
vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end, { desc = 'Harpoon File 3' })
vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end, { desc = 'Harpoon File 4' })

-- Cycle Next/Previous (Using standard Vim bracket idioms)
vim.keymap.set('n', '[h', function() harpoon:list():prev() end, { desc = 'Previous Harpoon File' })
vim.keymap.set('n', ']h', function() harpoon:list():next() end, { desc = 'Next Harpoon File' })
