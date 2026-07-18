-- bootstrap

vim.loader.enable()

local site = vim.fn.stdpath 'data' .. '/site'
local mini = site .. '/pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/nvim-mini/mini.nvim', mini
    }

    vim.cmd 'packadd mini.nvim | helptags ALL'
end
require 'mini.deps'.setup {
    path = { package = site }
}

-- internals

-- setup plugin cleverly then return it
--
-- returns nil if plugin not found
--
-- opts can be nil/string/table/function
--   opts = function -> retrieve function result until it decays to nil/table
--   opts = string -> treated and imported as module until it decays to nil/table/function
--   opts = nil/table -> call .setup() accordingly
--
-- opts can also be false, in this case the plugin will be ignored
--
-- opts may start as nil, in this case a module with the same
-- name as the plugin will try to load, then the logic above
local function configure(name, opts)
    local found, plugin = pcall(require, name)

    -- search for module if opts = nil
    if opts == nil or type(opts) == 'string' then
        local ok, result = pcall(require, 'configs.' .. (opts or name))
        opts = ok and result or opts
    end

    -- if plugin doesn't exists, ignore
    if not found then
        return nil
    end

    -- decay function outputs
    while type(opts) == 'function' do
        opts = opts(plugin)
    end

    if opts == false then
        return nil
    end

    -- opts needs to be a table at setup time. if don't, ignore
    if type(opts) ~= 'table' then
        opts = nil
    end

    -- setup plugin and return it
    plugin.setup(opts)
    return plugin
end

-- plugins

local add = MiniDeps.add

MiniDeps.now(function()
    vim.notify = configure('mini.notify').make_notify()

    add { source = 'catppuccin/nvim', name = 'catppuccin' }
    configure('catppuccin')
    vim.cmd.colorscheme 'catppuccin'

    configure('mini.icons')

    configure('mini.tabline')
    configure('mini.statusline')

    add { source = 'hrsh7th/cmp-nvim-lsp' }

    add { source = 'mfussenegger/nvim-dap',
        depends = {
            'rcarriga/nvim-dap-ui',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-neotest/nvim-nio',
            -- 'leoluz/nvim-dap-go',
        }
    }

    configure('dap')

    -- configure('nvim-dap-virtual-text', {
    --     virt_text_pos = 'eol',
    --     virt_text_win_col = 66,
    -- })
end)

MiniDeps.later(function()
    add { source = 'nvim-treesitter/nvim-treesitter', name = 'treesitter',
        hooks = {
            post_checkout = function()
                vim.cmd 'TSUpdate'
            end
        }
    }

    configure('nvim-treesitter', 'treesitter')

    configure('mini.ai')
    configure('mini.comment')
    configure('mini.surround')
    configure('mini.trailspace')
    configure('mini.move')
    configure('mini.pairs')

    configure('mini.pick')
    configure('mini.files')

    add { source = 'hrsh7th/nvim-cmp',
        depends = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-calc',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',

            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',

            'onsails/lspkind.nvim',
            'brenoprata10/nvim-highlight-colors'
        }
    }

    configure('nvim-highlight-colors', {
        render = 'foreground',
        enable_tailwind = true
    })

    configure('cmp')

    add { source = 'lewis6991/gitsigns.nvim' }
    configure('gitsigns', 'git')

    -- add { source = 'windwp/nvim-ts-autotag' }
    -- configure('nvim-ts-autotag', {
    --     opts = { enable_close_on_slash = true }
    -- })

    add { source = 'MeanderingProgrammer/render-markdown.nvim' }
    configure('render-markdown', 'markdown')

    add { source = 'nvim-lua/plenary.nvim' }
    add { source = 'nvim-telescope/telescope.nvim', {
        depends = 'nvim-lua/plenary.nvim'
    }}

    configure('telescope')

    add { source = '3rd/image.nvim' }
    configure('image')
end)
