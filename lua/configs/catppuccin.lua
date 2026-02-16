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
    Visual = { bg = colors.surface2 },

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
    MiniTablineCurrent = { fg = colors.blue, bg = colors.none, sp = colors.blue, style = { 'bold', 'underline' } },
    MiniTablineVisible = { fg = colors.text },
    MiniTablineHidden = { fg = colors.overlay1, style = { 'italic' } },
    MiniTablineModifiedCurrent = { fg = colors.yellow, sp = colors.yellow, style = { 'bold', 'underline' } },
    MiniTablineModifiedVisible = { fg = colors.text, sp = colors.yellow, style = { 'underline' } },
    MiniTablineModifiedHidden = { fg = colors.overlay1, sp = colors.yellow, style = { 'underline', 'italic' } },
    MiniTablineTabpagesection = { fg = colors.mantle, bg = colors.blue },

    -- statusline
    MiniStatuslineFilename = { fg = colors.subtext0, bg = colors.none },
    MiniStatuslineFileinfo = { bg = colors.none },

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
    CmpItemKindSnippet     = { fg = colors.mauve },
    CmpItemKindSnippetIcon = { bg = colors.mauve, fg = colors.mantle },
    CmpItemKindKeyword     = { fg = colors.sky },
    CmpItemKindKeywordIcon = { bg = colors.sky, fg = colors.mantle },
    CmpItemKindText     = { fg = colors.teal },
    CmpItemKindTextIcon = { bg = colors.teal, fg = colors.mantle },
    CmpItemKindMethod     = { fg = colors.blue },
    CmpItemKindMethodIcon = { bg = colors.blue, fg = colors.mantle },
    CmpItemKindConstructor     = { fg = colors.lavender },
    CmpItemKindConstructorIcon = { bg = colors.lavender, fg = colors.mantle },
    CmpItemKindFunction     = { fg = colors.blue },
    CmpItemKindFunctionIcon = { bg = colors.blue, fg = colors.mantle },
    CmpItemKindFolder     = { fg = colors.blue },
    CmpItemKindFolderIcon = { bg = colors.blue, fg = colors.mantle },
    CmpItemKindModule     = { fg = colors.lavender },
    CmpItemKindModuleIcon = { bg = colors.lavender, fg = colors.mantle },
    CmpItemKindConstant     = { fg = colors.peach },
    CmpItemKindConstantIcon = { bg = colors.peach, fg = colors.mantle },
    CmpItemKindField     = { fg = colors.green },
    CmpItemKindFieldIcon = { bg = colors.green, fg = colors.mantle },
    CmpItemKindProperty     = { fg = colors.green },
    CmpItemKindPropertyIcon = { bg = colors.green, fg = colors.mantle },
    CmpItemKindEnum     = { fg = colors.red },
    CmpItemKindEnumIcon = { bg = colors.red, fg = colors.mantle },
    CmpItemKindUnit     = { fg = colors.red },
    CmpItemKindUnitIcon = { bg = colors.red, fg = colors.mantle },
    CmpItemKindClass     = { fg = colors.yellow },
    CmpItemKindClassIcon = { bg = colors.yellow, fg = colors.mantle },
    CmpItemKindVariable     = { fg = colors.flamingo },
    CmpItemKindVariableIcon = { bg = colors.flamingo, fg = colors.mantle },
    CmpItemKindFile     = { fg = colors.blue },
    CmpItemKindFileIcon = { bg = colors.blue, fg = colors.mantle },
    CmpItemKindInterface     = { fg = colors.yellow },
    CmpItemKindInterfaceIcon = { bg = colors.yellow, fg = colors.mantle },
    CmpItemKindColor     = { fg = colors.maroon },
    CmpItemKindColorIcon = { bg = colors.maroon, fg = colors.mantle },
    CmpItemKindReference     = { fg = colors.pink },
    CmpItemKindReferenceIcon = { bg = colors.pink, fg = colors.mantle },
    CmpItemKindEnumMember     = { fg = colors.red },
    CmpItemKindEnumMemberIcon = { bg = colors.red, fg = colors.mantle },
    CmpItemKindStruct     = { fg = colors.yellow },
    CmpItemKindStructIcon = { bg = colors.yellow, fg = colors.mantle },
    CmpItemKindValue     = { fg = colors.peach },
    CmpItemKindValueIcon = { bg = colors.peach, fg = colors.mantle },
    CmpItemKindEvent     = { fg = colors.blue },
    CmpItemKindEventIcon = { bg = colors.blue, fg = colors.mantle },
    CmpItemKindOperator     = { fg = colors.sky },
    CmpItemKindOperatorIcon = { bg = colors.sky, fg = colors.mantle },
    CmpItemKindTypeParameter     = { fg = colors.rosewater },
    CmpItemKindTypeParameterIcon = { bg = colors.rosewater, fg = colors.mantle },
    CmpItemKindCopilot     = { fg = colors.teal },
    CmpItemKindCopilotIcon = { bg = colors.teal, fg = colors.mantle },

    -- dap
    DapBreakpoint = { fg = colors.red, style = { 'bold' } },
    DapStopped = { fg = colors.peach, style = { 'bold' } },
    NvimDapVirtualText = { fg = colors.subtext1, style = { 'italic' } },
    NvimDapVirtualTextChanged = { fg = colors.peach, style = { 'italic' } },

    -- markdown
    RenderMarkdownH1   = { fg = colors.red },
    RenderMarkdownH1Bg = { bg = colors.base },
    RenderMarkdownH2   = { fg = colors.peach },
    RenderMarkdownH2Bg = { bg = colors.base },
    RenderMarkdownH3   = { fg = colors.yellow },
    RenderMarkdownH3Bg = { bg = colors.base },
    RenderMarkdownH4   = { fg = colors.green },
    RenderMarkdownH4Bg = { bg = colors.base },
    RenderMarkdownH5   = { fg = colors.sky },
    RenderMarkdownH5Bg = { bg = colors.base },
    RenderMarkdownH6   = { fg = colors.blue },
    RenderMarkdownH6Bg = { bg = colors.base },

    RenderMarkdownCode = { bg = colors.base },

    RenderMarkdownChecked = { fg = colors.green },
    RenderMarkdownPartial = { fg = colors.yellow },
    RenderMarkdownUnchecked = { fg = colors.red },

    ["@markup.quote"] = { fg = colors.lavender, style = { 'italic' } },

    ["@markup.link.label"] = { fg = colors.blue },
} end

return {
    flavour = 'mocha',

    transparent_background = true,

    styles = styles,
    color_overrides = colors,
    custom_highlights = highlights,

    default_integrations = false,
    integrations = {
        mini = { enabled = true },
        treesitter = true,
        cmp = true,
    },
}
