vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.api.nvim_set_keymap
-- 复用 opt 参数
local opt = { noremap = true, silent = true }
--
-- 插件快捷键绑定
--
local pluginKeys = {}

-- nivm-tree
-- 打开文件树
map("n", "<leader>e", ":NvimTreeToggle<CR>", opt)

pluginKeys.nvimTreeList = {
	-- 打开文件或文件夹
	{ key = { "<CR>", "o", "<2-LeftMouse>" }, action = "edit" },
	-- 分屏打开文件
	{ key = "v", action = "vsplit" },
	{ key = "h", action = "split" },
	-- 显示隐藏文件
	{ key = "i", action = "toggle_custom" }, -- 对应 filters 中的 custom (node_modules)
	{ key = ".", action = "toggle_dotfiles" }, -- Hide (dotfiles)
	-- 文件操作
	{ key = "<F5>", action = "refresh" },
	{ key = "a", action = "create" },
	{ key = "d", action = "remove" },
	{ key = "r", action = "rename" },
	{ key = "x", action = "cut" },
	{ key = "c", action = "copy" },
	{ key = "p", action = "paste" },
}

-- bufferline
-- 左右Tab切换
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", opt)
map("n", "<S-l>", ":BufferLineCycleNext<CR>", opt)

-- 关闭
map("n", "<C-w>", ":bdelete<CR>", opt)
map("n", "<leader>bl", ":BufferLineCloseRight<CR>", opt)
map("n", "<leader>bh", ":BufferLineCloseLeft<CR>", opt)
map("n", "<leader>bc", ":BufferLinePickClose<CR>", opt)
map("n", "<leader>bp", ":BufferLineTogglePin<CR>", opt)

-- Telescope
-- 查找文件
map("n", "<leader>ff", ":Telescope find_files<CR>", opt)
-- 全局搜索
map("n", "<leader>fg", ":Telescope live_grep<CR>", opt)
-- Telescope 列表中 插入模式快捷键
pluginKeys.telescopeList = {
	i = {
		-- 上下移动
		["<C-j>"] = "move_selection_next",
		["<C-k>"] = "move_selection_previous",
		["<Down>"] = "move_selection_next",
		["<Up>"] = "move_selection_previous",
		-- 历史记录
		["<C-n>"] = "cycle_history_next",
		["<C-p>"] = "cycle_history_prev",
		-- 关闭窗口
		["<C-c>"] = "close",
		-- 预览窗口上下滚动
		["<C-u>"] = "preview_scrolling_up",
		["<C-d>"] = "preview_scrolling_down",
	},
}

--
-- lsp 回调函数快捷键设置
--
pluginKeys.mapLSP = function(mapbuf)
	-- go xx
	mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
	mapbuf("n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opt)
	mapbuf("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opt)
	mapbuf("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opt)
	mapbuf("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opt)
	mapbuf("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opt)

	-- rename
	-- mapbuf("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opt)
	-- code action
	-- mapbuf("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opt)
	-- diagnostic
	-- mapbuf("n", "gp", "<cmd>lua vim.diagnostic.open_float()<CR>", opt)
	-- mapbuf("n", "gk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opt)
	-- mapbuf("n", "gj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opt)
	-- mapbuf("n", "<leader>fmt", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)
	--

	-- 使用 Lspsaga
	-- rename
	mapbuf("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opt)
	-- code action
	mapbuf("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opt)
	mapbuf("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opt)
	mapbuf("n", "gh", "<cmd>Lspsaga hover_doc<cr>", opt)
	mapbuf("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", opt)
	-- diagnostic
	mapbuf("n", "gp", "<cmd>Lspsaga show_line_diagnostics<CR>", opt)
	mapbuf("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opt)
	mapbuf("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opt)
	mapbuf("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opt)

	-- Outline
	mapbuf("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

	-- Hover Doc
	-- 同上面快捷键 gh
	-- mapbuf("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

	-- 没用到
	-- mapbuf('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opt)
	-- mapbuf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opt)
	-- mapbuf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opt)
	-- mapbuf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opt)
	-- mapbuf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opt)
end

local status_ok, _ = pcall(require, "lspsaga")
if not status_ok then
	vim.notify("没有安装插件: lspsaga. When setup lspsaga keybindings")
else
	-- Float terminal
	-- map("n", "<S-j>", "<cmd>Lspsaga open_floaterm<CR>", { silent = true })
	-- if you want pass somc cli command into terminal you can do like this
	-- open lazygit in lspsaga float terminal
	-- mapbuf("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
	-- close floaterm
	-- map("t", "<S-j>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
end

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--
-- nvim-cmp 自动补全
--
pluginKeys.cmp = function(cmp)
	-- 在下面绑定 tab 健时有用
	-- require('luasnip') -- For `luasnip` users.
	-- require('snippy') -- For `snippy` users.
	-- local status, luasnip = pcall(require, "luasnip")
	-- if not status then
	-- 	vim.notify("没有安装插件: luasnip")
	-- 	return
	-- end

	-- for `vsnip` users
	local vsnip = vim.fn["vsnip#anonymous"]
	-- For `ultisnips` users.
	-- vim.fn["UltiSnips#Anon"]

	return {
		-- 出现补全
		["<C-.>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		-- 取消
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- 上一个
		["<C-k>"] = cmp.mapping.select_prev_item(),
		-- 下一个
		["<C-j>"] = cmp.mapping.select_next_item(),
		-- 确认
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		-- 如果窗口内容太多，可以滚动
		["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
				-- vsnip 不支持函数模板
				-- elseif vsnip.expandable() then
				-- vsnip.expand({})
				-- elseif vsnip.expand_or_jumpable() then
				-- vsnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
				-- vsnip 不支持函数模板
				-- elseif vsnip.jumpable(-1) then
				-- vsnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}
end

-- 代码注释插件
pluginKeys.comment = {
	-- Normal 模式快捷键
	-- LHS of toggle mappings in NORMAL + VISUAL mode
	-- @type table
	toggler = {
		---Line-comment toggle keymap
		-- For some reason, vim registers <C-/> as <C-_> (you can see it in insert mode using <C-v><C-/>).
		-- It can be the terminal or a historical design thing that terminal apps have to suffer.
		-- And Gvim doesn't even try to recognize <C-/>. Sees it as single /.
		line = "<C-_>",
		-- line = "<leader>/",
		-- Block-comment toggle keymap
		block = "gbc",
	},

	-- LHS of operator-pending mappings in NORMAL + VISUAL mode
	-- @type table
	opleader = {
		---Line-comment keymap
		line = "gc",
		---Block-comment keymap
		block = "gb",
	},
}

-- gitsigns keymap
pluginKeys.gitsigns_keymap = function(bufnr)
	local gs = package.loaded.gitsigns

	local function gitmap(mode, l, r, opts)
		opts = opts or { noremap = true, silent = true }
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end

	-- Navigation
	gitmap("n", "<leader>hn", function()
		if vim.wo.diff then
			return "<leader>hn"
		end
		vim.schedule(function()
			gs.next_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	gitmap("n", "<leader>hN", function()
		if vim.wo.diff then
			return "<leader>hN"
		end
		vim.schedule(function()
			gs.prev_hunk()
		end)
		return "<Ignore>"
	end, { expr = true })

	-- Actions
	gitmap({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
	-- gitmap({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
	gitmap("n", "<leader>hS", gs.stage_buffer)
	gitmap("n", "<leader>hu", gs.undo_stage_hunk)
	-- gitmap("n", "<leader>hR", gs.reset_buffer)
	gitmap("n", "<leader>hp", gs.preview_hunk)
	-- gitmap("n", "<leader>hb", function()
	-- 	gs.blame_line({ full = true })
	-- end)
	-- gitmap("n", "<leader>tb", gs.toggle_current_line_blame)
	-- gitmap("n", "<leader>hD", gs.diffthis)
	gitmap("n", "<leader>hd", function()
		gs.diffthis("~")
	end)
	-- gitmap("n", "<leader>td", gs.toggle_deleted)

	-- Text object
	-- gitmap({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

pluginKeys.hop_keybings = function()
	-- go to any line
	map("n", "<leader>gl", ":HopLine<CR>", opt)
	map("n", "/", ":HopPattern<CR>", opt)
	-- 改变 f 的工作方式, 查找当前行所有单字符, 而不仅是光标之后的
	map("", "f", ":HopChar1CurrentLine<CR>", opt)
	map("", "F", ":HopChar1CurrentLineBC<CR>", opt)
	map("", "t", ":HopChar1CurrentLineAC<CR>", opt)
	map("", "T", ":HopChar1CurrentLineBC<CR>", opt)
end

return pluginKeys
