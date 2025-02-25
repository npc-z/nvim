-- Debugging in NeoVim the print() way!

return {
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
}
