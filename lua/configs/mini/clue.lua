return function(plugin)
    return {
        window = {
            delay = 333,

            scroll_down = '<c-j>',
            scroll_up = '<c-k>',
        },

        triggers = {
            -- Hell Yeah
            { mode = { 'n', 'x' }, keys = '<leader>' },
            { mode = { 'n', 'x' }, keys = 'g' },

            -- Next/Last
            { mode = 'n', keys = '[' },
            { mode = 'n', keys = ']' },

            -- Builtin Completion
            { mode = 'i', keys = '<c-x>' },

            -- Marks
            { mode = { 'n', 'x' }, keys = "'" },
            { mode = { 'n', 'x' }, keys = '`' },

            -- Registers
            { mode = { 'n', 'x' }, keys = '"' },
            { mode = { 'i', 'c' }, keys = '<c-r>' },

            -- Windows
            { mode = { 'n' }, keys = '<c-w>' },

            -- zzz
            { mode = { 'n', 'x' }, keys = 'z' },
        },

        clues = {
            plugin.gen_clues.g(),
            plugin.gen_clues.square_brackets(),
            plugin.gen_clues.builtin_completion(),
            plugin.gen_clues.marks(),
            plugin.gen_clues.registers(),
            plugin.gen_clues.windows(),
            plugin.gen_clues.z(),
        },
    }
end
