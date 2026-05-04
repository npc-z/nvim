return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
        indent = { enabled = true },
        input = { enabled = true },
        picker = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
    },
    keys = {
        -- Top Pickers & Explorer
        {
            "<leader>lg",
            function()
                Snacks.lazygit()
            end,
            desc = "lazygit toggle",
        },
    },
}
