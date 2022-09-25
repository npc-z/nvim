local utils = require("utils")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		-- 移除行尾空格
		utils.trim_trailing_whitespace()
	end,
})
