local capabilities = vim.tbl_deep_extend('force',
    vim.lsp.protocol.make_client_capabilities(),
    require 'cmp_nvim_lsp'.default_capabilities())

vim.lsp.config('*', {
    capabilities = capabilities,
    root_markers = { '.git' },
})

vim.lsp.config('luals', {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },

    settings = {
        Lua = {
            telemetry = { enable = false },
            diagnostics = { globals = { 'vim' } },
            runtime = { path = vim.split(package.path, ';') },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', false),
                checkThirdParty = false,
            }
        }
    }
})

vim.lsp.config('clangd', { cmd = { 'clangd' }, filetypes = { 'c', 'cpp' } })
vim.lsp.config('pyright', { cmd = { 'pyright-langserver' }, filetypes = { 'python' } })
vim.lsp.config('gopls', { cmd = { 'gopls' }, filetypes = { 'go', 'gomod' } })
vim.lsp.config('zls', { cmd = { 'zls' }, filetypes = { 'zig' } })
vim.lsp.config('rustls', { cmd = { 'rust-analyzer' }, filetypes = { 'rust' } })
vim.lsp.config('htmlls', { cmd = { 'vscode-html-languageserver' }, filetypes = { 'html' } })
vim.lsp.config('cssls', { cmd = { 'vscode-css-languageserver' }, filetypes = { 'css', 'scss' } })

vim.lsp.enable { 'luals', 'clangd', 'pyright', 'gopls', 'zls', 'rustls', 'htmlls', 'cssls' }
