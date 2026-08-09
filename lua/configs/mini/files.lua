local cache = {}

local function cached(entry, fn)
    if cache[entry] == nil then
        cache[entry] = fn(entry)
    end

    return cache[entry]
end

return function(plugin)
    vim.keymap.set('n', [[<leader>e]], plugin.open, { desc = 'Open File Explorer' })

    return {
        content = {
            filter = function(entry)
                return cached(entry.path, function()
                    return vim.system(
                        { 'git', 'check-ignore', '-q', entry.path },
                        { cwd = vim.fn.fnamemodify(entry.path, ':h') }
                    ):wait().code ~= 0
                end)
            end
        }
    }
end
