return {
    "folke/flash.nvim",
    event = "VeryLazy",
    dependencies = {
        -- 小鹤双拼
        "rainzm/flash-zh.nvim",
    },
    opts = {},
    keys = {
        {
            "s",
            mode = { "n", "x", "o" },
            function()
                require("flash-zh").jump({ chines_only = false })
            end,
            desc = "Flash between Chinese",
        },
        {
            "S",
            mode = { "n", "x", "o" },
            function()
                require("flash").treesitter()
            end,
            desc = "Flash Treesitter",
        },
        {
            "r",
            mode = "o",
            function()
                require("flash").remote()
            end,
            desc = "Remote Flash",
        },
        {
            "R",
            mode = { "o", "x" },
            function()
                require("flash").treesitter_search()
            end,
            desc = "Treesitter Search",
        },
        {
            "<c-s>",
            mode = { "c" },
            function()
                require("flash").toggle()
            end,
            desc = "Toggle Flash Search",
        },
    },
}
