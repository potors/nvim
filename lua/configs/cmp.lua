---@param cmp blink.cmp.API
return function(cmp)
    cmp.build():pwait()

    local abort = {
        function()
            cmp.cancel()
        end,
        'fallback'
    }

    local selection = {
        preselect = false,
        auto_insert = false,
    }

    local colorful = require 'colorful-menu'
    local hlcolors = require 'nvim-highlight-colors'
    local styles = {
        label = {
            text = colorful.blink_components_text,
            highlight = colorful.blink_components_highlight,
        },

        kind_icon = {
            text = function(ctx)
                local icon = ctx.kind_icon

                local fmt = ctx.item.documentation
                local opts = { kind = ctx.kind }

                if ctx.item.source_name == 'LSP' then
                    local color = hlcolors.format(fmt, opts)
                    if color then
                        icon = color.abbr ~= ''
                            and color.abbr or icon
                    end
                end

                return icon .. ctx.icon_gap
            end,


            highlight = function(ctx)
                local hl = 'BlinkCmpKind' .. ctx.kind

                local fmt = ctx.item.documentation
                local opts = { kind = ctx.kind }

                if ctx.item.source_name == 'LSP' then
                    local color = hlcolors.format(fmt, opts)
                    if color then
                        hl = color.abbr_hl_group or hl
                    end
                end

                return hl
            end,
        },
    }

    ---@type blink.cmp.Config
    return {
        keymap = {
            preset = 'none',

            ['<esc>'] = abort,
            ['<space>'] = abort,

            ['<c-space>'] = {
                function()
                    cmp.show_signature()
                end,
                cmp.show,
                cmp.show_documentation,
                cmp.hide_documentation,
            },

            ['<tab>'] = {
                cmp.accept,
                cmp.snippet_forward,
                cmp.select_and_accept,
                'fallback'
            },

            ['<s-tab>'] = {
                cmp.snippet_backward,
                'fallback',
            },

            ['<c-j>'] = { cmp.select_next, 'fallback' },
            ['<c-k>'] = { cmp.select_prev, 'fallback' },
            ['<c-d>'] = { cmp.scroll_documentation_down, 'fallback' },
            ['<c-u>'] = { cmp.scroll_documentation_up, 'fallback' },
        },

        completion = {
            list = { selection = selection },

            accept = {
                auto_brackets = {
                    enabled = false,
                },
            },

            menu = {
                auto_show = true,

                min_width = 36,
                max_height = 7,

                draw = {
                    snippet_indicator = '%',
                    treesitter = { 'lsp' },

                    -- colorful-menu thing
                    columns = {
                        { 'kind_icon' },
                        { 'label', gap = 1 },
                    },

                    components = styles,
                }
            },

            ghost_text = {
                enabled = true,

                show_without_menu = false,
            }
        },

        cmdline = {
            keymap = {
                preset = 'inherit',

                ['<cr>'] = {
                    function()
                        cmp.accept()
                    end,
                    'fallback'
                }
            },

            completion = {
                list = { selection = selection },
                menu = { auto_show = true },

                ghost_text = { enabled = true },
            }
        },

        signature = {
            enabled = true,
        },
    }
end
