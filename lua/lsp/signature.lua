local status, lsp_signature = pcall(require, "lsp_signature")
if not status then
    vim.notify("没有安装插件: lsp_signature")
    return
end

local cfg = {
    hint_prefix = " ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
}

lsp_signature.setup(cfg)
