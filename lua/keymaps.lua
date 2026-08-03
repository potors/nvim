-- Function to delete buffers while not closing
-- it's window and allowing close the last one
local function delete_buffer()
    local buf = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    local buffers = vim.fn.getbufinfo { buflisted = 1 }

    if #buffers <= 1 then
        local new = vim.api.nvim_create_buf(true, false)
        vim.api.nvim_win_set_buf(win, new)
    else
        for _, b in ipairs(buffers) do
            if b.bufnr ~= buf then
                vim.api.nvim_win_set_buf(win, b.bufnr)
                break
            end
        end
    end

    vim.api.nvim_buf_delete(buf, { force = true })
end

local mappings = {
    -- Instinctual Mappings
    { 'i', 'jk',        [[<esc>]],      { desc = 'Exit Insert Mode' } },
    { 't', 'jk',        [[<c-\><c-n>]], { desc = 'Exit Terminal Mode' } },
    { 'n', '<esc>',     [[:noh<cr>]],   { desc = 'Clear Search Highlights On ESC' } },
    { 'c', '<esc>',     [[<c-c>]],      { desc = 'Do not run incomplete command on ESC' } },
    { 'c', '<c-a>',     [[<c-b>]],      { desc = 'Same goto-start-of-line shortcut' } },

    -- Keyboard Facilities
    { 'n', '\'',        [[`]],          { desc = 'Jump to mark on ptbr keyboard' } },

    -- Buffer Navigation
    { 'n', '<leader>x', delete_buffer,  { desc = 'Delete Buffer' } },
    { 'n', '<leader>w', [[:w<cr>]],     { desc = 'Save buffer' } },
    { 'n', '<tab>',     [[:bn<cr>]],    { desc = 'Next buffer' } },
    { 'n', '<s-tab>',   [[:bp<cr>]],    { desc = 'Prev buffer' } },

    -- Window Navigation
    { 'n', '<c-h>',     [[<c-w><c-h>]], { desc = 'Jump to Left Window' } },
    { 'n', '<c-j>',     [[<c-w><c-j>]], { desc = 'Jump to Bottom Window' } },
    { 'n', '<c-k>',     [[<c-w><c-k>]], { desc = 'Jump to Upper Window' } },
    { 'n', '<c-l>',     [[<c-w><c-l>]], { desc = 'Jump to Right Window' } },
}

for _, mapping in ipairs(mappings) do
    pcall(vim.keymap.del, unpack(mapping, 1, 2))
    pcall(vim.keymap.set, unpack(mapping))
end
