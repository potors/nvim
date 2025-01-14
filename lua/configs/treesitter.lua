local languages = {
    -- vim
    'vim', 'vimdoc',

    -- lua
    'lua', 'luadoc', 'luap', 'luau',

    -- markdown
    'markdown',

    -- c
    'c', 'cpp', 'c_sharp', 'objc', 'zig',

        -- builders 
        'make', 'cmake', 'ninja', 'meson',

        -- shaders
        'glsl', 'hlsl',

    -- go
    'go', 'gomod', 'gosum',

    -- away
    'java', 'groovy', 'scala', 'kotlin',

    -- beam
    'erlang', 'elm', 'elixir', 'gleam',

    -- crazy shit
    'haskell', 'awk', 'perl', 'regex',
   
    -- toys
    'python', 'bash',

    -- wanna try
    'ocaml', 'julia', 'odin', 'v',

    -- god no
    'pascal', 'ruby', 'rust',

    -- sql
    'sql', 'graphql',

    -- assembly
    'asm', 'objdump',

    -- docker
    'dockerfile',

    -- web
    'html', 'css', 'javascript',

        -- css
        'scss',

        -- php
        'php', 'phpdoc',

        -- js
        'typescript', 'jsdoc',

        -- frameworks
        'svelte', 'vue', 'tsx', 'angular', 'astro',

        -- json
        'json', 'jsonc', 'jq',

        -- other
        'prisma',

    -- git
    'git_config', 'git_rebase',
    'gitattributes', 'gitcommit', 'gitignore',

    -- games
    'godot_resource',

    -- linux (user)
    'tmux', 'hyprlang', 'sway', 'sxhkdrc',
    'nix', 'desktop',
    'yuck',

    -- linux (root)
    'nginx', 'passwd', 'gpg', 'pem', 'udev', 'ssh_config',

    -- markup
    'ini', 'properties',
    'xml', 'yaml', 'toml',

    -- tables
    'csv', 'tsv',
}

return {
    ensure_installed = languages,
    highlight = { enable = true },
}
