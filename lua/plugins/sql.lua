return {
    "kndndrj/nvim-dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    build = function()
        -- Install tries to automatically detect the install method.
        -- if it fails, try calling it with one of these parameters:
        --    "curl", "wget", "bitsadmin", "go"
        -- NOTE: install within neovim by nixos
        -- require("dbee").install()
    end,
    config = function()
        local dbee = require("dbee")

        dbee.setup({
            -- you can specify an optional default connection id and it will be the active one
            -- when dbee starts
            default_connection = nil,

            drawer = {
                -- show help or not
                disable_help = true,
            },

            result = {
                -- number of rows in the results set to display per page
                page_size = 100,
            },

            -- window layout
            window_layout = require("dbee.layouts").Default:new({
                drawer_width = 30,
                result_height = 12,
                call_log_height = 12,
            }),
        })

        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        opts.desc = "[D]bee [T]oggle"
        map("n", "<leader>dt", ":Dbee toggle<CR>", opts)

        function select_paragraph_and_execute_bb()
            vim.cmd("normal! vip")

            -- 执行 BB 命令
            vim.api.nvim_feedkeys(
                vim.api.nvim_replace_termcodes("BB", true, true, true),
                "v",
                true
            )
            -- vim.cmd("wincmd k")
            -- 创建一个定时器
            local timer = vim.loop.new_timer()

            -- 启动定时器，设置 500 毫秒后执行回调函数
            timer:start(
                500,
                0,
                vim.schedule_wrap(function()
                    -- 执行 <C-w>k 的命令
                    vim.cmd("wincmd k")

                    -- 关闭定时器
                    timer:stop()
                    timer:close()
                end)
            )
        end

        -- 在 sql 文件类型中设置快捷键
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "sql",
            callback = function()
                vim.api.nvim_buf_set_keymap(
                    0, -- 为当前 buffer 设置快捷键
                    "n",
                    "<C-CR>",
                    ":lua select_paragraph_and_execute_bb()<CR>",
                    { noremap = true, silent = true }
                )
            end,
        })
    end,
}
