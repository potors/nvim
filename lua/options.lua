vim.g.mapleader = ','

-- indentation
vim.opt.si = true
vim.opt.ai = true
vim.opt.sr = true

-- tabs and spaces
vim.opt.et = true -- use spaces
vim.opt.ts = 4 -- tab width
vim.opt.sw = 0 -- space width

-- line number
vim.opt.nu = true
vim.opt.nuw = 2
vim.opt.rnu = true
vim.opt.scl = 'yes'

-- highlight
vim.opt.cul = true  -- current line
vim.opt.cc = '65'   -- column limit

-- spacings
vim.opt.so = 4   -- lines around
vim.opt.siso = 8 -- columns around

-- search
vim.opt.is = true
vim.opt.ic = true
vim.opt.scs = true

-- buffer
vim.opt.wrap = false
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undofile = true

-- completion
vim.opt.ph = 12
vim.opt.pw = 36

vim.opt.wop = { 'pum', 'tagfile' }
vim.opt.cot = { 'menu', 'menuone', 'noselect', 'noinsert' }

-- split
vim.opt.sb = true
vim.opt.spr = true

-- others
vim.opt.termguicolors = true

vim.opt.clipboard = 'unnamedplus'

vim.opt.shm = 'lmroOtTAIc'
vim.opt.path:append ',**'

vim.cmd 'syntax off'
