return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("dashboard").setup({
            -- config
            theme = "hyper",
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        desc = "󰊳 Update",
                        group = "@property",
                        action = "PackerUpdate",
                        key = "u",
                    },
                    {
                        icon = " ",
                        icon_hl = "@variable",
                        desc = "Files",
                        group = "Label",
                        action = "Telescope find_files",
                        key = "f",
                    },
                    {
                        desc = " sessions",
                        group = "Number",
                        action = "Telescope session-lens search_session",
                        key = "s",
                    },
                },
            },
        })
    end,
}
