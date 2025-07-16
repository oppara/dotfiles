local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    sh = { "shellcheck" },
    yaml = { "yamllint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
    callback = function()
        require("lint").try_lint()
    end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = ".github/workflows/*.yml",
    callback = function()
        lint.linters_by_ft.yaml = { "yamllint", "actionlint" }
    end,
})
