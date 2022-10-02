local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local opts = {
	settings = {
		clangd = {},
	},

	--
	flags = {
		debounce_text_changes = 150,
	},

	--
	on_attach = function(client, bufnr)
		-- 通用配置
		require("lsp.config.common-attach").commont_on_attach(client, bufnr)
	end,
}

-- 查看目录等信息
return {
	on_setup = function(server)
		server:setup(opts)
	end,
    opts = opts,
}
