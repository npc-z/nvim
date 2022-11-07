local function __init_lspkind(lk)
	lk.init({
		-- default: true
		-- with_text = true,
		-- defines how annotations are shown
		-- default: symbol
		-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
		mode = "symbol_text",
		-- default symbol map
		-- can be either 'default' (requires nerd-fonts font) or
		-- 'codicons' for codicon preset (requires vscode-codicons font)
		--
		-- default: 'default'
		preset = "codicons",
		-- override preset symbols
		--
		-- default: {}
		symbol_map = {
			Text = "",
			Method = "m",
			Function = "",
			Constructor = "",
			Field = "",
			Variable = "",
			Class = "",
			Interface = "",
			Module = "",
			Property = "",
			Unit = "",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	})
end

local function __init_lspsaga(saga)
	saga.init_lsp_saga({
		-- Options with default value
		-- "single" | "double" | "rounded" | "bold" | "plus"
		border_style = "rounded",
		--the range of 0 for fully opaque window (disabled) to 100 for fully
		--transparent background. Values between 0-30 are typically most useful.
		saga_winblend = 0,
		-- when cursor in saga window you config these to move
		move_in_saga = { prev = "<C-p>", next = "<C-n>" },
		-- Error, Warn, Info, Hint
		-- use emoji like
		-- { "🙀", "😿", "😾", "😺" }
		-- or
		-- { "😡", "😥", "😤", "😐" }
		-- and diagnostic_header can be a function type
		-- must return a string and when diagnostic_header
		-- is function type it will have a param `entry`
		-- entry is a table type has these filed
		-- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
		diagnostic_header = { " ", " ", " ", "ﴞ " },
		-- preview lines of lsp_finder and definition preview
		max_preview_lines = 45,
		-- use emoji lightbulb in default
		code_action_icon = "💡",
		-- if true can press number to execute the codeaction in codeaction window
		code_action_num_shortcut = true,
		-- same as nvim-lightbulb but async
		code_action_lightbulb = {
			enable = true,
			enable_in_insert = true,
			cache_code_action = true,
			sign = true,
			update_time = 150,
			sign_priority = 20,
			virtual_text = true,
		},
		-- finder icons
		finder_icons = {
			def = "  ",
			ref = "諭 ",
			link = "  ",
		},
		-- finder do lsp request timeout
		-- if your project big enough or your server very slow
		-- you may need to increase this value
		finder_request_timeout = 1500,
		finder_action_keys = {
			open = "o",
			vsplit = "s",
			split = "i",
			tabe = "t",
			quit = "q",
		},
		code_action_keys = {
			quit = "q",
			exec = "<CR>",
		},
		definition_action_keys = {
			edit = "<C-c>o",
			vsplit = "<C-c>v",
			split = "<C-c>i",
			tabe = "<C-c>t",
			quit = "q",
		},
		-- rename_action_quit = "<C-c>",
		rename_action_quit = "<Esc>",
		rename_in_select = true,
		-- show symbols in winbar must nightly
		symbol_in_winbar = {
			in_custom = false,
			enable = false,
			separator = " ",
			show_file = false,
			click_support = function(node, clicks, button, modifiers)
				-- To see all avaiable details: vim.pretty_print(node)
				local st = node.range.start
				local en = node.range["end"]
				if button == "l" then
					if clicks == 2 then
					-- double left click to do nothing
					else -- jump to node's starting line+char
						vim.fn.cursor(st.line + 1, st.character + 1)
					end
				elseif button == "r" then
					if modifiers == "s" then
						print("lspsaga") -- shift right click to print "lspsaga"
					end -- jump to node's ending line+char
					vim.fn.cursor(en.line + 1, en.character + 1)
				elseif button == "m" then
					-- middle click to visual select node
					vim.fn.cursor(st.line + 1, st.character + 1)
					vim.cmd("normal v")
					vim.fn.cursor(en.line + 1, en.character + 1)
				end
			end,
		},
		-- show outline
		show_outline = {
			win_position = "right",
			--set special filetype win that outline window split.like NvimTree neotree
			-- defx, db_ui
			win_with = "",
			win_width = 30,
			auto_enter = true,
			auto_preview = true,
			virt_text = "┃",
			jump_key = "<CR>",
			-- auto refresh when change buffer
			auto_refresh = true,
		},
		-- custom lsp kind
		-- usage { Field = 'color code'} or {Field = {your icon, your color code}}
		custom_kind = {},
		-- if you don't use nvim-lspconfig you must pass your server name and
		-- the related filetypes into this table
		-- like server_filetype_map = { metals = { "sbt", "scala" } }
		server_filetype_map = {},
	})
end

vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	-- 在输入模式下也更新提示，设置为 true 也许会影响性能
	update_in_insert = true,
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- lspkind
local status_ok, lspkind = pcall(require, "lspkind")
if not status_ok then
	vim.notify("没有安装插件: lspkind")
else
	__init_lspkind(lspkind)
end

local M = {}
-- 为 cmp.lua 提供参数格式
M.formatting = {
	fields = {
		"kind",
		"abbr",
		"menu",
	},

	format = lspkind.cmp_format({
		-- mode = "symbol_text",
		mode = "symbol", -- show only symbol annotations

		maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
		-- The function below will be called before any actual modifications from lspkind
		-- so that you can provide more controls on popup customization.
		-- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
		before = function(entry, vim_item)
			-- Source 显示提示来源
			vim_item.menu = "[" .. string.upper(entry.source.name) .. "]"
			return vim_item
		end,
	}),
}

local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
	vim.notify("没有安装插件: lspsaga")
else
	__init_lspsaga(lspsaga)
end

return M
