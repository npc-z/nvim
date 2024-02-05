return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")
        -- code
        gitsigns.setup({
            current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                delay = 300,
                -- 让 blame 尽量显示在其他 virt_text 后面
                virt_text_priority = 10000,
            },
            current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d %H-%M-%S> - <summary>",
            max_file_length = 40000, -- Disable if file is longer than this (in lines)

            -- keymap
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                local function gitmap(mode, l, r, opts)
                    opts = opts or { noremap = true, silent = true }
                    opts.buffer = bufnr
                    opts.noremap = true
                    opts.silent = true
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                gitmap("n", "gj", function()
                    if vim.wo.diff then
                        return "gj"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "goto next hunk" })

                gitmap("n", "gJ", function()
                    if vim.wo.diff then
                        return "gj"
                    end
                    vim.schedule(function()
                        gs.next_hunk()
                        gs.preview_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "goto next hunk and preview it" })

                gitmap("n", "gk", function()
                    if vim.wo.diff then
                        return "gk"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "goto prev hunk" })

                gitmap("n", "gK", function()
                    if vim.wo.diff then
                        return "gk"
                    end
                    vim.schedule(function()
                        gs.prev_hunk()
                        gs.prev_hunk()
                    end)
                    return "<Ignore>"
                end, { expr = true, desc = "goto prev hunk and preview it" })

                -- Actions
                -- stage
                gitmap("n", "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
                gitmap("v", "<leader>hs", function()
                    gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end, { desc = "stage selected lines" })
                gitmap("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
                gitmap(
                    "n",
                    "<leader>hu",
                    gs.undo_stage_hunk,
                    { desc = "git undo stage hunk" }
                )

                -- reset
                -- gitmap('n', '<leader>hr', gs.reset_hunk, { desc = "reset hunk" })
                -- gitmap('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                --     { desc = "reset selected lines" }
                -- )
                -- gitmap("n", "<leader>hR", gs.reset_buffer, {desc = "reset buffer"})

                gitmap("n", "<leader>hp", gs.preview_hunk, { desc = "git preview hunk" })
                gitmap(
                    "n",
                    "<leader>hd",
                    gs.diffthis,
                    { desc = "diff against the index" }
                )
                gitmap("n", "<leader>hD", function()
                    gs.diffthis("~")
                end, { desc = "diff against the last commit" })
                gitmap(
                    "n",
                    "<leader>td",
                    gs.toggle_deleted,
                    { desc = "git toggle deleted" }
                )

                -- Text object
                gitmap(
                    { "o", "x" },
                    "ih",
                    ":<C-U>Gitsigns select_hunk<CR>",
                    { desc = "select hunk" }
                )
            end,
        })
    end,
}
