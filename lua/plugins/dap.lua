return {
    "mfussenegger/nvim-dap",
    dependencies = {
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "nvim-neotest/nvim-nio",
            },
        },
        "theHamsta/nvim-dap-virtual-text",
        "nvim-telescope/telescope-dap.nvim",
        {

            "Joakker/lua-json5",
            -- if you're on windows
            -- run = 'powershell ./install.ps1'
            -- not work on nixos, have to build the json5 by self
            -- run = "./install.sh",
        },

        -- py
        "mfussenegger/nvim-dap-python",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        local dap_vt = require("nvim-dap-virtual-text")

        dapui.setup()
        dap_vt.setup()
        require("telescope").load_extension("dap")

        require("dap.ext.vscode").json_decode = require("json5").parse
        require("dap.ext.vscode").load_launchjs(nil, {
            debugpy = { "python" },
            cppdbg = { "c", "cpp" },
        })

        require("dap-python").setup("python")

        -- rust
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.exepath("codelldb"),
                args = { "--port", "${port}" },
            },
            name = "codelldb",
        }

        local ExecTypes = {
            TEST = "cargo build --tests -q --message-format=json",
            BIN = "cargo build -q --message-format=json",
        }

        local function runBuild(type)
            local lines = vim.fn.systemlist(type)
            local output = table.concat(lines, "\n")
            local filename =
                output:match("^.*\"executable\":\"(.*)\",.*\n.*,\"success\":true}$")

            if filename == nil then
                return error("failed to build cargo project")
            end

            return filename
        end

        -- dap.configurations.rust = {
        --     {
        --         name = "Debug Test",
        --         type = "codelldb",
        --         request = "launch",
        --         program = function()
        --             return runBuild(ExecTypes.TEST)
        --         end,
        --         cwd = "${workspaceFolder}",
        --         stopOnEntry = false,
        --         showDisassembly = "never",
        --     },
        --     {
        --         name = "Debug Bin",
        --         type = "codelldb",
        --         request = "launch",
        --         program = function()
        --             return runBuild(ExecTypes.BIN)
        --         end,
        --         cwd = "${workspaceFolder}",
        --         stopOnEntry = false,
        --         showDisassembly = "never",
        --     },
        -- }
        -- rust end

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

        vim.keymap.set("n", "<leader>dc", function()
            dap.continue()
        end, { desc = "dap start or continue" })

        vim.keymap.set("n", "<leader>dso", function()
            dap.step_over()
        end, { desc = "dap step_over" })

        vim.keymap.set("n", "<leader>dsi", function()
            dap.step_into()
        end, { desc = "dap step_into" })

        vim.keymap.set("n", "<leader>dsO", function()
            dap.step_out()
        end, { desc = "dap step_out" })

        vim.keymap.set("n", "<Leader>db", function()
            dap.toggle_breakpoint()
        end, { desc = "dap toggle_breakpoint" })

        -- vim.keymap.set("n", "<Leader>lp", function()
        --     dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
        -- end, { desc = "dap continue" })

        vim.keymap.set("n", "<Leader>dr", function()
            dap.repl.toggle()
        end, { desc = "dap repl toggle" })

        vim.keymap.set("n", "<Leader>dl", function()
            dap.run_last()
        end, { desc = "dap run last" })

        vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
            require("dap.ui.widgets").hover()
        end, { desc = "dap hover" })

        vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
            require("dap.ui.widgets").preview()
        end, { desc = "dap preview" })

        vim.keymap.set({ "n", "v" }, "<Leader>du", function()
            require("dapui").toggle()
        end, { desc = "dap ui toggle" })

        vim.fn.sign_define(
            "DapBreakpoint",
            { text = "🛑", texthl = "", linehl = "", numhl = "" }
        )
    end,
}
