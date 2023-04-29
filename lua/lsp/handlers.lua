local M = {}

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return
end

local has_value = require("utils").has_value

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    local signs = {
        { name = "DiagnosticSignError", text = "" },
        { name = "DiagnosticSignWarn",  text = "" },
        { name = "DiagnosticSignHint",  text = "" },
        { name = "DiagnosticSignInfo",  text = "" },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        virtual_text = false, -- disable virtual text
        signs = {
            active = signs,   -- show signs
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
    })
end

M.on_attach = function(client, bufnr)
    local format_by_null_ls_servers = {
        "tsserver",
        "sumneko_lua",
        -- "clang",
    }

    if has_value(format_by_null_ls_servers, client.name) then
        client.server_capabilities.documentFormattingProvider = false
    end

    -- 绑定快捷键
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    require("plugins-keybindings").mapLSP(buf_set_keymap)

    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
end

return M
