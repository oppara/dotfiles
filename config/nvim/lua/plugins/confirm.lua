require("conform").setup({
    formatters_by_ft = {
        lua = { "stylua" },
        php = { "phpcbf", "php_cs_fixer", stop_after_first = true },
        sh = { "shfmt" },
        yaml = { "yamlfmt" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        sass = { "prettier" },
        less = { "prettier" },
        markdown = { "markdownlint-cli2" },
    },

    formatters = {
        shfmt = {
            prepend_args = { "-i", "2", "-ci", "-bn", "-s" },
        },
        yamlfmt = {
            command = "yamlfmt",
            args = { "-" }, -- stdin
            stdin = true,
        },
    },

    format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
    },
})
