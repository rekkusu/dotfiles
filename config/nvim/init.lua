vim.g.mapleader = ' '
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Luarocks path
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- library
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
    'MunifTanjim/nui.nvim',
    {
        's1n7ax/nvim-window-picker',
        opts = {
            autoselect_one = true,
            filter_rules = {
                bo = {
                    filetype = { 'neo-tree' },
                    buftype = { 'terminal', 'quickfix' },
                },
            },
        },
    },

    -- colorscheme
    {
        'bluz71/vim-moonfly-colors',
        priority = 1000,
        config = function()
            vim.cmd('colorscheme moonfly')
            vim.api.nvim_set_hl(0, 'CmpItemAbbr', { link = 'MoonflyWhite' })
        end,
    },

    -- UI
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
                    enable = 'all',
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

    -- Language Server Manager
    {
        'williamboman/mason.nvim',
        opts = {},
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            {
                'neovim/nvim-lspconfig',
                config = function()
                    local lspconfig = require('lspconfig')
                    lspconfig.metals.setup{}
                end,
            },
            {
                'williamboman/mason-lspconfig.nvim',
                config = function()
                    require('mason-lspconfig').setup_handlers({ function(server)
                        local opt = {
                            on_attach = function(client, bufnr)
                                if client.server_capabilities.documentFormattingProvider then
                                    vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
                                        buffer = bufnr,
                                        callback = function() vim.lsp.buf.format() end,
                                    })
                                end
                            end,
                            capabilities = require('cmp_nvim_lsp').default_capabilities(
                                vim.lsp.protocol.make_client_capabilities()
                            )
                        }
                        if server == 'lua-language-server' then
                            opt.settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = { 'vim' }
                                    },
                                }
                            }
                        end
                        require('lspconfig')[server].setup(opt)
                    end })
                end,
            },
        }
    },

    -- LSP tools
    {
        'hrsh7th/nvim-cmp',
        lazy = true,
        event = 'BufRead',
        config = function()
            local cmp = require('cmp')
            local lspkind = require('lspkind')
            cmp.setup({
                preselect = cmp.PreselectMode.None,
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',
                        maxwidth = 100,
                        ellipsis_char = '...',
                        symbol_map = {
                            Copilot = '',
                        },
                    }),
                },
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = cmp.mapping.select_next_item(),
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                },
                sources = cmp.config.sources({
                    {
                        name = 'nvim_lsp',
                        priority = 1,
                    },
                    {
                        name = "copilot",
                        priority = 1,
                    },
                    {
                        name = 'buffer',
                        option = {
                            keyword_length = 3,
                        },
                    },
                    { name = 'path' },
                    { name = 'vsnip' },
                }, {}),
                window = {
                    completion = {
                        border = 'single',
                    },
                    documentation = {
                        border = 'single',
                    },
                },
            })
        end,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-vsnip',
            {
                'hrsh7th/vim-vsnip',
                config = function()
                    local keyopt = { expr = true }
                    vim.keymap.set('i', '<Tab>', function()
                        if vim.fn['vsnip#jumpable'](1)  then
                            return '<Plug>(vsnip-jump-next)'
                        else
                            return '<Tab>'
                        end
                    end, keyopt)
                    vim.keymap.set('i', '<S-Tab>', function()
                        if vim.fn['vsnip#jumpable'](-1) then
                            return '<Plug>(vsnip-jump-prev)'
                        else
                            return '<S-Tab>'
                        end
                    end, keyopt)
                end,
            },
            'onsails/lspkind.nvim',
        },
    },
    {
        'nvimtools/none-ls.nvim',
        config = function()
            local null_ls = require('null-ls')
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.textlint.with({ filetypes = { 'markdown' } }),
                },
            })
        end,
    },
    {
        'glepnir/lspsaga.nvim',
        lazy = true,
        event = 'BufRead',
        config = function()
            local saga = require("lspsaga")
            saga.setup({
                code_action_lightbulb = { enable = false, },
                ui = {
                    border = 'rounded',
                },
            })

            local keyopt = { silent = true, noremap = true }
            vim.keymap.set('n', '<Leader>x', '<cmd>Lspsaga finder<CR>', keyopt)
            vim.keymap.set('n', '<Leader>r', '<cmd>Lspsaga rename<CR>', keyopt)
            vim.keymap.set({ 'n', 'v' }, '<Leader>c', '<cmd>Lspsaga code_action<CR>', keyopt)
            vim.keymap.set('n', '<Leader>d', '<cmd>Lspsaga peek_definition<CR>', keyopt)
            vim.keymap.set('n', '<Leader>D', '<cmd>Lspsaga goto_definition<CR>', keyopt)
            vim.keymap.set('n', '<Leader>h', '<cmd>Lspsaga hover_doc<CR>', keyopt)
            vim.keymap.set('n', '<Leader>o', '<cmd>Lspsaga outline<CR>', keyopt)
            vim.keymap.set("n", "<Leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", keyopt)
            vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", keyopt)
            vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", keyopt)

            vim.api.nvim_set_hl(0, 'SagaBorder', { link = 'NormalFloat' })
        end,
    },

    -- Tools for development
    {
        'TimUntersberger/neogit',
        opts = {},
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            numhl = true,
        },
    },
    {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        opts = {
            suggestion = {
                enabled = true,
                keymap = {
                    accept = "<C-Tab>",
                    next = "<C-Up>",
                    prev = "<C-Down>",
                }
            },
        },
    },
    {
        'zbirenbaum/copilot-cmp',
        event = 'InsertEnter',
        config = function ()
            require("copilot_cmp").setup()
        end,
    },
    {
        'mfussenegger/nvim-dap',
        event = 'BufRead',
        config = function()
            local keyopt = { silent = true, noremap = true }
            vim.keymap.set('n', '<F5>', function() require('dap').continue() end, keyopt)
            vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, keyopt)
            vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, keyopt)
            vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, keyopt)
            vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, keyopt)
            vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
        end,
    }
})


vim.opt.cursorline = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.laststatus = 2
vim.opt.backupdir = vim.fn.stdpath('cache') .. '/backup'
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('cache') .. '/undo'
vim.opt.swapfile = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ambiwidth = 'single'
vim.opt.hidden = true
vim.opt.list = true
vim.opt.listchars = 'tab:>-,trail:-'
vim.opt.foldmethod = 'marker'
vim.opt.foldcolumn = '2'
vim.opt.title = true
vim.opt.cmdheight = 0
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.history = 500
vim.opt.visualbell = true
vim.opt.mouse = 'a'
vim.opt.showmatch = true
vim.opt.matchtime = 1
vim.opt.scrollback = 1000
vim.opt.termguicolors = true
vim.opt.pumblend = 20
vim.opt.winblend = 20

vim.opt.formatoptions:append('mM')

vim.keymap.set('n', 'tn', ':<C-u>tabedit<CR>:<C-u>tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'td', ':<C-u>tabclose<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'th', ':<C-u>tabprev<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'tl', ':<C-u>tabnext<CR>', { noremap = true, silent = true })

vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })
vim.keymap.set('n', 'gj', 'j', { noremap = true })
vim.keymap.set('n', 'gk', 'k', { noremap = true })
vim.keymap.set('v', 'j', 'gj', { noremap = true })
vim.keymap.set('v', 'k', 'gk', { noremap = true })
vim.keymap.set('v', 'gj', 'j', { noremap = true })
vim.keymap.set('v', 'gk', 'k', { noremap = true })

vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'ss', ':sp<CR>:terminal<CR>', { noremap = true, silent = true })

vim.keymap.set('t', '<ESC>', '<C-\\><C-n><Plug>(send-esc-inner-term)', { noremap = true })
vim.keymap.set('n', '<Plug>(send-esc-inner-term)<ESC>', 'i<ESC>', { noremap = true })

vim.api.nvim_create_augroup('ChangeCursorLine', {})
vim.api.nvim_create_autocmd({ 'VimEnter', 'WinEnter', 'BufWinEnter' }, {
    group = 'ChangeCursorLine',
    pattern = '*',
    command = 'setlocal cursorline',
})
vim.api.nvim_create_autocmd('BufEnter', {
    group = 'ChangeCursorLine',
    pattern = '*',
    command = 'setlocal cursorline',
})
vim.api.nvim_create_autocmd('BufLeave', {
    group = 'ChangeCursorLine',
    pattern = '*',
    command = 'setlocal nocursorline',
})


