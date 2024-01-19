-- 标记常用文件
-- mark files

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.5",
        },
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon.setup({})

        -- basic telescope configuration
        local conf = require("telescope.config").values
        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end

        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }
        local opts_with_desc = function(desc)
            return vim.tbl_deep_extend("force", opts, { desc = desc })
        end

        map("n", "<leader>lm", function()
            toggle_telescope(harpoon:list())
        end, opts_with_desc("mostly used files"))

        map("n", "<leader>mf", function()
            harpoon:list():append()
        end, opts_with_desc("mark as mostly used file"))

        map("n", "<leader>tm", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end, opts_with_desc("toggle mostly used file"))

        -- Toggle previous & next buffers stored within Harpoon list
        -- vim.keymap.set("n", "<C-S-M>", function()
        --     harpoon:list():prev()
        -- end)
        -- vim.keymap.set("n", "<C-S-N>", function()
        --     harpoon:list():next()
        -- end)
    end,
}
