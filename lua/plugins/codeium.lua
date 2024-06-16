return {
    "Exafunction/codeium.nvim",
    enabled = function()
        if vim.fn.getcwd():match("fuckdays") then
            return false
        end

        local handle = io.popen("uname -a")
        if handle ~= nil then
            local u = require("utils")
            local os_name = handle:read("*a")
            handle:close()
            return u.contains(os_name, "thinkpad")
        end
    end,
    -- event = "VeryLazy",
    event = "InsertEnter",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({})
    end,
}
