local languages = {
    c = {
        {
            name = '[nvim/codelldb] Debug - Current File',
            type = 'codelldb',
            request = 'launch',
            stopAtEntry = true,
            cwd = '${workspaceFolder}',
            program = function()
                local filename = vim.fn.expand '%'
                local basename = vim.fn.expand '%:t:r'

                local makefile = vim.loop.fs_stat 'makefile'
                              or vim.loop.fs_stat 'Makefile'

                if makefile then
                    vim.cmd('silent! !make -k clean ' .. basename)
                    return basename
                end

                os.execute(string.format('cc -g -o %s %s', basename, filename))
                return basename
            end,
            args = function()
                local args = {}

                local text
                local file = io.open 'input.txt'
                if file then
                    text = file:read '*a'
                    file:close()
                else
                    text = vim.fn.input 'Args: '
                end

                for arg in string.gmatch(text, '%S+') do
                    table.insert(args, arg)
                end

                vim.cmd 'echo ""'
                return args
            end,
            MIMode = 'gdb',
            miDebuggerPath = 'gdb',
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false,
                },
            },
        },
        {
            name = '[nvim/codelldb] Debug - Current Test',
            type = 'codelldb',
            request = 'launch',
            stopAtEntry = true,
            cwd = '${workspaceFolder}',
            program = function()
                local source = vim.fn.expand '%'
                local test = 'build/' .. vim.fn.expand '%:r' .. '.t'

                local makefile = vim.loop.fs_stat 'makefile'
                              or vim.loop.fs_stat 'Makefile'

                if makefile then
                    vim.cmd('silent! !make -k ' .. test)
                    return test
                end

                os.execute(string.format('cc -g -o %s %s', test, source))
                return test
            end,
            MIMode = 'gdb',
            miDebuggerPath = 'gdb',
            setupCommands = {
                {
                    text = '-enable-pretty-printing',
                    description = 'enable pretty printing',
                    ignoreFailures = false,
                },
            },
        }
    },
}

local function names(servers)
    local keys = vim.tbl_keys(servers)
    local values = vim.tbl_map(function(server)
        if type(server) == 'string' then
            return server
        end
    end, vim.tbl_values(servers))

    return vim.tbl_map(function(value)
        if type(value) == 'string' then
            return value
        end
    end, vim.tbl_extend('force', keys, values))
end

local function handlers(servers)
    return vim.tbl_map(function(server)
        if type(server) == 'function' then
            return server
        end
    end, servers)
end

return function(plugin)
    local dap = require 'dap'
    local ui = require 'dapui'

    ui.setup()
    vim.keymap.set('n', '<leader>dd', ui.toggle, { desc = 'Toggle Debugger UI' })
    vim.keymap.set('n', '<leader>db', function()
        local cond = vim.fn.input 'Condition: '
        cond = cond ~= '' and cond or nil
        dap.toggle_breakpoint(cond)
    end, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debugger: Run/Continue' })
    vim.keymap.set('n', '<F6>', dap.step_over, { desc = 'Debugger: Step Over' })
    vim.keymap.set('n', '<F7>', dap.step_into, { desc = 'Debugger: Step Into' })
    vim.keymap.set('n', '<F8>', dap.step_out, { desc = 'Debugger: Step Out' })
    vim.keymap.set('n', '<F9>', dap.pause, { desc = 'Debugger: Pause' })
    vim.keymap.set('n', '<F10>', dap.terminate, { desc = 'Debugger: Stop' })

    dap.listeners.after.event_initialized['dapui_config'] = ui.open
    dap.listeners.before.event_terminated['dapui_config'] = ui.close
    dap.listeners.before.event_exited['dapui_config'] = ui.close

    vim.fn.sign_define('DapBreakpoint', { text = '•', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '•', texthl = 'DapStopped', linehl = '', numhl = '' })

    local function default(opts)
        plugin.default_setup(opts)
    end

    local function adapter(opts)
        return function(config)
            config.adapters = opts
            plugin.default_setup(config)
        end
    end

    local daps = {
        codelldb = adapter {
            type = 'server',
            port = '${port}',
            executable = {
                command = 'codelldb',
                args = { '--port', '${port}' }
            }
        }
    }

    dap.configurations = vim.tbl_extend('force', dap.configurations, languages)

    return {
        ensure_installed = names(daps),
        handlers = vim.tbl_extend('keep', { default }, handlers(daps))
    }
end
