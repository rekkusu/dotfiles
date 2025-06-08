return {
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
}
