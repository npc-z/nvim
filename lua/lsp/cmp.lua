local status, cmp = pcall(require, "cmp")
if not status then
    vim.notify("没有安装插件: nvim-cmp")
    return
end

local check_backspace = function()
    local col = vim.fn.col(".") - 1
    return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

-- find more here: https://www.nerdfonts.com/cheat-sheet
local kind_icons = {
    Text = "",
    Method = "m",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "",
    Interface = "",
    Module = "",
    Property = "",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = "",
}

cmp.setup({
    -- 指定 snippet 引擎
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    -- 补全源
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "vsnip" },
    }, { { name = "buffer" }, { name = "path" } }),
    -- 快捷键设置
    mapping = cmp.mapping.preset.insert({
        -- 出现补全
        ["<C-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        -- 取消
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        -- 上一个
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        -- 下一个
        ["<C-j>"] = cmp.mapping.select_next_item(),
        -- 确认
        ["<CR>"] = cmp.mapping.confirm({
            select = true,
            behavior = cmp.ConfirmBehavior.Replace,
        }),
        -- 如果窗口内容太多，可以滚动
        ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif check_backspace() then
                fallback()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {
            "i",
            "s",
        }),
    }),
    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
                nvim_lsp = "[LSP]",
                luasnip = "[Snippet]",
                buffer = "[Buffer]",
                path = "[Path]",
            })[entry.source.name]
            return vim_item
        end,
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
