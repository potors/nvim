-- exit modes
vim.keymap.set('i', 'jk', [[<esc>]], { desc = 'Exit insert mode' })
vim.keymap.set('t', 'jk', [[<c-\><c-n>]], { desc = 'Exit terminal mode' })

-- clear visual clues
vim.keymap.set('n', '<esc>', function()
    vim.cmd.nohlsearch()
    vim.cmd.diffupdate()
end)

-- buffers
vim.keymap.set('n', '<leader>c', vim.cmd.enew, { desc = 'Create buffer' })
vim.keymap.set('n', '<leader>x', [[:bp | bd#<CR>]], { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>w', vim.cmd.write, { desc = 'Save buffer' })
vim.keymap.set('n', '<tab>', vim.cmd.bnext, { desc = 'Next buffer' })
vim.keymap.set('n', '<s-tab>', vim.cmd.bprev, { desc = 'Prev buffer' })

-- windows
vim.keymap.set('n', '<c-h>', [[<c-w><c-h>]], { desc = 'Jump to left window' })
vim.keymap.set('n', '<c-j>', [[<c-w><c-j>]], { desc = 'Jump to bottom window' })
vim.keymap.set('n', '<c-k>', [[<c-w><c-k>]], { desc = 'Jump to upper window' })
vim.keymap.set('n', '<c-l>', [[<c-w><c-l>]], { desc = 'Jump to right window' })

-- words
vim.keymap.set('n', '<leader>tu', [[m`viwU``]], { desc = 'To upper case' })
vim.keymap.set('n', '<leader>tl', [[m`viwu``]], { desc = 'To lower case' })
vim.keymap.set('n', '<leader>tt', [[m`viwu~``]], { desc = 'To title case' })

-- markdown
vim.keymap.set('v', '<leader>mt', [[:!sed 's/|/ | /g' | tr -s ' ' | column -t -s '|' -o '|'<CR>]], { desc = 'Format Markdown Table' })
