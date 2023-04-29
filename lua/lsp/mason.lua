-- note:
-- It's important that you set up the plugins in the following order:
-- 1, mason.nvim
-- 2, mason-lspconfig.nvim
-- 3, Setup servers via lspconfig

-------------------------------------
-- setup mason
-------------------------------------
local mason_status, mason = pcall(require, "mason")
if not mason_status then
    vim.notify("没有安装插件: mason")
    return
end

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
})

-------------------------------------
-- setup mason-lspconfig
-------------------------------------
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
    vim.notify("没有安装插件: mason-lspconfig")
    return
end

local lsp_servers = {
    "pyright",
    "lua_ls",
    "gopls",
    "clangd",
    "tsserver",
    "rust_analyzer",
}

mason_lspconfig.setup({
    ensure_installed = lsp_servers,
    automatic_installation = true,
})

-------------------------------------
-- setup lspconfig
-------------------------------------
local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    vim.notify("没有安装插件: lspconfig")
    return
end

local opts = {}

for _, server in pairs(lsp_servers) do
    opts = {
        on_attach = require("lsp.handlers").on_attach,
        capabilities = require("lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    local require_ok, conf_opts = pcall(require, "lsp.config." .. server)
    if require_ok then
        -- vim.notify("load lsp config for " .. server)
        opts = vim.tbl_deep_extend("force", conf_opts, opts)
    end

    lspconfig[server].setup(opts)
end
