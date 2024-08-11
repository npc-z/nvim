local function add_snippets()
    local utils = require("utils")
    local ls = require("luasnip")
    local s = ls.snippet
    local f = ls.function_node
    -- local sn = ls.snippet_node
    -- local isn = ls.indent_snippet_node
    -- local t = ls.text_node
    -- local i = ls.insert_node
    -- local c = ls.choice_node
    -- local d = ls.dynamic_node
    -- local r = ls.restore_node
    -- local events = require("luasnip.util.events")
    -- local ai = require("luasnip.nodes.absolute_indexer")
    -- local extras = require("luasnip.extras")
    -- local fmt = extras.fmt
    -- local m = extras.m
    -- local l = extras.l
    -- local postfix = require("luasnip.extras.postfix").postfix

    ls.add_snippets("all", {
        -- 周X
        s("week", {
            f(function()
                return utils.current_week_zh()
            end),
        }),
    })
end

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local mapping = function(cmp)
    return {
        -- 出现补全
        ["<C-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- 取消
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- 确认
        ["<CR>"] = cmp.mapping.confirm({ select = true }),

        ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion

        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif check_backspace() then
        --         fallback()
        --     else
        --         fallback()
        --     end
        -- end, {
        --     "i",
        --     "s",
        -- }),
        -- ["<S-Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_prev_item()
        --     else
        --         fallback()
        --     end
        -- end, {
        --     "i",
        --     "s",
        -- }),

        -- 如果窗口内容太多，可以滚动
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    }
end

return {
    "hrsh7th/nvim-cmp",
    -- event = "InsertEnter", -- 为了让 cmd 模式有效
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "hrsh7th/cmp-cmdline",

        -- snippet engine
        "L3MON4D3/LuaSnip",

        "saadparwaiz1/cmp_luasnip", -- for autocompletion
        "rafamadriz/friendly-snippets", -- useful snippets
        "onsails/lspkind.nvim", -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")

        add_snippets()

        -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
        require("luasnip.loaders.from_vscode").lazy_load()

        -- vim.keymap.set({ "i" }, "<Tab>", function()
        --     luasnip.expand()
        -- end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<Tab>", function()
            luasnip.jump(1)
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
            luasnip.jump(-1)
        end, { silent = true })

        -- vim.keymap.set({ "i", "s" }, "<C-E>", function()
        --     if luasnip.choice_active() then
        --         luasnip.change_choice(1)
        --     end
        -- end, { silent = true })

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },

            snippet = {
                -- configure how nvim-cmp interacts with snippet engine
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },

            mapping = cmp.mapping.preset.insert(mapping(cmp)),

            -- sources for autocompletion
            sources = cmp.config.sources({
                -- ai code completion
                { name = "codeium" },
                { name = "nvim_lsp" },
                -- snippets
                { name = "luasnip" },
                {
                    name = "buffer",
                    -- text within all buffers
                    option = {
                        get_bufnrs = function()
                            return vim.api.nvim_list_bufs()
                        end,
                    },
                },
                -- file system paths
                { name = "path" },
                {
                    name = "dictionary",
                    keyword_length = 2,
                },
            }),

            -- configure lspkind for vs-code like pictograms in completion menu
            formatting = {
                format = lspkind.cmp_format({
                    maxwidth = 50,
                    ellipsis_char = "...",
                }),
            },
        })

        -- / 查找模式使用 buffer 源
        cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- : 命令行模式中使用 path 和 cmdline 源.
        cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = "path" },
            }, {
                { name = "cmdline" },
            }),
        })
    end,
}
