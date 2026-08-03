--- Setup some plugin called _`name`_ and return it.
---
--- An optional _`opts`_ parameter can be specified.
---
--- The plugin should be available before calling this
--- function. You can use any package manager you like.
---
---   eg. [vim.pack], `lazy.nvim`, `mini.deps`, ...
---
--- The execution flow of this function is described below:
---
---   1. If _`opts`_ is a [string]:
---
---        It will attempt to [require]\(`'configs.<opts>'`\).
---
---        If a module is found, it will set _`opts`_
---        to the value returned, and [nil] otherwise.
---
---   2. If _`opts`_ is a [function]:
---
---        It will execute that [function] with the
---        plugin as first argument and update _`opts`_
---        value until it's not a [function] anymore.
---
---   3. If _`opts`_ is **false**:
---
---        The plugin will not be set up anymore.
---
---   4. If _`opts`_ still haven't became a **[table]**:
---
---        It will be set to **[nil]**.
---
--- This function returns:
---   - the `plugin`, already set up;
---   - **false** if it was _disabled_;
---   - or **[nil]** if it was _not found_.
---
---@param plugin string
---@param opts? table|function|string
---@return unknown?
local function configure(plugin, opts)
    local found, module = pcall(require, plugin)

    if opts == nil or type(opts) == 'string' then
        local config = 'configs.' .. (opts or plugin)

        local ok, result = pcall(require, config)
        if not ok then result = nil end

        opts = result or opts
    end

    if not found then
        return nil
    end

    while type(opts) == 'function' do
        opts = opts(module)
    end

    if opts == false then
        return nil
    end

    if type(opts) ~= 'table' then
        opts = nil
    end

    module.setup(opts)

    return module
end

local gh = function(repo) return 'https://github.com/' .. repo end

vim.pack.add { { src = gh 'catppuccin/nvim', name = 'catppuccin' } }
configure 'catppuccin'
vim.cmd.colorscheme 'catppuccin'

vim.pack.add { gh 'nvim-mini/mini.nvim' }
vim.notify = configure('mini.notify', {
    lsp_progress = { enable = false }
}).make_notify()

configure 'mini.icons'
configure 'mini.tabline'
configure 'mini.statusline'
configure 'mini.trailspace'

configure 'mini.pick'
configure('mini.files', function(plugin)
    vim.keymap.set('n', [[<leader>e]], plugin.open, { desc = 'Open File Explorer' })
end)

configure 'mini.ai'
configure 'mini.comment'
configure 'mini.move'
configure 'mini.surround'
configure('mini.splitjoin', {
    mappings = { toggle = 'gs' }
})

configure 'mini.clue'

vim.pack.add { gh 'jiangmiao/auto-pairs' }

vim.pack.add { gh 'nvim-treesitter/nvim-treesitter' }
configure 'nvim-treesitter'
vim.api.nvim_create_autocmd('FileType', {
    callback = function(event)
        local treesitter = require 'nvim-treesitter'

        local lang = vim.treesitter.language.get_lang(event.match)
        if not lang then return end

        local available = treesitter.get_available()
        if not vim.tbl_contains(available, lang) then return end

        treesitter.install { lang }:await(function()
            vim.treesitter.start(0, lang)
        end)
    end,
})

vim.pack.add { gh 'brenoprata10/nvim-highlight-colors' }
configure('nvim-highlight-colors', function()
    vim.lsp.document_color.enable(false)

    return {
        render = 'foreground',
        enable_tailwind = true,
    }
end)

vim.pack.add { gh 'xzbdmw/colorful-menu.nvim' }
vim.pack.add { gh 'saghen/blink.lib' }
vim.pack.add { gh 'saghen/blink.cmp' }
configure 'colorful-menu'
configure('blink.cmp', 'cmp')

vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
configure('gitsigns', 'git')

vim.pack.add { gh 'karb94/neoscroll.nvim' }
configure('neoscroll', {
    duration_multiplier = 0.35,
    easing = 'quintic',
})

-- add { source = 'mfussenegger/nvim-dap',
--     depends = {
--         'rcarriga/nvim-dap-ui',
--         'theHamsta/nvim-dap-virtual-text',
--         'nvim-neotest/nvim-nio',
--         -- 'leoluz/nvim-dap-go',
--     }
-- }
