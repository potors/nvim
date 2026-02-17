local providers = { 'node', 'perl', 'python3', 'ruby' }

for _, name in ipairs(providers) do
    vim.g['loaded_' .. name .. '_provider'] = 0
end

local modules = {
    'netrw', 'netrwPlugin',
    'tutor_mode_plugin',
    'gzip', 'zipPlugin', 'tarPlugin',
    '2html_plugin', 'sql_completion',
    'matchit', 'matchparen',
    'vimball', 'vimballPlugin',
}

for _, name in ipairs(modules) do
    vim.g['loaded_' .. name] = 1
end

require 'options'
require 'keymaps'
require 'plugins'
require 'lsp'
