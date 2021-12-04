-- Disable indentline by default
vim.g.indentLine_enabled = false

-- Toggle indent lines
vim.api.nvim_set_keymap('n', '<leader>i', ':IndentBlanklineToggle<CR>', {noremap = true, silent = true})

-- Set indent character
vim.g.indentLine_char = "│"

-- Use treesitter
vim.g.indent_blankline_use_treesitter = true

-- Set indent color
-- vim.cmd('highlight IndentBlanklineChar guifg=#dedede gui=nocombine')
