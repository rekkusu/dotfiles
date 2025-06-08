return {
    {
        'mason-org/mason.nvim',
        opts = {},
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.config('lua_ls', {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim' }
                        },
                    }
                }
            });
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function()
                    vim.lsp.buf.format {
                        filter = function(client)
                            return client.name ~= "ts_ls"
                        end
                    }
                end,
            })
        end,
        dependencies = {
            {
                'mason-org/mason-lspconfig.nvim',
                opts = {},
            },
        }
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            local null_ls = require('null-ls')
            null_ls.setup({
                sources = {
                    require("none-ls.diagnostics.eslint_d"),
                    require("none-ls.formatting.eslint_d"),
                },
            })
        end,
        dependencies = {
            "nvimtools/none-ls-extras.nvim",
        },
    },
}
