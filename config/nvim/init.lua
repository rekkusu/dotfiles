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
    { import = 'plugins' }
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
vim.opt.laststatus = 3
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

vim.diagnostic.config({
    virtual_text  = true,
    virtual_lines = { current_line = true },
})

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


vim.api.nvim_set_hl(0, 'NormalNC', { bg = '#181818' })
vim.api.nvim_create_augroup('ActiveWindow', {})
vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter' }, {
    group = 'ActiveWindow',
    pattern = '*',
    callback = function()
        vim.opt_local.cursorline = true
    end,
})
vim.api.nvim_create_autocmd('WinLeave', {
    group = 'ActiveWindow',
    pattern = '*',
    callback = function()
        vim.opt_local.cursorline = false
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = false })
        end
    end,
})
local signs = { Error = " ", Warn = " ", Hint = "󱩎 ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl })
end
