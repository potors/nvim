vim.g.mapleader = ','

vim.opt.clipboard = 'unnamedplus'
vim.opt.shortmess:append 'mrAIc'
vim.opt.path = { '.', '**' }
vim.cmd 'syntax off'

for key, value in pairs({
    -- indentation
    ai = true, -- auto indent
    si = true, -- smart indent
    sr = true, -- use multiples of indent size
    et = true, -- use spaces instead of tabs
    ts = 4,    -- tab is equivalent as 4 spaces
    sw = 0,    -- use 4 spaces for indentation

    -- number column
    nu = true,   -- enable line number
    rnu = true,  -- relative number
    nuw = 2,     -- it uses at least 2 characters
    scl = 'yes', -- display sign column

    -- highlight
    cul = true, -- highlight current line
    cc = '60',  -- highlight Nth column

    -- spacing
    so = 4,   -- min lines around cursor (vertical)
    siso = 8, -- min chars around cursor (horizontal)

    -- search
    is = true,  -- highlight while writing search
    ic = true,  -- ignore case
    scs = true, -- unless it has uppercase

    -- buffer
    wrap = false, -- line wrap
    wb = false,   -- file backup
    swf = false,  -- swapfile (bogus annoying)
    udf = true,  -- undofiles (they can get very big)

    -- split
    sb = true,  -- splits below if true
    spr = true, -- splits to right if true

    -- other
    tgc = true, -- termguicolors
    cot = '', -- completion opts (i'm using blink.cmp)
}) do vim.opt[key] = value end
