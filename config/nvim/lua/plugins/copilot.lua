require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    -- suggestion = {
    --     enabled = true,
    --     auto_trigger = true,
    --     hide_during_completion = false,
    -- },
    server_opts_overrides = {
        trace = "verbose",
    },
    filetypes = {
        yaml = true,
        markdown = true,
        gitcommit = true,
        gitrebase = true,
        ["*"] = function()
            -- disable for files with specific names
            local fname = vim.fs.basename(vim.api.nvim_buf_get_name(0))
            local disable_patterns = { "env", "conf", "local", "private" }
            return vim.iter(disable_patterns):all(function(pattern)
                return not string.match(fname, pattern)
            end)
        end,
    },
})
