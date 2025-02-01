return function(git) return {
    on_attach = function(buffer)
        local opts = { buffer = buffer }

        vim.keymap.set('n', ']h', function()
            if vim.wo.diff then
                vim.cmd.normal { ']h', bang = true }
                return
            end

            git.nav_hunk 'next'
        end)

        vim.keymap.set('n', '[h', function()
            if vim.wo.diff then
                vim.cmd.normal { '[h', bang = true }
                return
            end

            git.nav_hunk 'prev'
        end)

        vim.keymap.set('n', '<leader>gs', git.stage_hunk, opts)
        vim.keymap.set('n', '<leader>gr', git.reset_hunk, opts)

        vim.keymap.set('v', '<leader>gs', function() git.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, opts)
        vim.keymap.set('v', '<leader>gr', function() git.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, opts)

        vim.keymap.set('n', '<leader>gS', git.stage_buffer, opts)
        vim.keymap.set('n', '<leader>gR', git.reset_buffer, opts)

        vim.keymap.set('n', '<leader>gp', git.preview_hunk, opts)
        vim.keymap.set('n', '<leader>gi', git.preview_hunk_inline, opts)

        vim.keymap.set('n', '<leader>gb', function() git.blame_line { full = true } end, opts)
        vim.keymap.set('n', '<leader>gd', git.diffthis, opts)
        vim.keymap.set('n', '<leader>gD', function() git.diffthis '~' end, opts)

        vim.keymap.set('n', '<leader>tb', git.toggle_current_line_blame)
        vim.keymap.set('n', '<leader>td', git.toggle_deleted)
        vim.keymap.set('n', '<leader>tw', git.toggle_word_diff)
    end
} end
