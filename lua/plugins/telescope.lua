return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({

            defaults = {
                layout_config = { width = 0.95, height = 0.95, preview_cutoff = 1 },
                layout_strategy = "vertical",
                mappings = {
                    i = {
                        -- 上下移动
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<Down>"] = "move_selection_next",
                        ["<Up>"] = "move_selection_previous",
                        -- 历史记录
                        ["<C-n>"] = "cycle_history_next",
                        ["<C-p>"] = "cycle_history_prev",
                        -- 关闭窗口
                        ["<C-c>"] = "close",
                        -- 预览窗口上下滚动
                        ["<C-u>"] = "preview_scrolling_up",
                        ["<C-d>"] = "preview_scrolling_down",
                    },
                },
            },
        })

        telescope.load_extension("fzf")

        -- set keymaps
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        local opts_with_desc = function(desc)
            return vim.tbl_deep_extend("force", opts, { desc = desc })
        end

        -- Telescope
        map("n", "<leader>s", ":Telescope<CR>", opts_with_desc("open Telescope"))
        -- 查找文件
        map(
            "n",
            "<leader>ff",
            ":Telescope find_files<CR>",
            opts_with_desc("find files")
        )
        map(
            "n",
            "<leader><leader>",
            ":Telescope buffers<CR>",
            opts_with_desc("find buffers")
        )

        -- 全局搜索
        map(
            "n",
            "<leader>fg",
            ":Telescope live_grep<CR>",
            opts_with_desc("global search")
        )

        -- git branches
        map(
            "n",
            "<leader>fb",
            ":Telescope git_branches<CR>",
            opts_with_desc("find branches")
        )

        -- work sessions
        map(
            "n",
            "<leader>fs",
            ":Telescope session-lens search_session<CR>",
            opts_with_desc("find sessions")
        )
    end,
}
