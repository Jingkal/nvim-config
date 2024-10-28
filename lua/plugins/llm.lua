vim.api.nvim_set_keymap("v", "<leader>ie", '<cmd>lua require("codecompanion").prompt("explain")<cr>', { noremap = true, silent = true, })
vim.api.nvim_set_keymap("n", "<leader>ic", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, })
vim.api.nvim_set_keymap("n", "<leader>ii", "<cmd>CodeCompanion ", { noremap = true, silent = true, })


return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
        "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
        { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
    },
    cmd = {
        'CodeCompanion',
        'CodeCompanionChat',
        'CodeCompanionToggle',
        'CodeCompanionActions',
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "ollama",
                },
                inline = {
                    adapter = "ollama",
                },
                agent = {
                    adapter = "ollama",
                },
            },
            adapters = {
                ollama = function()
                    return require("codecompanion.adapters").extend("ollama", {
                        scheme = {
                            -- model = { default = 'qwen2.5-coder:7b' }
                            model = { default = 'codellama:13b' }
                        },
                        env = {
                            url = "http://10.0.0.10:11434",
                        },
                        headers = {
                            ["Content-Type"] = "application/json",
                        },
                        parameters = {
                            sync = true,
                        },
                    })
                end,
            },
        })
    end
}
