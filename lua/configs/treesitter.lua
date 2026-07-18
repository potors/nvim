vim.api.nvim_create_autocmd('FileType', {
    callback = function()
        pcall(vim.treesitter.start)

        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
})

return {
    ensure_installed = {
        'vim', 'vimdoc',
        'lua', 'luadoc', 'luap', 'luau',
        'markdown',
        'c', 'cpp', 'c_sharp', 'objc', 'zig',
            'make', 'cmake', 'ninja', 'meson',
            'glsl', 'hlsl',
        'go', 'gomod', 'gosum',
        'java', 'groovy', 'scala', 'kotlin',
        'erlang', 'elm', 'elixir', 'gleam',
        'haskell', 'awk', 'perl', 'regex',
        'python', 'bash',
        'ocaml', 'julia', 'odin', 'v',
        'pascal', 'ruby', 'rust',
        'sql', 'graphql',
        'asm', 'objdump',
        'dockerfile',
        'html', 'css', 'javascript',
            'scss',
            'php', 'phpdoc',
            'typescript', 'jsdoc',
            'svelte', 'vue', 'tsx', 'angular', 'astro',
            'json', 'jq',
            'prisma',
        'git_config', 'git_rebase',
        'gitattributes', 'gitcommit', 'gitignore',
        'godot_resource',
        'tmux', 'hyprlang', 'sway', 'sxhkdrc',
        'nix', 'desktop',
        'yuck',
        'nginx', 'passwd', 'gpg', 'pem', 'udev', 'ssh_config',
        'ini', 'properties',
        'xml', 'yaml', 'toml',
        'csv', 'tsv',
    },
}
