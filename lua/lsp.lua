-- Using luals and clangd from package manager as of now
-- TODO: simple lua package utility (you define it download)

local path = vim.fn.stdpath 'config' .. '/lsp'
local files = vim.fn.glob(path .. '/*.lua', nil, true)

local cmp = require 'blink.cmp'
local capabilities = cmp.get_lsp_capabilities(nil, true)

local servers = {}
for i, file in ipairs(files) do
    servers[i] = file:match '/(%w+).lua$'
end

vim.lsp.config('*', {
    capabilities = capabilities,
    root_markers = { '.git' },
})

vim.lsp.enable(servers)

local function open_diagnostic(at)
    return function()
        vim.diagnostic.jump { count = at }
        vim.diagnostic.open_float()
    end
end

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
        for key, mapping in pairs {
            ['K']  = { vim.lsp.buf.hover, { desc = 'Hover Information' } },
            ['gr'] = { vim.lsp.buf.rename, { desc = 'Rename Symbol' } },
            ['gd'] = { vim.lsp.buf.definition, { desc = 'Goto Definition' } },
            ['gD'] = { vim.lsp.buf.declaration, { desc = 'Goto Declaration' } },
            ['gi'] = { vim.lsp.buf.implementation, { desc = 'Goto Implementation' } },
            ['gt'] = { vim.lsp.buf.type_definition, { desc = 'Goto Type Definition' } },
            ['gR'] = { vim.lsp.buf.references, { desc = 'Search References' } },
            ['ga'] = { vim.lsp.buf.code_action, { desc = 'Open Code Actions Window' } },
            ['[d'] = { open_diagnostic(-1), { desc = 'Goto Prev Diagnostic' } },
            [']d'] = { open_diagnostic(1), { desc = 'Goto Next Diagnostic' } },
        } do
            ---@type unknown, unknown
            local action, opts = unpack(mapping)

            vim.keymap.set('n', key, action, vim.tbl_extend('force', opts, { buffer = event.buf }))
        end
    end,
})

vim.diagnostic.config {
    virtual_text = true,
    virtual_lines = false,
    severity_sort = true,
    update_in_insert = false,
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '!',
            [vim.diagnostic.severity.WARN] = '*',
            [vim.diagnostic.severity.INFO] = '?',
            [vim.diagnostic.severity.HINT] = '+',
        },
    },
    float = {
        border = 'rounded',
        source = 'if_many',
        focusable = false,
    },
}
