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

    -- tabline
    MiniTablineCurrent = { fg = colors.blue, sp = colors.blue, style = { 'bold', 'underline' } },
    MiniTablineVisible = { fg = colors.text },
    MiniTablineHidden = { fg = colors.overlay1, style = { 'italic' } },
    MiniTablineModifiedCurrent = { fg = colors.yellow, sp = colors.yellow, style = { 'bold', 'underline' } },
    MiniTablineModifiedVisible = { fg = colors.text, sp = colors.yellow, style = { 'underline' } },
    MiniTablineModifiedHidden = { fg = colors.overlay1, sp = colors.yellow, style = { 'underline', 'italic' } },
    MiniTablineTabpagesection = { fg = colors.mantle, bg = colors.blue },

    -- statusline
    MiniStatuslineFilename = { fg = colors.subtext0, bg = colors.none },
    MiniStatuslineFileinfo = { bg = colors.mantle },

    -- pick
    MiniPickBorder = { fg = colors.surface2 },
    MiniPickBorderBusy = { fg = colors.maroon },
    MiniPickBorderText = { fg = colors.blue },
    MiniPickPrompt = { fg = colors.text },
    MiniPickNormal = { fg = colors.subtext1 },
    MiniPickMatchRanges = { fg = colors.green },

    -- files
    MiniFilesBorder = { fg = colors.surface2 },
    MiniFilesTitle = { fg = colors.subtext1 },
    MiniFilesTitleFocused = { fg = colors.blue },

    -- cmp
    CmpItemKindSnippet = { fg = colors.mantle, bg = colors.mauve },
    CmpItemKindKeyword = { fg = colors.mantle, bg = colors.sky },
    CmpItemKindText = { fg = colors.mantle, bg = colors.teal },
    CmpItemKindMethod = { fg = colors.mantle, bg = colors.blue },
    CmpItemKindConstructor = { fg = colors.mantle, bg = colors.lavender },
    CmpItemKindFunction = { fg = colors.mantle, bg = colors.blue },
    CmpItemKindFolder = { fg = colors.mantle, bg = colors.blue },
    CmpItemKindModule = { fg = colors.mantle, bg = colors.lavender },
    CmpItemKindConstant = { fg = colors.mantle, bg = colors.peach },
    CmpItemKindField = { fg = colors.mantle, bg = colors.green },
    CmpItemKindProperty = { fg = colors.mantle, bg = colors.green },
    CmpItemKindEnum = { fg = colors.mantle, bg = colors.red },
    CmpItemKindUnit = { fg = colors.mantle, bg = colors.red },
    CmpItemKindClass = { fg = colors.mantle, bg = colors.yellow },
    CmpItemKindVariable = { fg = colors.mantle, bg = colors.flamingo },
    CmpItemKindFile = { fg = colors.mantle, bg = colors.blue },
    CmpItemKindInterface = { fg = colors.mantle, bg = colors.yellow },
    CmpItemKindColor = { fg = colors.mantle, bg = colors.maroon },
    CmpItemKindReference = { fg = colors.mantle, bg = colors.pink },
    CmpItemKindEnumMember = { fg = colors.mantle, bg = colors.red },
    CmpItemKindStruct = { fg = colors.mantle, bg = colors.yellow },
    CmpItemKindValue = { fg = colors.mantle, bg = colors.peach },
    CmpItemKindEvent = { fg = colors.mantle, bg = colors.blue },
    CmpItemKindOperator = { fg = colors.mantle, bg = colors.sky },
    CmpItemKindTypeParameter = { fg = colors.mantle, bg = colors.rosewater },
    CmpItemKindCopilot = { fg = colors.mantle, bg = colors.teal },
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
        cmp = true,
    }
}
