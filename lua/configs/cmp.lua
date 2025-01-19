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
            end, { 'i', 's' })
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
            fields = { 'kind', 'abbr', 'menu' },
            format = function(entry, item)
                local fmt = require 'lspkind'.cmp_format({
                    mode = 'symbol_text',
                    max_width = 50,
                })(entry, item)

                local strings = vim.split(fmt.kind, '%s', { trimempty = true })
                fmt.kind = ' ' .. strings[1] .. ' '
                fmt.menu = '    (' .. strings[2] .. ')'

                return fmt
            end,
        },
        view = {
            entries = {
                name = 'custom',
            },
        },
    }
end
