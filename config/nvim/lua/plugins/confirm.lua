require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "phpcbf", "php_cs_fixer", stop_after_first = true },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
