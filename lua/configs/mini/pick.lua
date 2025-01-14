-- centered window
local window = function()
    local width = math.floor(0.618 * vim.o.columns)
    local height = math.floor(0.618 * vim.o.lines)

    local col = math.floor(0.5 * (vim.o.columns - width))
    local row = math.floor(0.5 * (vim.o.lines - height))

    return {
        anchor = 'NW',
        width = width,
        height = height,
        col = col,
        row = row,
    }
end

return function(plugin)
    local pick = {
        file = plugin.builtin.files,
        grep = plugin.builtin.grep_live,
        buffer = plugin.builtin.buffers,

        git = function()
            plugin.builtin.files { tool = 'git' }
        end,
    }

    vim.keymap.set('n', '<leader>ff', pick.file, { desc = 'Find file' })
    vim.keymap.set('n', '<leader>fg', pick.git, { desc = 'Find file (git)' })
    vim.keymap.set('n', '<leader>fb', pick.buffer, { desc = 'Find buffer' })
    vim.keymap.set('n', '<leader>fw', pick.grep, { desc = 'Live grep' })

    return {
        window = {
            config = window,
            prompt_prefix = ' ',
        },
        mappings = {
            move_down = '<c-j>',
            move_up = '<c-k>',
        },
    }
end
