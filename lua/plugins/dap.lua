return {
    "mfussenegger/nvim-dap",
    ft = {
        'cpp',
    },
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },

    config = function()
        local dap = require 'dap'
        vim.keymap.set('n', '<F8>', require('dap').continue, { remap = false })
        vim.keymap.set('n', '<F9>', require('dap').step_over, { remap = false })
        vim.keymap.set('n', '<F10>', require('dap').step_into, { remap = false })
        vim.keymap.set('n', '<F11>', require('dap').step_out, { remap = false })
        vim.keymap.set('n', '<F12>', require('dap').step_back, { remap = false })
        vim.keymap.set('n', '<leader>b', require('dap').toggle_breakpoint, { remap = false })

        local dapui = require 'dapui'
        dapui.setup()
        dap.listeners.before.attach.dapui_config           = function() dapui.open() end
        dap.listeners.before.launch.dapui_config           = function() dapui.open() end
        dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
        dap.listeners.before.event_exited.dapui_config     = function() dapui.close() end

        dap.adapters.cppdbg                                = {
            id = 'cppdbg',
            type = 'executable',
            command = string.format('%s/.local/share/nvim/mason/bin/OpenDebugAD7', os.getenv('HOME')),
        }

        dap.configurations.cpp                             = {
            {
                name = "Launch file",
                type = "cppdbg",
                request = "launch",
                program = function()
                    local default = vim.b.cpp_out_file or string.format('%s/', vim.fn.getcwd())
                    return vim.fn.input('Path to executable: ', default, 'file')
                end,
                cwd = '${workspaceFolder}',
                stopAtEntry = true,
            },
            {
                name = 'Attach to gdbserver :1234',
                type = 'cppdbg',
                request = 'launch',
                MIMode = 'gdb',
                miDebuggerServerAddress = 'localhost:1234',
                miDebuggerPath = '/usr/bin/gdb',
                cwd = '${workspaceFolder}',
                program = function()
                    local default = vim.b.cpp_out_file or string.format('%s/', vim.fn.getcwd())
                    return vim.fn.input('Path to executable: ', default, 'file')
                end,
            },
        }
    end,
}
