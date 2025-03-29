return {
    -- markdown preview
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "markdown", "Avante" },
    config = function()
        require("render-markdown").setup({
            file_types = {
                "markdown",
                "Avante", -- for AI plugin yetone/avante.nvim
            },
        })
    end,
}
