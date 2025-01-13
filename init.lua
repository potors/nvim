-- disable providers
for _, name in ipairs {
    'python3', 'perl', 'ruby', 'node',
} do vim.g['loaded_' .. name .. '_provider'] = 0 end

-- disable plugins
for _, name in ipairs {
    'netrw', 'netrwPlugin',
    'tutor_mode_plugin',
    'gzip', 'zipPlugin', 'tarPlugin',
    '2html_plugin', 'sql_completion',
    'matchit', 'matchparen',
    'vimball', 'vimballPlugin',
} do vim.g['loaded_' .. name] = 1 end

require 'options'
