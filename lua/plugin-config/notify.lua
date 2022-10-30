local ok, notify = pcall(require, "notify")
if not ok then
	vim.notify("没有安装插件: notify")
	return
end

notify.setup({
	-- 在下面显示
	top_down = false,
	stages = "fade_in_slide_out",
	background_colour = "FloatShadow",
})

vim.notify = notify
