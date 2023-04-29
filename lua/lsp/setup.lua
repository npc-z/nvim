local lspconfig_status_ok, _ = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    vim.notify("没有安装插件: lspconfig")
    return
end

require("lsp.mason")
require("lsp.handlers").setup()
require("lsp.signature")
