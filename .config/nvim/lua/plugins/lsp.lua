return {
    -- mason --
    {
        "williamboman/mason.nvim",
        event = "BufReadPost",
        config = function()
            require("mason").setup({
                ui = {
                    border = "single",
                },
            })
        end,
    },

    -- null-ls --
    {
        "stevearc/conform.nvim",
        keys = {
            { "<C-s>", "<cmd>lua require('conform').format()<cr>" },
        },
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                sh = { "shfmt" },
                bash = { "shfmt" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
        },
    },
}
