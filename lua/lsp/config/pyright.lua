local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local opts = {
	cmd = { "pyright-langserver", "--stdio" },

	single_file_support = true,

	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
			},
		},
	},

	--
	on_attach = function(client, bufnr)
		-- 通用配置
		require("lsp.config.common-attach").commont_on_attach(client, bufnr)
	end,
}

return {
	on_setup = function(server)
		server:setup(opts)
	end,
}
