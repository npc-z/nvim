local status_ok, hop = pcall(require, "hop")
if not status_ok then
	vim.notify("没有安装插件: hop")
end

-- default
-- hop.setup({ keys = "etovxqpdygfblzhckisuran" })
hop.setup({ keys = "adfghklqweruiopmnvc" })

require("lua.plugins-keybindings").hop_keybings()
