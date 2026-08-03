return {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' },
    root_markers = {
        '.luarc.json',
        '.luarc.jsonc',
        '.stylua.toml',
    },
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = vim.split(package.path, ';'),
            },
            workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
                -- library = vim.env.VIMRUNTIME,
            },
            diagnostics = {
                globals = { 'vim' },
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
