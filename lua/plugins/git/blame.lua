return {
    {
        "FabijanZulj/blame.nvim",
        lazy = false,
        config = function()
            require("blame").setup({})
        end,
        opts = {
            blame_options = { "-w" },
        },

        -- mappings notes:
        --     commit_info = "i",
        --     stack_push = "<TAB>",
        --     stack_pop = "<BS>",
        --     show_commit = "<CR>",
        --     close = { "<esc>", "q" },
    },
}
