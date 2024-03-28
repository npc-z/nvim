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
        end, { desc = "dap continue" })

        vim.keymap.set("n", "<leader>dso", function()
            dap.step_over()
        end, { desc = "dap step_over" })

        vim.keymap.set("n", "<leader>dsi", function()
            dap.step_into()
        end, { desc = "dap step_into" })

        vim.keymap.set("n", "<leader>dso", function()
            dap.step_out()
        end, { desc = "dap step_out" })

        vim.keymap.set("n", "<Leader>db", function()
            dap.toggle_breakpoint()
        end, { desc = "dap toggle_breakpoint" })

        -- vim.keymap.set("n", "<Leader>B", function()
        --     dap.set_breakpoint()
        -- end, { desc = "dap continue" })

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

        -- vim.keymap.set("n", "<Leader>df", function()
        --     local widgets = require("dap.ui.widgets")
        --     widgets.centered_float(widgets.frames)
        -- end, { desc = "dap centered_float" })

        -- vim.keymap.set("n", "<Leader>ds", function()
        --     local widgets = require("dap.ui.widgets")
        --     widgets.centered_float(widgets.scopes)
        -- end, { desc = "dap centered_float" })

        require("dap-python").setup("python")
    end,
}
