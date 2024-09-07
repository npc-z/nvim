return {
    "askfiy/http-client.nvim",
    config = function()
        require("http-client").setup()

        -- 在 http 文件类型中设置快捷键
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "http",
            callback = function()
                -- 为当前 buffer 设置快捷键
                vim.api.nvim_buf_set_keymap(
                    0,
                    "n",
                    "<C-CR>",
                    ":HttpClient sendRequest<CR>",
                    { noremap = true, silent = true }
                )
            end,
        })
    end,
}
