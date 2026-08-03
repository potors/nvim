local function safe_goto_hunk(git, fallback_keys, hunk)
    return function()
        if vim.wo.diff then
            vim.cmd.normal { fallback_keys, bang = true }
            return
        end

        git.nav_hunk(hunk)
    end
end

---@param git gitsigns.actions
---@return Gitsigns.config
return function(git)
    return {
        current_line_blame = true,
        on_attach = function(buffer)
            for key, mapping in pairs {
                [']h'] = { safe_goto_hunk(git, ']h', 'next'), { desc = 'Goto Next Hunk' } },
                ['[h'] = { safe_goto_hunk(git, '[h', 'prev'), { desc = 'Goto Prev Hunk' } },

                ['<leader>gs'] = { git.stage_hunk, { desc = 'Stage Hunk' } },
                ['<leader>gr'] = { git.reset_hunk, { desc = 'Reset Hunk' } },

                ['<leader>gS'] = { git.stage_buffer, { desc = 'Stage Buffer' } },
                ['<leader>gR'] = { git.reset_buffer, { desc = 'Reset Buffer' } },

                ['<leader>gp'] = { git.preview_hunk, { desc = 'Preview Hunk' } },
                ['<leader>gi'] = { git.preview_hunk_inline, { desc = 'Preview Hunk (Inline)' } },

                ['<leader>gb'] = { function() git.blame_line { full = true } end, { desc = 'Blame Line' } },
                ['<leader>gd'] = { git.diffthis, { desc = 'Diff Buffer' } },
                ['<leader>gD'] = { function() git.diffthis '~' end, { desc = 'I dont know what it diffs actually (maybe last commit?)' } },
            } do
                ---@type unknown, unknown
                local action, opts = unpack(mapping)

                vim.keymap.set('n', key, action, vim.tbl_extend('force', opts, { buffer = buffer }))
            end
        end
    }
end
