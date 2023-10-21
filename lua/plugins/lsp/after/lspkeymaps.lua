M = {}

M.setup_keymaps = function(bufnr)
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    opts.buffer = bufnr

    opts.desc = "LSP references"
    keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

    -- opts.desc = "Go to declaration"
    -- keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    -- opts.desc = "Show LSP implementations"
    -- keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    -- opts.desc = "Show LSP type definitions"
    -- keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    -- see available code actions, in visual mode will apply to selection
    opts.desc = "See available code actions"
    keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Smart rename"
    keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "gh", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Show signature help"
    keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    -- opts.desc = "Restart LSP"
    -- keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
end

return M
