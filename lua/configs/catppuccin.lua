local styles = {
    comments = { 'italic' },
    conditionals = { 'bold', 'italic' },
    loops = { 'bold', 'italic' },
    functions = { 'italic' },
    keywords = { 'bold', 'italic' },
    booleans = { 'bold' },
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
} end

return {
    flavour = 'mocha',

    styles = styles,
    color_overrides = colors,
    custom_highlights = highlights,

    default_integrations = false,
    integrations = {
        mini = { enabled = true },
    }
}
