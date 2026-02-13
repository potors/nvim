return function(cmp)
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'cmdline' },
            { name = 'path' },
        },
    })

    cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' },
        },
    })

    local snippet = require 'luasnip'

    local select = cmp.SelectBehavior.Select
    local replace = cmp.ConfirmBehavior.Replace

    return {
        snippet = {
            expand = function(args)
                snippet.lsp_expand(args.body)
            end
        },
        mapping = cmp.mapping.preset.insert({
            ['<c-space>'] = cmp.mapping.complete(),
            ['<c-e>'] = cmp.mapping.abort(),

            ['<up>'] = function(fallback) fallback() end,
            ['<down>'] = function(fallback) fallback() end,

            ['<c-j>'] = cmp.mapping.select_next_item { behavior = select },
            ['<c-k>'] = cmp.mapping.select_prev_item { behavior = select },

            ['<c-h>'] = cmp.mapping.open_docs(),
            ['<c-s-j>'] = cmp.mapping.scroll_docs(4),
            ['<c-s-k>'] = cmp.mapping.scroll_docs(-4),

            ['<tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    return cmp.mapping.confirm { select = true, behavior = replace }()
                end

                if snippet.expand_or_jumpable() then
                    return snippet.expand_or_jump()
                end

                fallback()
            end, { 'i', 's' }),

            ['<s-tab>'] = cmp.mapping(function(fallback)
                if snippet.jumpable(-1) then
                    return snippet.jump(-1)
                end

                fallback()
            end, { 'i', 's' }),
        }),
        sources = {
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
            { name = 'calc' },
        },
        window = {
            completion = cmp.config.window.bordered {
                col_offset = -3,
                side_padding = 0,
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
                border = '',
            },
            documentation = cmp.config.window.bordered {
                winhighlight = 'Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None',
            },
        },
        formatting = {
            fields = { 'icon', 'abbr', 'menu', 'kind' },
            format = require 'lspkind'.cmp_format({
                maxwidth = {
                    menu = 50,
                    abbr = 50,
                },
                ellipsis_char = '...',
                show_labelDetails = true,

                before = function(entry, item)
                    local colored = require 'nvim-highlight-colors'.format(entry, { kind = item.kind })

                    if colored.abbr_hl_group then
                        item.abbr_hl_group = colored.abbr_hl_group
                    end

                    item.icon = ' ' .. item.icon .. '  '
                    item.kind = '(' .. item.kind .. ')'

                    return item
                end
            }),
        },
        view = {
            entries = {
                name = 'custom',
            },
        },
    }
end
