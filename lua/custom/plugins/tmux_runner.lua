-- custom/plugins/tmux_runner.lua

local function restart_celery()
  -- Replace 'your_project' with your actual Django project name.
  local celery_cmd =
    'OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES celery -A DBSolutionsServices worker  --loglevel=INFO -f celery.logs -c 10 --prefetch-multiplier=10'

  -- The Tmux Command Breakdown:
  -- '-t :=celery' looks for a window named exactly "celery" across your session
  -- 'C-c' kills the currently running worker to prevent duplicates
  -- 'Enter' ensures the prompt is clear
  -- Then it types your command and hits 'Enter' again
  local tmux_cmd = string.format("tmux send-keys -t :=celery C-c Enter '%s' Enter", celery_cmd)

  vim.fn.system(tmux_cmd)
  vim.notify('Sent Restart Signal to Celery Window', vim.log.levels.INFO)
end

-- Map this to Leader + r + c (Restart Celery)
vim.keymap.set('n', '<leader>rc', function()
  vim.cmd 'silent! write' -- Auto-save your file first
  restart_celery()
end, { desc = '[R]estart [C]elery' })
