require("mason").setup()

local ensure_installed = {
    "lua_ls",
    "intelephense",
    "bashls",
    "yamlls",
}
require("mason-lspconfig").setup({
    automatic_installation = true,
    ensure_installed = ensure_installed,
})

vim.diagnostic.config({
    virtual_text = true,
})

local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<space>f", function()
        vim.lsp.buf.format({ async = true })
    end, opts)

    vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "g]", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, opts)
end

vim.lsp.config("*", {
    on_attach = on_attach,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.enable(ensure_installed)

vim.api.nvim_create_user_command("LspHealth", "checkhealth vim.lsp", { desc = "LSP health check" })

function ShowAvailableFormatters()
    local filetype = vim.bo.filetype
    local buf = vim.api.nvim_get_current_buf()
    local formatters = {}

    -- LSP クライアントから探す
    for _, client in pairs(vim.lsp.get_active_clients({ bufnr = buf })) do
        if client.supports_method("textDocument/formatting") then
            table.insert(formatters, client.name)
        end
    end

    -- -- null-ls を使っている場合の追加確認（任意）
    -- local has_null_ls, null_ls = pcall(require, "null-ls")
    -- if has_null_ls and null_ls then
    --   local sources = require("null-ls.sources").get_available(filetype, "NULL_LS_FORMATTING")
    --   for _, source in ipairs(sources) do
    --     table.insert(formatters, "null-ls: " .. source.name)
    --   end
    -- end

    if #formatters == 0 then
        vim.notify("No formatters available for filetype: " .. filetype, vim.log.levels.WARN)
    else
        vim.notify(
            "Available formatters for " .. filetype .. ": " .. table.concat(formatters, ", "),
            vim.log.levels.INFO
        )
    end
end
vim.keymap.set("n", "<leader>lf", ShowAvailableFormatters, { desc = "Show available formatters" })
