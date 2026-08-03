return function(plugin)
    local pick = {
        file = plugin.builtin.files,
        grep = plugin.builtin.grep_live,
        buffer = plugin.builtin.buffers,

        git = function()
            plugin.builtin.files { tool = 'git' }
        end,
    }

    -- TODO: make better pickers ugh
    vim.keymap.set('n', '<leader>ff', pick.git, { desc = 'Find file (filtered)' })
    vim.keymap.set('n', '<leader>fa', pick.file, { desc = 'Find file (all)' })
    vim.keymap.set('n', '<leader>fw', pick.grep, { desc = 'Find word (fuzzy find)' })
    vim.keymap.set('n', '<leader>fe', pick.buffer, { desc = 'Find buffer (path)' }) -- this is lowkey good

    return {
        mappings = {
            move_down = '<c-j>',
            move_up = '<c-k>',
        },
        window = {
            config = {
                anchor = 'NW',
                width = math.floor(0.55 * vim.o.columns),
                height = math.floor(0.55 * vim.o.lines),
                col = 0,
                row = 0,
            },
            prompt_prefix = '─ ',
            prompt_caret = '_ ',
        },
    }
end
