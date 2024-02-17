return {
    "HiPhish/rainbow-delimiters.nvim",
    enabled = false,
    config = function()
        vim.g.rainbow_delimiters = {
            highlight = {
                "RainbowDelimiterCyan",
                -- "RainbowDelimiterYellow",
                "RainbowDelimiterBlue",
                "RainbowDelimiterOrange",
                "RainbowDelimiterGreen",
                "RainbowDelimiterViolet",
                "RainbowDelimiterRed",
            },
        }
    end,
}
