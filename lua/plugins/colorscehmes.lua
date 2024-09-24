return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        enabled = true,
        priority = 1000,
        opts = {},
        config = function(opts)
            vim.cmd.colorscheme("tokyonight-storm")
        end,
    },
}
