---@type CtpHighlightOverrideFn
local function highlights(colors)
    return {
        CursorLineNr               = { fg = colors.yellow, style = { 'bold' } },
        Visual                     = { bg = colors.surface2 },

        Number                     = { fg = colors.yellow },
        Float                      = { fg = colors.yellow },
        Boolean                    = { fg = colors.red },

        ['@property']              = { fg = colors.lavender },
        ['@type']                  = { fg = colors.yellow },
        ['@type.builtin']          = { fg = colors.yellow },
        ['@function']              = { fg = colors.blue },
        ['@function.builtin']      = { fg = colors.peach },

        Keyword                    = { fg = colors.sky },
        ['@keyword.repeat']        = { fg = colors.yellow, style = { 'bold' } },
        ['@keyword.return']        = { fg = colors.pink, style = { 'bold' } },
        ['@keyword.exception']     = { fg = colors.red, style = { 'italic' } },

        DiagnosticUnderlineError   = { sp = colors.red, style = { 'undercurl' } },
        DiagnosticUnderlineWarn    = { sp = colors.yellow, style = { 'underline' } },
        DiagnosticUnderlineInfo    = { sp = colors.sky, style = { 'underdashed' } },
        DiagnosticUnderlineHint    = { sp = colors.teal, style = { 'underline' } },

        MiniTrailspace             = { bg = colors.none, fg = colors.red, style = { 'strikethrough' } },

        MiniTablineCurrent         = { fg = colors.blue, bg = colors.none, sp = colors.blue, style = { 'bold', 'underline' } },
        MiniTablineVisible         = { fg = colors.text },
        MiniTablineHidden          = { fg = colors.overlay1, style = { 'italic' } },
        MiniTablineModifiedCurrent = { fg = colors.yellow, sp = colors.yellow, style = { 'bold', 'underline' } },
        MiniTablineModifiedVisible = { fg = colors.text, sp = colors.yellow, style = { 'underline' } },
        MiniTablineModifiedHidden  = { fg = colors.overlay1, sp = colors.yellow, style = { 'underline', 'italic' } },
        MiniTablineTabpagesection  = { fg = colors.mantle, bg = colors.blue },

        MsgArea                    = { style = { 'italic' } },
        MiniStatuslineFilename     = { fg = colors.subtext1, bg = colors.surface0 },
        MiniStatuslineFileinfo     = { bg = colors.surface1 },
        MiniStatuslineInactive     = { fg = colors.overlay2, bg = colors.surface0 },

        MiniPickBorder             = { fg = colors.overlay2 },
        MiniPickBorderBusy         = { fg = colors.maroon },
        MiniPickBorderText         = { fg = colors.blue },
        MiniPickMatchCurrent       = { fg = colors.yellow, },
        MiniPickMatchMarked        = { fg = colors.teal, style = { 'bold' } },
        MiniPickMatchRanges        = { fg = colors.green, style = { 'bold' } },
        MiniPickNormal             = { fg = colors.subtext1 },
        MiniPickPrompt             = { fg = colors.text, style = { 'italic' } },
        MiniPickPromptCaret        = { fg = colors.blue, style = { 'blink' } },
        MiniPickPromptPrefix       = { fg = colors.overlay2 },

        MiniFilesBorder            = { fg = colors.overlay1 },
        MiniFilesTitle             = { bg = colors.subtext0, fg = colors.mantle },
        MiniFilesTitleFocused      = { bg = colors.blue, fg = colors.base },
        MiniFilesDirectory         = { fg = colors.blue, style = { 'bold' } },

        BlinkCmpGhostText          = { fg = colors.overlay2 },
        BlinkCmpMenu               = { bg = colors.mantle },
        BlinkCmpMenuSelection      = { bg = colors.surface0 },
        BlinkCmpLabelDeprecated    = { style = { 'strikethrough' } },
        BlinkCmpDoc                = { bg = colors.mantle },
        BlinkCmpDocSeparator       = { fg = colors.overlay0 },

        BlinkCmpKindSnippet        = { fg = colors.mauve },
        BlinkCmpKindKeyword        = { fg = colors.sky },
        BlinkCmpKindText           = { fg = colors.teal },
        BlinkCmpKindMethod         = { fg = colors.blue },
        BlinkCmpKindConstructor    = { fg = colors.lavender },
        BlinkCmpKindFunction       = { fg = colors.blue },
        BlinkCmpKindFolder         = { fg = colors.blue },
        BlinkCmpKindModule         = { fg = colors.lavender },
        BlinkCmpKindConstant       = { fg = colors.peach },
        BlinkCmpKindField          = { fg = colors.green },
        BlinkCmpKindProperty       = { fg = colors.lavender },
        BlinkCmpKindEnum           = { fg = colors.red },
        BlinkCmpKindUnit           = { fg = colors.red },
        BlinkCmpKindClass          = { fg = colors.yellow },
        BlinkCmpKindVariable       = { fg = colors.flamingo },
        BlinkCmpKindFile           = { fg = colors.blue },
        BlinkCmpKindInterface      = { fg = colors.yellow },
        BlinkCmpKindColor          = { fg = colors.maroon },
        BlinkCmpKindReference      = { fg = colors.pink },
        BlinkCmpKindEnumMember     = { fg = colors.red },
        BlinkCmpKindStruct         = { fg = colors.yellow },
        BlinkCmpKindValue          = { fg = colors.peach },
        BlinkCmpKindEvent          = { fg = colors.blue },
        BlinkCmpKindOperator       = { fg = colors.sky },
        BlinkCmpKindTypeParameter  = { fg = colors.rosewater },
        BlinkCmpKindCopilot        = { fg = colors.teal },

        -- DapBreakpoint              = { fg = colors.red, style = { 'bold' } },
        -- DapStopped                 = { fg = colors.peach, style = { 'bold' } },
        -- NvimDapVirtualText         = { fg = colors.subtext1, style = { 'italic' } },
        -- NvimDapVirtualTextChanged  = { fg = colors.peach, style = { 'italic' } },

        ["@markup.quote"]          = { fg = colors.lavender, style = { 'italic' } },
        ["@markup.link.label"]     = { fg = colors.blue },
    }
end

---@type CatppuccinOptions
return {
    flavour = 'auto',
    background = {
        light = 'latte',
        dark = 'mocha',
    },

    transparent_background = true,

    float = {
        transparent = true,
        solid = false,
    },

    styles = {
        comments = { 'italic' },
        conditionals = { 'bold', 'italic' },
        loops = { 'bold', 'italic' },
        functions = { 'italic' },
        keywords = { 'bold' },
        booleans = { 'bold' },
        types = { 'bold' },
    },

    color_overrides = {
        mocha = {
            maroon = '#ffa5b5',
            blue = '#99ccff',
            lavender = '#c4c4ff',
        }
    },

    custom_highlights = highlights,

    default_integrations = false,
    integrations = {
        treesitter = true,
        mini = true,
        blink_cmp = true,
        telescope = true,
    },
}
