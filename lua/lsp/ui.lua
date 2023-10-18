vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    -- 在输入模式下也更新提示，设置为 true 也许会影响性能
    update_in_insert = true,
})

local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local lspsaga_status, lspsaga = pcall(require, "lspsaga")
if not lspsaga_status then
    vim.notify("没有安装插件: lspsaga")
    return
end

lspsaga.setup({
    lightbulb = {
        enable = true,
        enable_in_insert = false,
        sign = true,
        sign_priority = 40,
        virtual_text = false,
    },
})
