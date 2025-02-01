vim.loader.enable()

local site = vim.fn.stdpath 'data' .. '/site'
local mini = site .. '/pack/deps/start/mini.nvim'

if not vim.loop.fs_stat(mini) then
    vim.fn.system {
        'git', 'clone', '--filter=blob:none',
        'https://github.com/echasnovski/mini.nvim', mini
    }

    vim.cmd 'packadd mini.nvim | helptags ALL'
end

require 'mini.deps'.setup {
    path = { package = site }
}

local add = MiniDeps.add

local function configure(name, opts)
    local found, plugin = pcall(require, name)

    if opts == nil or type(opts) == 'string' then -- do file
        local ok, result = pcall(require, 'configs.' .. (opts or name))
        opts = ok and result or opts
    end

    if not found then
        return opts
    end

    while type(opts) == 'function' do -- execute it
        opts = opts(plugin)
    end

    if opts == false then
        return plugin
    end

    if type(opts) ~= 'table' then -- ignore it
        opts = nil
    end

    plugin.setup(opts)
    return plugin
end

vim.notify = configure 'mini.notify'.make_notify()

add { source = 'catppuccin/nvim', name = 'catppuccin' }

configure 'catppuccin'
vim.cmd.colorscheme 'catppuccin'

add { source = 'nvim-treesitter/nvim-treesitter', name = 'treesitter',
    checkout = 'master', monitor = 'main',
    hooks = {
        post_checkout = function()
            vim.cmd 'TSUpdate'
        end,
    },
}

configure('nvim-treesitter.configs', 'treesitter')

configure 'mini.icons'
configure 'mini.ai'
configure 'mini.comment'
configure 'mini.surround'
configure 'mini.trailspace'
configure 'mini.move'
configure 'mini.pairs'

configure 'mini.tabline'
configure 'mini.statusline'

configure 'mini.pick'
configure 'mini.files'

add { source = 'neovim/nvim-lspconfig',
    depends = {
        'hrsh7th/cmp-nvim-lsp',
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
}

configure 'mason'
configure 'lsp'

add { source = 'hrsh7th/nvim-cmp',
    depends = {
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-calc',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-nvim-lsp-signature-help',

        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',

        'onsails/lspkind.nvim',
    }
}

configure 'cmp'

add { source = 'mfussenegger/nvim-dap',
    depends = {
        'jay-babu/mason-nvim-dap.nvim',
        'rcarriga/nvim-dap-ui',
        'theHamsta/nvim-dap-virtual-text',
        'nvim-neotest/nvim-nio',
    },
}

configure('mason-nvim-dap', 'dap')
configure('nvim-dap-virtual-text', {
    virt_text_pos = 'eol',
    virt_text_win_col = 66,
})

add { source = 'lewis6991/gitsigns.nvim' }

configure('gitsigns', 'git')
