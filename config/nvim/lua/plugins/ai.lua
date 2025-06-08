return {
    {
        'zbirenbaum/copilot.lua',
        event = 'BufRead',
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
        config = function()
            require("copilot_cmp").setup()
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        event = 'BufRead',
        branch = "main",
        build = "make tiktoken",
        config = function()
            local select = require("CopilotChat.select")
            require("CopilotChat").setup({
                prompts = {
                }
            })

            local keyopt = { silent = true, noremap = true }
            vim.keymap.set({ 'n', 'v' }, '<leader>cch', function()
                local actions = require("CopilotChat.actions")
                require("CopilotChat.integrations.telescope").pick(actions.help_actions())
            end, keyopt)
            vim.keymap.set({ 'n', 'v' }, '<leader>ccp', function()
                local actions = require("CopilotChat.actions")
                require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
            end, keyopt)
        end,
    },
    {
        "yetone/avante.nvim",
        event = "VeryLazy",
        opts = {
        },
        build = "make",
        dependencies = {
            "stevearc/dressing.nvim",
        },
    },
}
