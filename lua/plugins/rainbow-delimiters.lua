return {
    "HiPhish/rainbow-delimiters.nvim",
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
