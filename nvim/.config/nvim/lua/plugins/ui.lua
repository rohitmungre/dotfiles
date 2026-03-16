-- ─────────────────────────────────────────────
-- UI Plugins
-- ─────────────────────────────────────────────

return {
    -- Catppuccin colorscheme
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        opts = {
            flavour = "mocha",
            transparent_background = true,
            integrations = {
                cmp = true,
                gitsigns = true,
                mason = true,
                mini = true,
                native_lsp = {
                    enabled = true,
                    underlines = {
                        errors = { "undercurl" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                },
                neo_tree = true,
                noice = true,
                notify = true,
                telescope = { enabled = true },
                treesitter = true,
                which_key = true,
            },
        },
    },

    -- Noice (better command line, messages, popups)
    {
        "folke/noice.nvim",
        opts = {
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
            },
        },
    },

    -- Dashboard
    {
        "nvimdev/dashboard-nvim",
        opts = function(_, opts)
            local logo = [[
                     ██╗      ██╗
                     ██║      ██║
                     ██║      ██║
                     ██║      ██║
                     ╚██████╗ ██║
                      ╚═════╝ ╚═╝
            ]]
            opts.config.header = vim.split(logo, "\n")
        end,
    },

    -- Indent guides
    {
        "lukas-reineke/indent-blankline.nvim",
        opts = {
            indent = { char = "│", tab_char = "│" },
            scope = { show_start = false, show_end = false },
        },
    },

    -- Smooth scrolling
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        opts = {
            mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>" },
            hide_cursor = true,
            respect_scrolloff = true,
        },
    },

    -- TODO comments highlighting
    {
        "folke/todo-comments.nvim",
        opts = {},
    },
}
