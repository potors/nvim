return {
    nested = false,
    sign = { enabled = false },
    indent = { enabled = true },
    heading = {
        -- icons = false,
        icons = { '█ ', '██ ', '███ ', '████ ', '█████ ', '██████ ' },
        -- icons = { '󰼏  ', '󰎨  ', ' 󰼑  ', '  󰎲  ', '   󰼓  ', '    󰎴  ' },
        left_pad = 1,

        position = 'inline',

        border = { true, true, true, false, false, false },
        border_virtual = true,
        border_prefix = true,
    },
    code = {
        language_border = ' ',
        language_left = '█',
        language_right = '█',
    },
    dash = {
        left_margin = 0.45,
        width = 0.9,
    },
    checkbox = {
        left_pad = 2,

        unchecked = { icon = ' 󰄱 ' },
        checked = { icon = ' 󰱒 ' },

        custom = {
            partial = { raw = '[-]', rendered = ' 󰡖 ', highlight = 'RenderMarkdownPartial', scope_highlight = nil }
        }
    },
    pipe_table = {
        preset = 'round',

        border_virtual = true,
        alignment_indicator = '═'
    },
    callout = {
        note      = { raw = '[!NOTE]',      rendered = '󰋽  Note',      highlight = 'RenderMarkdownInfo',    category = 'github'   },
        important = { raw = '[!IMPORTANT]', rendered = '󰅾  Important', highlight = 'RenderMarkdownHint',    category = 'github'   },
        warning   = { raw = '[!WARNING]',   rendered = '󰀪  Warning',   highlight = 'RenderMarkdownWarn',    category = 'github'   },
        caution   = { raw = '[!CAUTION]',   rendered = '󰳦  Caution',   highlight = 'RenderMarkdownError',   category = 'github'   },
    },
    link = {
        footnote = { icon = '' },
        image = '󰥶 ',
        email = '󰁥 ',
        hyperlink = '󰌹 ',
        wiki = { icon = ' ' },
    },
}
