local styles = {
    comments = { 'italic' },
    conditionals = { 'bold', 'italic' },
    loops = { 'bold', 'italic' },
    functions = { 'italic' },
    keywords = { 'bold' },
    booleans = { 'bold' },
    types = { 'bold' },
}

local colors = {
    mocha = {
        maroon = '#ffa5b5',
        blue = '#99ccff',
        lavender = '#c4c4ff',
    }
}

local highlights = function(colors) return {
    CursorLineNr = { fg = colors.yellow },

    -- syntax
    Number = { fg = colors.yellow },
    Float = { fg = colors.yellow },
    Boolean = { fg = colors.red },

    ['@property'] = { fg = colors.lavender },

    Keyword = { fg = colors.sky },
    ['@keyword.repeat'] = { fg = colors.yellow },
    ['@keyword.return'] = { fg = colors.pink },
    ['@keyword.exception'] = { fg = colors.red },
} end

return {
    flavour = 'mocha',

    styles = styles,
    color_overrides = colors,
    custom_highlights = highlights,

    default_integrations = false,
    integrations = {
        mini = { enabled = true },
        treesitter = true,
    }
}
