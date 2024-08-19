return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = {"mfussenegger/nvim-dap"},
        opts = {
            ensure_installed = { "cppdbg" }
        },
        keys = {
            {
                '<F9>',
                function()
                    require'dap'.toggle_breakpoint()
                end,
                mode = 'n',
                desc = 'Set BreakPoint',
            },
            {
                '<F5>',
                function()
                    if vim.fn.filereadable(".vscode/launch.json") then
                        require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
                    end
                    require'dap'.continue()
                end,
                mode = 'n',
                desc = 'Launch Debug',
            },

            {
                '<F10>',
                function()
                    require'dap'.step_over()
                end,
                mode = 'n',
                desc = 'StepOver',
            },
            {
                '<F11>',
                function()
                    require'dap'.step_into()
                end,
                mode = 'n',
                desc = 'StepInto',
            },
            {
                '<F4>',
                function()
                    require'dap'.terminate()
                    require("dapui").close()
                end,
                mode = 'n',
                desc = 'CloseDebug',
            }, 
            {
                '<F3>',
                function()
                    require("dapui").toggle()
                end,
                mode = 'n',
                desc = 'ToggleDapUI',
            }, 
        },

    },
    { 
        "rcarriga/nvim-dap-ui", 
        dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio", "jay-babu/mason-nvim-dap.nvim"},
        config = function()
            local dap, dapui = require("dap"), require("dapui")
            dap.adapters.cppdbg = {
                id = 'cppdbg',
                type = 'executable',
                 command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7',
                 args = {},
                 attach = {
                   pidProperty = "processId",
                   pidSelect = "ask"
                 },
               }
            require("dapui").setup()
                dap.listeners.before.attach.dapui_config = function()
              dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
              dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
              dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
              dapui.close()
            end
        end,
        -- keys = {
        --     {
        --         '<F4>',
        --         function()
        --             require'dap'.step_into()
        --         end,
        --         mode = 'n',
        --         desc = '[F]ormat buffer',
        --     },
        -- }
    }
}
