return {
    "ellisonleao/glow.nvim",
    event = "VeryLazy",
    config = function()
        require("glow").setup({
            glow_path = "/usr/bin/glow", -- filled automatically with your glow bin in $PATH,
            glow_install_path = "/usr/bin/", -- default path for installing glow binary
            border = "shadow", -- floating window border config
            style = "dark", -- filled automatically with your current editor background, you can override using glow json style
            pager = false,
            width = 120,
        })
    end,
}
