return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    config = function()
        local bufferline = require("bufferline")

        bufferline.setup({
            options = {
                show_tab_indicators = true,
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        highlight = "Directory",
                        text_align = "left",
                    },
                },

                -- 使用 nvim 内置 LSP
                diagnostics = "nvim_lsp",
            },
        })

        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        -- 左右 Tab 切换
        map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
        map("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)

        -- 关闭
        map("n", "<C-w>", ":bdelete<CR>", opts)
        map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opts)
        map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opts)
        map("n", "<leader>bc", ":BufferLinePickClose<CR>", opts)
        map("n", "<leader>bp", ":BufferLineTogglePin<CR>", opts)
        map("n", "<leader>bb", ":BufferLinePick<CR>", opts)
    end,
}
