return {
    {
        'NeogitOrg/neogit',
        opts = {},
    },
    {
        'lewis6991/gitsigns.nvim',
        opts = {
            numhl = true,
        },
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
    },
    {
        'MeanderingProgrammer/markdown.nvim',
        event = 'BufRead',
        name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        config = function()
            require('render-markdown').setup({})
        end,
    },
}
