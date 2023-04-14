local wezterm = require('wezterm')

return {
    font = wezterm.font_with_fallback({
        --{ family = 'Myrica M'},
        { family = 'Inconsolata' },
        { family = 'Source Han Sans', weight = 'Regular', scale = 0.85 },
        { family = 'Symbols Nerd Font Mono' },
    }),
    font_size = 13,
    default_prog = { "wsl.exe", "~" },
    hide_tab_bar_if_only_one_tab = true,
    scrollback_lines = 10000,
    colors = {
        foreground = '#ffffff',
        ansi = {
            '#000000',
            '#de3154',
            '#54de31',
            '#debb31',
            '#3154de',
            '#bb31de',
            '#31debb',
            '#ffffff',
        },
        brights = {
            '#262626',
            '#e8728a',
            '#8ae872',
            '#e8d172',
            '#728ae8',
            '#d172e8',
            '#72e8d1',
            '#ffffff',
        },
    },
}

