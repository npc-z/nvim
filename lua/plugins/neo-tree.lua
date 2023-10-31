return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        {
            "s1n7ax/nvim-window-picker",
            version = "2.*",
            config = function()
                require("window-picker").setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { "neo-tree", "neo-tree-popup", "notify" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { "terminal", "quickfix" },
                        },
                    },
                })
            end,
        },
    },

    config = function()
        require("neo-tree").setup({
            close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab

            filesystem = {
                filtered_items = {
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    -- This will find and focus the file in the active buffer every time
                    -- the current file is changed while the tree is open.
                    enabled = true,
                    -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
                    leave_dirs_open = false,
                },
            },

            window = {
                position = "right",
            },

            default_source = "filesystem",
            source_selector = {
                winbar = true,
                statusline = true,
                content_layout = "center",
                sources = {
                    { source = "filesystem", display_name = " 󰉓 Files " },
                    { source = "git_status", display_name = " 󰊢 Git " },
                    { source = "buffers", display_name = " Buffers" },
                },
            },
        })

        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        map("n", "<leader>e", ":Neotree toggle<CR>", opts)
        map("n", "<leader>E", ":Neotree toggle position=float<CR>", opts)
    end,
}
