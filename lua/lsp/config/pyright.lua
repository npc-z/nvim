return {
	cmd = { "pyright-langserver", "--stdio" },

	single_file_support = true,

	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				diagnosticMode = "workspace",
				useLibraryCodeForTypes = true,
				typeCheckingMode = "off",
			},
		},
	},
}
