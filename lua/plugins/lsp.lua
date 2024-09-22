return {
    -- ////////////////////////////////////
    -- ///////// Mason-LSP
    -- ////////////////////////////////////
    {
        'williamboman/mason-lspconfig.nvim',

        event = { 'BufReadPost', 'BufNewFile' },

        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason.nvim',
            'hrsh7th/cmp-nvim-lsp',
        },

        opts = {
            ensure_installed = {
                "lua_ls", "clangd", 'bashls', "pyright", "cmake"
            },
        },

        config = function(opts)
            local lspconfig = require('lspconfig')
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            require("mason-lspconfig").setup(opts)
            require("mason-lspconfig").setup_handlers({
                -- Handlers ------ BEGIN
                -- default
                function(ls_name)
                    lspconfig[ls_name].setup { capabilities = capabilities }
                end,
                -- sh
                ['bashls'] = function()
                    lspconfig.bashls.setup({
                        filetypes = { "sh", "zsh", "bash" },
                        capabilities = capabilities })
                end,
                -- Lua
                ['lua_ls'] = function()
                    lspconfig.lua_ls.setup ({
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = {
                                    version = 'LuaJIT',
                                    path = vim.split(package.path, ';')
                                },
                                diagnostics = {
                                    -- Recognize Neovim's `vim` global and API functions
                                    globals = { 'vim' }
                                },
                                workspace = {
                                    -- Make the server aware of Neovim runtime files
                                    library = {
                                        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                                        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                                    },
                                    maxPreload = 10000,
                                    preloadFileSize = 10000
                                },
                                telemetry = {
                                    enable = false -- Disable telemetry for privacy
                                }
                            }
                        }
                    })
                end
                -- other
                -- Handlers ------ END
            })
        end,
    },


    -- ////////////////////////////////////
    -- ///////// LspConfig
    -- ////////////////////////////////////
    {
        'neovim/nvim-lspconfig',

        config = function()
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n',          'gD',        vim.lsp.buf.declaration,     opts)
                    vim.keymap.set('n',          'gd',        vim.lsp.buf.definition,      opts)
                    vim.keymap.set('n',          '<space>D',  vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n',          'K',         vim.lsp.buf.hover,           opts)
                    vim.keymap.set({'i', 'n'},   '<C-k>',     vim.lsp.buf.signature_help,  opts)
                    vim.keymap.set('n',          'gi',        vim.lsp.buf.implementation,  opts)
                    vim.keymap.set('n',          '<F2>',      vim.lsp.buf.rename,          opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action,     opts)
                    vim.keymap.set('n', 'g=',
                        function() vim.lsp.buf.format { async = true } end, opts)
                end,
            })
        end
    },


    -- ////////////////////////////////////
    -- ///////// Mason
    -- ////////////////////////////////////
    {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        opts = {
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        },
        config = function(opts) require("mason").setup(opts) end,
    }
}
