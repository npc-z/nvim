local status, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status then
	vim.notify("没有安装插件: nvim-lsp-installer")
	return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
	vim.notify("没有安装插件: lspconfig")
	return
end

-- 安装列表
-- { key: 语言 value: 配置文件 }
-- key 必须为下列网址列出的名称
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
	-- pyright = require("lsp.config.pyright"),
	-- sumneko_lua = require("lsp.config.lua"), -- lua/lsp/config/lua.lua
	-- gopls = require("lsp.config.gopls"),
	-- clangd = require("lsp.config.clangd"),
	"pyright",
	"sumneko_lua",
	"gopls",
	"clangd",
}

-- 自动安装 Language Servers
for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found then
		if not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end

lsp_installer.setup({})

lspconfig.pyright.setup(require("lsp.config.pyright").opts)
lspconfig.sumneko_lua.setup(require("lsp.config.lua").opts)
lspconfig.gopls.setup(require("lsp.config.gopls").opts)
lspconfig.clangd.setup(require("lsp.config.clangd").opts)

-- 废弃的初始化方式
-- 只能显示的初始化 lsp server 了?
-- lsp_installer.on_server_ready(function(server)
-- 	local config = servers[server.name]
-- 	vim.notify("server.name " .. server.name)
-- 	if config == nil then
-- 		return
-- 	end
-- 	if config.on_setup then
-- 		config.on_setup(server)
-- 	else
-- 		server:setup({})
-- 	end
-- end)
