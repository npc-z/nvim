return {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = {
        {
            "gh-liu/fold_line.nvim",
            event = "VeryLazy",
            init = function()
                -- To show lines for the current fold only
                vim.g.fold_line_current_fold_only = true

                -- Set vim.g.fold_line_disable (globally) or
                -- vim.w.fold_line_disable (for a window) or
                -- vim.b.fold_line_disable (for a buffer) to true.
            end,
        },
    },
    event = { "BufReadPre", "BufNewFile" },
    main = "ibl",
    config = function()
        local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
        }

        local hooks = require("ibl.hooks")
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)
        require("ibl").setup({
            indent = {
                char = "│",
                -- highlight = highlight,
            },
            scope = {
                enabled = true,
            },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "Trouble",
                    "lazy",
                    "neo-tree",
                },
            },
        })
    end,
}
