local commont_on_attach = function(client, bufnr)
	-- 禁用格式化功能，交给专门插件插件处理
	client.server_capabilities.document_formatting = false
	client.server_capabilities.document_range_formatting = false

	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end

	-- 绑定快捷键
	require("plugins-keybindings").mapLSP(buf_set_keymap)

	-- 保存时自动格式化
	vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")

	-- automatic highlighting references with LSP
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
		vim.api.nvim_create_autocmd("CursorHold", {
			callback = vim.lsp.buf.document_highlight,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Document Highlight",
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			callback = vim.lsp.buf.clear_references,
			buffer = bufnr,
			group = "lsp_document_highlight",
			desc = "Clear All the References",
		})
	end
end

local M = {}

M.commont_on_attach = commont_on_attach

return M
