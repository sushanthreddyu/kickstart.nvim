-- Python & Django Ecosystem Configuration

-- Ensure Treesitter handles Django HTML templates correctly
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.html', '*.htm' },
  callback = function()
    -- Check if it looks like a Django template file
    local lines = vim.api.nvim_buf_get_lines(0, 0, 5, false)
    for _, line in ipairs(lines) do
      if line:match('{%%') or line:match('{{') then
        vim.opt_local.filetype = 'htmldjango'
        break
      end
    end
  end,
})
