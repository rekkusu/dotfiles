return {
    {
        'bluz71/vim-moonfly-colors',
        priority = 1000,
        config = function()
            vim.cmd('colorscheme moonfly')
            vim.api.nvim_set_hl(0, 'CmpItemAbbr', { link = 'MoonflyWhite' })
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                theme = 'auto',
                icons_enabled = true,
            },
        },
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        config = function()
            require("neo-tree").setup({
                source_selector = {
                    winbar = true,
                    statusline = false
                },
                window = {
                    width = 30,
                    mappings = {
                        ["S"] = "split_with_window_picker",
                        ["s"] = "vsplit_with_window_picker",
                        ["P"] = {
                            "toggle_preview",
                            config = { use_float = true, use_image_nvim = true },
                        },
                    },
                },
            })
            vim.keymap.set('n', '<leader>f', '<cmd>Neotree<CR>')
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            'MunifTanjim/nui.nvim',
            '3rd/image.nvim',
        },
    },
    {
        'folke/noice.nvim',
        lazy = true,
        event = 'VeryLazy',
        opts = {
            messages = {
                enabled = false,
            },
            presets = {
                bottom_search = true,
            },
        },
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            local builtin = require('telescope.builtin')
            vim.keymap.set('n', '<leader>b', builtin.buffers, {})

            vim.keymap.set('n', '<leader>gf', builtin.find_files, {})
            vim.keymap.set('n', '<leader>gg', builtin.live_grep, {})
            vim.keymap.set('n', '<leader>gh', builtin.help_tags, {})
            vim.keymap.set('n', '<leader>gs', builtin.lsp_workspace_symbols, {})
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = 'all',
                highlight = { enable = true },
                indent = {
                    enable = true,
                },
            }
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = true,
        event = 'VeryLazy',
        opts = {
        },
        config = function()
            vim.api.nvim_set_hl(0, 'TreesitterContext', { bg = '#444444' })
            vim.api.nvim_set_hl(0, 'TreesitterContextLineNumber', { bg = '#444444' })
        end,
    },
    {
        'folke/trouble.nvim',
        opts = {
        },
    },
    {
        "luukvbaal/statuscol.nvim",
        config = function()
            local builtin = require("statuscol.builtin")
            require("statuscol").setup({
                -- configuration goes here, for example:
                relculright = true,
                foldfunc = "builtin",
                segments = {
                    {
                        text = { builtin.foldfunc },
                        click = "v:lua.ScFa"
                    },
                    {
                        sign = {
                            name = { "diagnostic.*" },
                            maxwidth = 2,
                            auto = true
                        },
                        click = "v:lua.ScSa"
                    },
                    {
                        text = { "%s" },
                        click = "v:lua.ScSa"
                    },
                    {
                        text = { builtin.lnumfunc },
                        click = "v:lua.ScLa",
                    },
                    {
                        sign = { name = { ".*" }, maxwidth = 2, auto = true, wrap = true },
                        click = "v:lua.ScSa"
                    },
                    {
                        text = { " " },
                    },
                }
            })
        end,
    },
}
