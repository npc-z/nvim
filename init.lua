local function main()
    require("core")
    if vim.g.vscode then
        -- vim.notify("start from vscode")
        -- do not load plugins
    else
        -- vim.notify("start from nvim")
        require("lazy-nvim")
    end
end

main()
