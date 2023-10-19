return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.cmd("set background=dark") -- or light if you want light mode
        vim.cmd("colorscheme kanagawa")
    end
}
