local status, autosave = pcall(require, "auto-save")
if not status then
	vim.notify("没有安装插件: auto-save")
	return
end

local tool = require("utils")

autosave.setup({
	-- start auto-save when the plugin is loaded
	enabled = true,
	execution_message = {
		message = function() -- message to print on save
			return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S"))
		end,
		-- dim the color of `message`
		dim = 0.18,
		-- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
		cleaning_interval = 1250,
	},
	-- vim events that trigger auto-save. See :h events
	trigger_events = {
		"InsertLeave",
		-- "TextChanged",
	},

	-- function that determines whether to save the current buffer or not
	-- return true: if buffer is ok to be saved
	-- return false: if it's not ok to be saved
	condition = function(buf)
		local fn = vim.fn
		local utils = require("auto-save.utils.data")

		local filename = tool.cur_buf_filename()
		-- 如果是此文件则不要自动保存
		if filename == "plugins.lua" then
			return false
		end

		if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
			return true -- met condition(s), can save
		end
		return false -- can't save
	end,
	-- write all buffers when the current one meets `condition`
	write_all_buffers = false,
	-- saves the file at most every `debounce_delay` milliseconds
	debounce_delay = 20000,

	-- functions to be executed at different intervals
	callbacks = {
		-- ran when enabling auto-save
		enabling = nil,
		-- ran when disabling auto-save
		disabling = nil,
		-- ran before checking `condition`
		before_asserting_save = nil,
		-- ran before doing the actual save
		before_saving = function()
			-- 没有生效 https://github.com/Pocco81/auto-save.nvim/issues/56
		end,
		-- ran after doing the actual save
		after_saving = function()
			--
		end,
	},
})
