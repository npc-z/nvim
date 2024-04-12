-- nice cmdline

return {
    "folke/noice.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("noice").setup({
            cmdline = {
                enabled = true, -- enables the Noice cmdline UI
            },
            popupmenu = {
                enabled = true, -- enables the Noice popupmenu UI
                backend = "nui", -- backend to use to show regular cmdline completions
            },
        })
    end,
}
