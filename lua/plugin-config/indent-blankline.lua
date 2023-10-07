local status, ident_blankline = pcall(require, "ibl")
if not status then
    vim.notify("没有安装插件: indent_blankline")
    return
end

ident_blankline.setup()
