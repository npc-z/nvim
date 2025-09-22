return {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },

    config = function()
        local kulala = require("kulala")
        kulala.setup()

        -- 在 http 文件类型中设置快捷键
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "http",
            callback = function()
                -- 为当前 buffer 设置快捷键
                vim.keymap.set("n", "<C-CR>", function()
                    -- vim.keymap.set("n", "<leader>rs", function()
                    kulala.run()
                end, { desc = "Send request" })
            end,
        })
    end,
}
