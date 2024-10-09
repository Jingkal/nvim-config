return {
    -- ////////////////////////////
    {
        'kylechui/nvim-surround',
        version = '*',
        event = "VeryLazy",
        opts = {},
    },

    -- ////////////////////////////
    {
        'Wansmer/treesj',
        keys = { { '<leader>j', '<cmd>TSJToggle<cr>', desc = 'Toggle Treesitter Join' } },
        cmd = { 'TSJToggle', 'TSJSplit', 'TSJJoin' },
        opts = { use_default_keymaps = false }
    },

    -- ////////////////////////////
    {
        'numToStr/Comment.nvim',
        keys = { '<leader>/', '<leader>\\' },
        config = function()
            require('Comment').setup({
                toggler = {
                    line = '<leader>//', block = '<leader>\\\\',
                },
                opleader = {
                    line = '<leader>/', block = '<leader>\\'
                },
                extra = {
                    above = '<leader>/O', below = '<leader>/o', eol = '<leader>/A'
                },
                mappings = { basic = true, extra = false, },
                pre_hook = nil,
                post_hook = nil,
            })
        end
    },

    -- ////////////////////////////
    {
        'stevearc/oil.nvim',
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            view_options = {
                show_hidden = true,
                is_hidden_file = function(name, bufnr)
                    return vim.startswith(name, ".")
                end,
                is_always_hidden = function(name, bufnr)
                    return false
                end,
            }
        },
    },

    -- ////////////////////////////
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        config = function()
            require("ibl").setup()
        end,
    },
}
