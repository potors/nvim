local lsp = require 'lspconfig'
local mason = require 'mason-lspconfig'

local capabilities = vim.lsp.protocol.make_client_capabilities()
local on_attach = function(_, buf)
    for lhs, rhs in pairs {
        ['K'] = vim.lsp.buf.hover,
        ['gD'] = vim.lsp.buf.declaration,
        ['gd'] = vim.lsp.buf.definition,
        ['gt'] = vim.lsp.buf.type_definition,
        ['gi'] = vim.lsp.buf.implementation,
        ['gh'] = vim.lsp.buf.signature_help,
        ['gr'] = vim.lsp.buf.references,
        ['gc'] = vim.lsp.buf.code_action,
        ['gl'] = vim.lsp.codelens.run,
        ['[d'] = vim.diagnostic.goto_prev,
        [']d'] = vim.diagnostic.goto_next,
        ['<leader>gr'] = vim.lsp.buf.rename,
        ['<leader>gf'] = vim.lsp.buf.format,
    } do vim.keymap.set('n', lhs, rhs, { buffer = buf }) end
end

local servers = {
    lua_ls = function()
        lsp.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            settings = {
                Lua = {
                    telemetry = { enable = false },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', false),
                        checkThirdParty = false,
                    }
                }
            }
        }
    end,

    'luau_lsp', 'pyright', 'bashls',
    'clangd', 'gopls', 'rust_analyzer', 'zls', 'elixirls',
    'html', 'cssls', 'ts_ls', 'svelte',
    'jsonls', 'yamlls',
    'dockerls', 'sqls',
}

local function default(server)
    lsp[server].setup {
        on_attach = on_attach,
        capabilities = capabilities,
    }
end

local function names(servers)
    local keys = vim.tbl_keys(servers)
    local values = vim.tbl_map(function(server)
        if type(server) == 'string' then
            return server
        end
    end, vim.tbl_values(servers))

    return vim.tbl_map(function(value)
        if type(value) == 'string' then
            return value
        end
    end, vim.tbl_extend('force', keys, values))
end

local function handlers(servers)
    return vim.tbl_map(function(server)
        if type(server) == 'function' then
            return server
        end
    end, servers)
end

mason.setup {
    automatic_installation = true,
    ensure_installed = vim.tbl_extend('force', names(servers), { 'lua_ls' }),
    handlers = vim.tbl_extend('force', handlers(servers), { default })
}
