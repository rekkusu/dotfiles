
vim.g.mapleader = ' '
vim.g.python3_host_prog = '/usr/bin/python3'

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

    -- colorscheme
    {
        'bluz71/vim-moonfly-colors',
        priority = 1000,
        config = function()
            vim.cmd('colorscheme moonfly')
            vim.cmd('highlight! link CmpItemAbbr MoonflyWhite')
        end,
    },

    -- UI
    {
        'nvim-lualine/lualine.nvim',
        opts = {
            options = {
                theme = 'auto',
                icons_enabled = false,
                component_separators = '',
                section_separators = '',
            },
        },
    },

    {
        'Shougo/denite.nvim',
        lazy = true,
        event = 'VeryLazy',
        config = function()
            vim.cmd([[
            nnoremap <silent> <Leader>b :Denite buffer<CR>
            nnoremap <silent> <Leader>a :Denite -auto-resize buffer file/rec<CR>

            augroup denite_filter
            function! s:denite_settings() abort
            nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action', 'switch')
            nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
            nnoremap <silent><buffer><expr> dd denite#do_map('do_action', 'delete')
            nnoremap <silent><buffer><expr> q denite#do_map('quit')
            nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
            nnoremap <silent><buffer><expr> I denite#do_map('do_action', 'splitswitch')
            nnoremap <silent><buffer><expr> s denite#do_map('do_action', 'vsplitswitch')
            endfunction

            function! s:denite_filter_settings() abort
            call deoplete#custom#buffer_option('auto_complete', v:false)
            endfunction

            autocmd FileType denite call s:denite_settings()
            autocmd FileType denite-filter call s:denite_filter_settings()
            augroup END


            call denite#custom#option('_', {
            \ 'split': 'floating',
            \ 'prompt': '>',
            \ 'start-filter': v:true
            \ })

            call denite#custom#var('menu', 'menus', {
            \})
            ]])
        end,
    },
    {
        'Shougo/defx.nvim',
        dependencies = {
            'kristijanhusak/defx-git',
        },
        config = function()
            vim.cmd([[
            nnoremap <silent> <Leader>f  :Defx<CR>

            call defx#custom#option('_', {
            \ 'root_marker': ':',
            \ 'columns': 'mark:indent:icon:filename:git',
            \ 'show_ignored_files': 1,
            \ 'split': 'floating',
            \ 'resume': v:true,
            \ 'wincol': 0,
            \ 'winrow': 0,
            \ 'winwidth': 60,
            \ 'direction': 'topleft'
            \ })

            call defx#custom#column('filename', {
            \ 'min_width': 30,
            \ 'max_width': 30,
            \ 'root_marker_highlight': 'Ignore',
            \ })

            function! s:open_defx_if_noargs()
            if argc() == 0
            Defx
            endif
            endfunction

            function! s:defx_settings() abort
            nnoremap <silent><buffer><expr> <CR> defx#is_directory() ? defx#do_action('open_or_close_tree') : defx#do_action('multi', ['drop', 'quit'])
            nnoremap <silent><buffer><expr> u defx#do_action('cd', ['..'])
            nnoremap <silent><buffer><expr> n defx#do_action('new_file')
            nnoremap <silent><buffer><expr> dd defx#do_action('remove')
            nnoremap <silent><buffer><expr> yy defx#do_action('copy')
            nnoremap <silent><buffer><expr> p defx#do_action('paste')
            nnoremap <silent><buffer><expr> r defx#do_action('rename')
            nnoremap <silent><buffer><expr> R defx#do_action('redraw')
            nnoremap <silent><buffer><expr> m defx#do_action('move')
            nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
            nnoremap <silent><buffer><expr> i defx#do_action('multi', [['open', 'split'], 'quit'])
            nnoremap <silent><buffer><expr> s defx#do_action('multi', [['open', 'vsplit'], 'quit'])
            nnoremap <silent><buffer><expr> I defx#do_action('toggle_ignored_files')
            nnoremap <silent><buffer><expr> n defx#do_action('new_file')
            nnoremap <silent><buffer><expr> q defx#do_action('quit')
            endfunction

            augroup Defx
            autocmd!
            autocmd VimEnter * call s:open_defx_if_noargs()
            autocmd FileType defx call s:defx_settings()
            augroup END
            ]])
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
                indent = { enable = true },
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
            vim.cmd('highlight! TreesitterContext guibg=#444444')
            vim.cmd('highlight! TreesitterContextLineNumber guibg=#444444')
        end,
    },

    -- Language Server Manager
    {
        'williamboman/mason.nvim',
        lazy = true,
        cmd = {
            'Mason',
            'MasonDebug',
            'MasonInstall',
            'MasonUninstall',
            'MasonUninstallAll',
            'MasonLog',
        },
        opts = {},
        dependencies = {
            {
                'williamboman/mason-lspconfig.nvim',
                config = function()
                    require('mason-lspconfig').setup_handlers({ function(server)
                        local opt = {
                            on_attach = function(client, bufnr)
                                local opts = { noremap = true, silent = true }
                                vim.keymap.set('n', '<Leader>r', '<cmd>lua vim.lso.buf.rename()<CR>', opts)
                                vim.keymap.set('n', '<Leader>D', '<cmd>lua vim.lso.buf.declaration()<CR>', opts)
                                vim.keymap.set('n', '<Leader>d', '<cmd>lua vim.lso.buf.definition()<CR>', opts)

                                vim.cmd('autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 1000)')
                            end,
                            capabilities = require('cmp_nvim_lsp').default_capabilities(
                                vim.lsp.protocol.make_client_capabilities()
                            )
                        }
                        require('lspconfig')[server].setup(opt)
                    end })
                end,
            },
        }
    },
    'neovim/nvim-lspconfig',

    -- LSP nvim-cmp
    {
        'hrsh7th/nvim-cmp',
        event = "InsertEnter",
        config = function()
            local cmp = require('cmp')
            cmp.setup({
                snippet = {
                    expand = function(args)
                        vim.fn["vsnip#anonymous"](args.body)
                    end,
                },
                mapping = {
                    ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
                    ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
                    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item()),
                    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item()),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                },
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
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
            'hrsh7th/vim-vsnip',
            {
                'jose-elias-alvarez/null-ls.nvim',
                config = function()
                    local null_ls = require('null-ls')
                    null_ls.setup({
                        sources = {
                            null_ls.builtins.diagnostics.textlint.with({ filetypes = { 'markdown' }}),
                        },
                    })
                end,
            }
        },
    }
})


vim.opt.cursorline = true
vim.opt.number = true
vim.opt.showmatch = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.laststatus = 2
vim.opt.backupdir=vim.fn.stdpath('cache') .. '/backup'
vim.opt.swapfile = false
vim.opt.undodir = vim.fn.stdpath('cache') .. '/undo'
vim.opt.undofile = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ambiwidth = 'single'
vim.opt.hidden = true
vim.opt.list = true
vim.opt.listchars='tab:>-,trail:-'
vim.opt.foldmethod = 'marker'
vim.opt.foldcolumn = '2'
vim.opt.title = true
vim.opt.cmdheight = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.history = 500
vim.opt.visualbell = true
vim.opt.mouse = 'a'
vim.opt.showmatch = true
vim.opt.matchtime=1
vim.opt.scrollback=1000
vim.opt.termguicolors = true
vim.opt.pumblend = 20
vim.optwinblend = 20

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
