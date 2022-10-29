local ok, notify = pcall(require, "notify")
if not ok then
	vim.notify("没有安装插件: notify")
	return
end

vim.notify = require("notify")
