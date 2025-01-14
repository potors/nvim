return function(plugin)
    vim.keymap.set('n', [[<leader>e]], plugin.open, { desc = 'Open File Explorer' })
end
