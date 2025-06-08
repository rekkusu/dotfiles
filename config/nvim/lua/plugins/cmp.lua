return {
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
                mapping = cmp.mapping.preset.insert({
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<Tab>'] = function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                }),
                sources = cmp.config.sources({
                    {
                        name = 'nvim_lsp',
                        priority = 1,
                    },
                    {
                        name = "copilot",
                        priority = 2,
                    },
                    {
                        name = 'buffer',
                        priority = 2,
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

                    --vim.keymap.set('i', '<Tab>', function()
                    --    if vim.fn['vsnip#jumpable'](1)  then
                    --        print('vsnip')
                    --        return '<Plug>(vsnip-jump-next)'
                    --    else
                    --        print('tab')
                    --        local key = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
                    --        vim.api.nvim_feedkeys(key, 'im', false)
                    --        return '<Tab>'
                    --    end
                    --end, keyopt)
                    --vim.keymap.set('i', '<S-Tab>', function()
                    --    if vim.fn['vsnip#jumpable'](-1) then
                    --        return '<Plug>(vsnip-jump-prev)'
                    --    else
                    --        return '<S-Tab>'
                    --    end
                    --end, keyopt)
                end,
            },
            'onsails/lspkind.nvim',
        },
    }
}
