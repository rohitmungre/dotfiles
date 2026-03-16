-- ─────────────────────────────────────────────
-- Coding Plugins
-- ─────────────────────────────────────────────

return {
    -- Autopairs
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {
            check_ts = true,
        },
    },

    -- Surround
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        opts = {},
    },

    -- Comment toggling (LazyVim includes mini.comment, this extends it)
    {
        "JoosepAlvworkmaa/nvim-ts-context-commentstring",
        opts = {
            enable_autocmd = false,
        },
    },

    -- Better text objects
    {
        "echasnovski/mini.ai",
        opts = function(_, opts)
            -- Add custom text objects
            opts.custom_textobjects = opts.custom_textobjects or {}
        end,
    },

    -- Refactoring
    {
        "ThePrimeagen/refactoring.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            { "<leader>re", function() require("refactoring").refactor("Extract Function") end, mode = "v", desc = "Extract Function" },
            { "<leader>rv", function() require("refactoring").refactor("Extract Variable") end, mode = "v", desc = "Extract Variable" },
            { "<leader>ri", function() require("refactoring").refactor("Inline Variable") end, mode = { "n", "v" }, desc = "Inline Variable" },
        },
        opts = {},
    },

    -- Copilot
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        opts = {
            suggestion = {
                enabled = true,
                auto_trigger = true,
                keymap = {
                    accept = "<Tab>",
                    accept_word = "<C-Right>",
                    accept_line = "<C-End>",
                    next = "<M-]>",
                    prev = "<M-[>",
                    dismiss = "<C-]>",
                },
            },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                yaml = true,
                ["."] = false,
            },
        },
    },
}
