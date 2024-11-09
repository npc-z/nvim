return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-tree/nvim-web-devicons",
        {
            "aaronhallaert/advanced-git-search.nvim",
            cmd = { "AdvancedGitSearch" },
            dependencies = {
                "sindrets/diffview.nvim",
            },
        },

        -- Tab-based Searching:
        -- Easily switch between different search modes, each represented by a tab.
        "FabianWirth/search.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local builtin = require("telescope.builtin")
        local actions = require("telescope.actions")
        local search_tab = require("search")

        search_tab.setup({
            initial_tab = 1,
            tabs = {
                {
                    "Files",
                    function(opts)
                        opts = opts or {}
                        if vim.fn.isdirectory(".git") == 1 then
                            builtin.git_files(opts)
                        else
                            builtin.find_files(opts)
                        end
                    end,
                },
                {
                    name = "Buffers",
                    tele_func = builtin.buffers,
                },
                {
                    name = "Grep",
                    tele_func = builtin.live_grep,
                },
                {
                    name = "Modified",
                    tele_func = builtin.git_status,
                },
                {
                    name = "current_buffer_fuzzy_find",
                    tele_func = builtin.current_buffer_fuzzy_find,
                },
            },
            -- collections usage: require('search').open({ collection = 'git' })
            collections = {
                git = {
                    initial_tab = 1, -- Git branches
                    tabs = {
                        { name = "Branches", tele_func = builtin.git_branches },
                        { name = "Commits", tele_func = builtin.git_commits },
                        { name = "Stashes", tele_func = builtin.git_stash },
                    },
                },
            },
        })

        local additional_args = {
            "--hidden",
            "--no-ignore-dot",
            "--hidden",
            -- this flag allows you to hide exclude these files and folders from your search 👇
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/.vscode/*",
            "--glob=!**/build/*",
            "--glob=!**/dist/*",
            "--glob=!**/yarn.lock",
            "--glob=!**/package-lock.json",
        }

        telescope.setup({
            extensions = {
                advanced_git_search = {
                    git_diff_flags = {},
                    show_builtin_git_pickers = true,
                    diff_plugin = "diffview",
                    layout_config = {
                        horizontal = {
                            preview_width = 0.6,
                        },
                        -- Telescope layout setup
                        telescope_theme = {
                            -- function_name_1 = {
                            --     -- Theme options
                            -- },
                            function_name_2 = "dropdown",
                            -- e.g. realistic example
                            show_custom_functions = {
                                layout_config = { width = 0.4, height = 0.4 },
                            },
                        },
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                    -- needed to exclude some files & dirs from general search
                    -- when not included or specified in .gitignore
                    find_command = {
                        "rg",
                        "--files",
                        "--hidden",
                        "--glob=!**/.git/*",
                        "--glob=!**/.idea/*",
                        "--glob=!**/.vscode/*",
                        "--glob=!**/build/*",
                        "--glob=!**/dist/*",
                        "--glob=!**/yarn.lock",
                        "--glob=!**/package-lock.json",
                    },
                },
                grep_string = {
                    additional_args = additional_args,
                },
                live_grep = {
                    additional_args = additional_args,
                },
            },

            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--follow", -- Follow symbolic links
                    "--hidden", -- Search for hidden files
                    "--no-heading", -- Don't group matches by each file
                    "--with-filename", -- Print the file path with the matched lines
                    "--line-number", -- Show line numbers
                    "--column", -- Show column numbers
                    "--smart-case", -- Smart case search

                    -- Exclude some patterns from search
                    "--glob=!**/.git/*",
                    "--glob=!**/.idea/*",
                    "--glob=!**/.vscode/*",
                    "--glob=!**/build/*",
                    "--glob=!**/dist/*",
                    "--glob=!**/yarn.lock",
                    "--glob=!**/package-lock.json",
                },

                layout_config = { width = 0.95, height = 0.95, preview_cutoff = 1 },
                layout_strategy = "vertical",
                -- layout_strategy = "horizontal",
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
        telescope.load_extension("advanced_git_search")

        -- set keymaps
        local map = vim.api.nvim_set_keymap
        local opts = { noremap = true, silent = true }

        local opts_with_desc = function(desc)
            return vim.tbl_deep_extend("force", opts, { desc = desc })
        end

        function vim.getVisualSelection()
            vim.cmd("noau normal! \"vy\"")
            local text = vim.fn.getreg("v")
            vim.fn.setreg("v", {})

            text = string.gsub(text, "\n", "")
            if #text > 0 then
                return text
            else
                return ""
            end
        end

        -- Open Telescope
        map("n", "<C-p>", ":Telescope<CR>", opts_with_desc("Open Telescope"))
        -- map("n", "<C-S-p>", ":Telescope keymaps<CR>", opts_with_desc("find files"))

        vim.keymap.set("n", "<leader><leader>", function()
            search_tab.open()
        end, {
            noremap = true,
            silent = true,
            desc = "Open Search",
        })

        -- git
        map(
            "n",
            "<leader>gf",
            ":Telescope advanced_git_search show_custom_functions<CR>",
            opts_with_desc("advanced_[G]it_search [F]ind")
        )

        -- 查找文件
        -- map(
        --     "n",
        --     "<leader>ff",
        --     ":Telescope find_files<CR>",
        --     opts_with_desc("find files")
        -- )
        -- map(
        --     "n",
        --     "<leader>fr",
        --     ":Telescope oldfiles<CR>",
        --     opts_with_desc("find recent files")
        -- )
        -- map(
        --     "n",
        --     "<leader><leader>",
        --     ":Telescope buffers<CR>",
        --     opts_with_desc("find buffers")
        -- )

        -- 全局搜索
        -- map(
        --     "n",
        --     "<leader>fg",
        --     ":Telescope live_grep<CR>",
        --     opts_with_desc("global search")
        -- )
        map(
            "n",
            "<leader>fw",
            -- 末尾的 `<Esc>` 退出插入模式
            ":lua require('telescope.builtin').grep_string( {search = vim.fn.expand('<cword>')} )<CR><Esc>",
            opts_with_desc("search cword in global")
        )

        vim.keymap.set("v", "<space>fw", function()
            local tb = require("telescope.builtin")
            local text = vim.getVisualSelection()
            tb.live_grep({ default_text = text })
        end, opts_with_desc("search selected text in global"))

        -- git current_buffer_fuzzy_find
        -- map(
        --     "n",
        --     "<leader>fb",
        --     ":Telescope current_buffer_fuzzy_find<CR>",
        --     opts_with_desc("find current_buffer_fuzzy_find")
        -- )

        -- work sessions
        map(
            "n",
            "<leader>fs",
            ":Telescope session-lens search_session<CR>",
            opts_with_desc("[F]ind [S]essions")
        )
    end,
}
