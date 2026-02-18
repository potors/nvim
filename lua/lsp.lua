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

vim.lsp.config('clangd', {
    cmd = { 'clangd' },
    filetypes = { 'c', 'cpp', 'objc', 'cuda' },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile-commands.json',
        'compile-flags.txt',
        'configure.ac',
    }
})

vim.lsp.config('pyright', {
    cmd = { 'pyright-langserver' },
    filetypes = { 'python' },
    root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
    }
})

vim.lsp.config('gopls', {
    cmd = { 'gopls' },
    filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
    root_markers = { 'go.work', 'go.mod' }
})

vim.lsp.config('zls', {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig' }
})

vim.lsp.config('rustls', {
    cmd = { 'rust-analyzer' },
    filetypes = { 'rust' },
    root_markers = { 'Cargo.toml' },
})

vim.lsp.config('htmlls', {
    cmd = { 'vscode-html-languageserver', '--stdio' },
    filetypes = { 'html' },
})

vim.lsp.config('cssls', {
    cmd = { 'vscode-css-languageserver', '--stdio' },
    filetypes = { 'css', 'scss', 'less' },
})

vim.lsp.enable { 'luals', 'clangd', 'pyright', 'gopls', 'zls', 'rustls', 'htmlls', 'cssls' }
