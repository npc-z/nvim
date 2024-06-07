return {
    "Exafunction/codeium.nvim",
    enabled = function()
        if vim.fn.getcwd():match("fuckdays") then
            return false
        end
        return true
    end,
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({})
    end,
}
