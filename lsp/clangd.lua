return {
    cmd = {
        'clangd',
        -- '--all-scopes-completion',
        '--background-index',
        '--clang-tidy',
        -- '--completion-style=detailed',
        -- '--function-arg-placeholders=0',
    },
    filetypes = {
        'c', 'cpp',
        'objc', 'objcpp',
        'cuda',
    },
    root_markers = {
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_commands.json',
        'compile_flags.txt',
        'configure.ac',
    },
}
