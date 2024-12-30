return {

    -- Debugging in NeoVim the print() way!
    {
        "andrewferrier/debugprint.nvim",

        opts = {
            keymaps = {
                normal = {
                    plain_below = "g?p",
                    plain_above = "g?P",
                    variable_below = "g?v",
                    variable_above = "g?V",
                    variable_below_alwaysprompt = nil,
                    variable_above_alwaysprompt = nil,
                    textobj_below = "g?o",
                    textobj_above = "g?O",
                    toggle_comment_debug_prints = nil,
                    delete_debug_prints = nil,
                },
            },
            commands = {
                toggle_comment_debug_prints = "ToggleCommentDebugPrints",
                delete_debug_prints = "DeleteDebugPrints",
            },
            -- … Other options
        },

        dependencies = {
            -- "echasnovski/mini.nvim", -- Needed for :ToggleCommentDebugPrints (not needed for NeoVim 0.10+)
        },

        version = "*", -- Remove if you DON'T want to use the stable version
    },

    -- display prettier diagnostic messages.
    -- Display one line diagnostic messages where the cursor is, with icons and colors
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        -- event = "VeryLazy", -- Or `LspAttach`
        -- priority = 9990000, -- needs to be loaded in first
        priority = 1000, -- needs to be loaded in first
        config = function()
            -- remove all the others diagnostics.
            vim.diagnostic.config({ virtual_text = false })

            require("tiny-inline-diagnostic").setup({
                options = {
                    -- Show the source of the diagnostic.
                    show_source = true,
                    virt_texts = {
                        priority = 9048,
                    },
                },
            })
        end,
    },
}
