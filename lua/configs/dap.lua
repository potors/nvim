return function(dap)
    local ui = require 'dapui'

    ui.setup()

    vim.keymap.set('n', '<leader>dd', ui.toggle, { desc = 'Toggle Debugger UI' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dc', function()
        local cond = vim.fn.input 'Condition: '
        cond = cond ~= '' and cond or nil
        dap.toggle_breakpoint(cond)
    end, { desc = 'Toggle Breakpoint With Condition' })

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

    dap.adapters = {
        codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
                command = 'codelldb',
                args = { '--port', '${port}' },
            },
        },
        locallua = {
            type = 'executable',
            command = 'local-lua-dbg',
            enrich_config = function(config, on_config)
                local cfg = vim.deepcopy(config)
                cfg.extensionPath = cfg.extensionPath or '/usr/lib/node_modules/local-lua-debugger-vscode'

                on_config(cfg)
            end
        },
        delve = {
            type = 'server',
            port = '${port}',
            executable = {
                command = 'dlv',
                args = {'dap', '-l', '127.0.0.1:${port}'},
            }
        },
        python = {
            type = 'executable',
            command = 'python', -- or path to target environment virtualenv python
            args = { '-m', 'debugpy.adapter' },
            options = {
                source_filetype = 'python',
            },
        }
    }

    local c = {
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
                    vim.cmd('silent! !make -B -k ' .. basename)
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
        },
        {
            name = '[nvim/codelldb] Debug - Any File',
            type = 'codelldb',
            request = 'launch',
            stopAtEntry = true,
            cwd = '${workspaceFolder}',
            program = function()
                local exe = vim.fn.input('Executable: ')

                os.execute('make -B')

                return exe
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
    }

    local lua = {
        {
            name = '[lua] Debug - Current File',
            type = 'locallua',
            request = 'launch',
            cwd = '${workspaceFolder}',
            program = {
                lua = 'lua',
                file = '${file}',
            },
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
        }
    }

    local python = {
        {
			type = "python",
			request = "launch",
			name = "Launch file",

			program = "${file}",
			pythonPath = function()
				local cwd = vim.fn.getcwd()
				if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
					return cwd .. "/venv/bin/python"
				elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
					return cwd .. "/.venv/bin/python"
				else
					return "/usr/bin/python"
				end
			end,
		},
    }

    local go = {
        {
            type = "delve",
            name = "Debug",
            request = "launch",
            program = "${file}",
        },
        {
            type = "delve",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "${file}",
        },
        {
            type = "delve",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
        },
    }

    dap.configurations = {
        c = c,
        cpp = c,
        lua = lua,
        python = python,
        go = go,
    }

    -- require 'dap-go'.setup({
    --     dap_configurations = {
    --         {
    --             type = "go",
    --             name = "Debug This File",
    --             request = "launch",
    --             program = "${file}",
    --         },
    --     },
    -- })

    return false
end
