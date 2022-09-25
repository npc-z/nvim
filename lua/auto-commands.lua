local utils = require("utils")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		-- 移除行尾空格
		utils.trim_trailing_whitespace()
	end,
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },

	callback = function()
		-- 打开文件时自动跳转到上次位置
		vim.cmd([[
            if line("'\"") >= 1 && line("'\"") <= line("$")
            \ |   exe "normal! g`\""
            \ | endif
        ]])
	end,
})
