require "mason".setup()

local ensure_installed = {
  'lua_ls',
  'intelephense',
}
require("mason-lspconfig").setup({
  automatic_installation = true,
  ensure_installed = ensure_installed,
})

vim.diagnostic.config({
  virtual_text = true
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
  vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, opts)

  vim.keymap.set("n", "ge", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "g]", vim.diagnostic.goto_next, opts)
  vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, opts)
end

vim.lsp.config('*', {
  on_attach = on_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.enable(ensure_installed)

vim.api.nvim_create_user_command(
  "LspHealth",
  "checkhealth vim.lsp",
  { desc = "LSP health check" })
