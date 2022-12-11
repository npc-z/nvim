local status, bufferline = pcall(require, "bufferline")
if not status then
	vim.notify("没有安装插件: bufferline")
	return
end

-- bufferline 配置
-- https://github.com/akinsho/bufferline.nvim#configuration
bufferline.setup({
	options = {
		-- close_command = "",
		-- right_mouse_command = "",
		-- 侧边栏配置
		-- 左侧让出 nvim-tree 的位置，显示文字 File Explorer
		-- For ₂
		-- numbers = function(opts)
		-- 	return string.format("%s", opts.lower(opts.ordinal))
		-- end,
		show_tab_indicators = true,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "Directory",
				text_align = "left",
			},
		},
		-- 使用 nvim 内置 LSP
		diagnostics = "nvim_lsp",
		-- 可选，显示 LSP 报错图标
		---@diagnostic disable-next-line: unused-local
		-- diagnostics_indicator = function(count, level, diagnostics_dict, context)
		--   local s = " "
		--   for e, n in pairs(diagnostics_dict) do
		--     local sym = e == "error" and " " or (e == "warning" and " " or "")
		--     s = s .. n .. sym
		--   end
		--   return s
		-- end,
	},
})
