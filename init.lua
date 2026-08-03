-- i`ve seen some places to see how it changes
--   this video: https://www.youtube.com/watch?v=h1sCwi0pNyM
--   this video: https://www.youtube.com/watch?v=v1c3VMF_bkw
--   this post: https://justinhj.github.io/2026/04/06/refreshing-your-neovim-config-for-0-12-0.html
--   this post: https://dotfiles.substack.com/p/native-lsp-in-neovim-012
--   this video: https://www.youtube.com/watch?v=s7zb73fgXqU
-- nvim help pages for about virtually every feature
-- my old config (see old commits in this repo)
-- google search ai responses are useful sometimes (luck based search engine lol)

require 'vim._core.ui2'.enable()

for _, name in ipairs {
    'node', 'perl', 'python3', 'ruby'
} do vim.g['loaded_' .. name .. '_provider'] = 0 end

for _, name in ipairs {
    'netrw', 'netrwPlugin',
    'tutor_mode_plugin',
    'gzip', 'zipPlugin', 'tarPlugin',
    '2html_plugin', 'sql_completion',
    'matchit', 'matchparen',
    'vimball', 'vimballPlugin',
} do vim.g['loaded_' .. name] = 1 end

require 'options'
require 'keymaps'
require 'plugins'
require 'lsp'
