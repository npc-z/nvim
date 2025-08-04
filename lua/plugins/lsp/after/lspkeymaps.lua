---@diagnostic disable: cast-local-type

local function rename(opts)
    return function()
        require("plugins.lsp.after.rename").rename(opts)
    end
end

M = {}

M.setup_keymaps = function(bufnr)
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    opts.buffer = bufnr
    local use_goto_preview = not true
    local use_glance = not true

    local preview_references = "<cmd>Telescope lsp_references<CR>"
    local preview_definition = "<cmd>Telescope lsp_definitions<CR>"
    local preview_impl = "<cmd>Telescope lsp_implementations<CR>"
    --@type string|function
    local preview_declaration = vim.lsp.buf.declaration
    -- local preview_type_definition = "<cmd>Telescope lsp_type_definitions<CR>"

    local live_rename = require("live-rename")

    if use_goto_preview then
        -- local cmd = "gP <cmd>lua require('goto-preview').close_all_win()<CR>"
        preview_references =
            "<cmd>lua require('goto-preview').goto_preview_references()<CR>"
        preview_definition =
            "<cmd>lua require('goto-preview').goto_preview_definition()<CR>"
        -- local preview_type_definition =
        --     "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>"
        preview_impl =
            "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>"
        preview_declaration =
            "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>"
    elseif use_glance then
        preview_references = "<CMD>Glance references<CR>"
        preview_definition = "<CMD>Glance definitions<CR>"
        -- preview_type_definition = "<CMD>Glance type_definitions<CR>"
        preview_impl = "<CMD>Glance implementations<CR>"
    end

    opts.desc = "LSP references"
    keymap.set("n", "gr", preview_references, opts)

    opts.desc = "Go to declaration"
    keymap.set("n", "gD", preview_declaration, opts) -- go to declaration

    opts.desc = "Show LSP definitions"
    keymap.set("n", "gd", preview_definition, opts)

    opts.desc = "Show LSP implementations"
    keymap.set("n", "gi", preview_impl, opts)

    -- opts.desc = "Show LSP type definitions"
    -- keymap.set("n", "gt", preview_type_definition, opts)

    -- see available code actions, in visual mode will apply to selection
    opts.desc = "See available code actions"
    -- keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
    keymap.set({ "n", "v" }, "<C-.>", vim.lsp.buf.code_action, opts)

    opts.desc = "LSP rename"
    -- keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename
    -- start in normal mode and jump to the start of the word
    keymap.set("n", "<leader>rn", live_rename.rename, opts)

    opts.desc = "Show buffer diagnostics"
    keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

    opts.desc = "Show line diagnostics"
    keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

    -- jump to previous diagnostic in buffer
    opts.desc = "Go to previous diagnostic"
    keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, opts)

    -- jump to next diagnostic in buffer
    opts.desc = "Go to next diagnostic"
    keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, opts)

    opts.desc = "Show documentation for what is under cursor"
    keymap.set("n", "gh", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

    opts.desc = "Show signature help"
    keymap.set("n", "<leader>k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

    opts.desc = "Restart LSP"
    keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

    opts.desc = "toggle Inlay hints"
    keymap.set("n", "<leader>i", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ 0 }), { 0 })
    end, opts)
end

return M
