-- exit insert/terminal mode
vim.keymap.set('i', 'jk', [[<esc>]], { desc = 'Exit insert mode' })
vim.keymap.set('t', 'jk', [[<c-\><c-n>]], { desc = 'Exit terminal mode' })

-- esc clear visual clues
vim.keymap.set('n', '<esc>', function()
    vim.cmd.nohlsearch()
    vim.cmd.diffupdate()
end)

-- buffer
vim.keymap.set('n', '<leader>x', [[:bp | bd#<CR>]], { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>w', vim.cmd.write, { desc = 'Save buffer' })
vim.keymap.set('n', '<tab>', vim.cmd.bnext, { desc = 'Next buffer' })
vim.keymap.set('n', '<s-tab>', vim.cmd.bprev, { desc = 'Prev buffer' })

-- marks
vim.keymap.set('n', '\'', [[`]], { desc = 'Jump to mark on PTBR keyboard'})

-- window movement
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

-- lsp
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(cb)
        for lhs, rhs in pairs {
            ['K'] = vim.lsp.buf.hover,
            ['gD'] = vim.lsp.buf.declaration,
            ['gd'] = vim.lsp.buf.definition,
            ['gt'] = vim.lsp.buf.type_definition,
            ['gi'] = vim.lsp.buf.implementation,
            ['gh'] = vim.lsp.buf.signature_help,
            ['gr'] = vim.lsp.buf.rename,
            ['gR'] = vim.lsp.buf.references,
            ['gc'] = vim.lsp.buf.code_action,
            ['gl'] = vim.lsp.codelens.run,
            ['[d'] = vim.diagnostic.goto_prev,
            [']d'] = vim.diagnostic.goto_next,
            ['<leader>gf'] = vim.lsp.buf.format,
        } do vim.keymap.set('n', lhs, rhs, { buffer = cb.buf }) end
    end
})
