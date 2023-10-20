return {
    "ray-x/go.nvim",
    dependencies = {
        -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
    },
    event = { "CmdlineEnter" },
    ft = { "go", "gomod" },
    -- if you need to install/update all binaries
    build = ":lua require(\"go.install\").update_all_sync()",
    config = function()
        require("go").setup()
    end,
}
