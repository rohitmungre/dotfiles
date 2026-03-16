-- ─────────────────────────────────────────────
-- Editor Plugins
-- ─────────────────────────────────────────────

return {
    -- Telescope (fuzzy finder)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
            "nvim-telescope/telescope-ui-select.nvim",
        },
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = { preview_width = 0.55 },
                    width = 0.87,
                    height = 0.80,
                },
                file_ignore_patterns = {
                    "node_modules", ".git/", "dist/", "build/",
                    "__pycache__", "*.pyc", ".venv",
                },
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",
                        ["<C-q>"] = "send_selected_to_qflist",
                    },
                },
            },
        },
    },

    -- Harpoon (quick file navigation)
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon add" },
            { "<leader>hh", function()
                local harpoon = require("harpoon")
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end, desc = "Harpoon menu" },
            { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon 1" },
            { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon 2" },
            { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon 3" },
            { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon 4" },
        },
        opts = {},
    },

    -- Oil.nvim (file manager as a buffer)
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "-", "<cmd>Oil<CR>", desc = "Open parent directory" },
        },
        opts = {
            view_options = {
                show_hidden = true,
            },
            keymaps = {
                ["q"] = "actions.close",
                ["<C-h>"] = false,  -- Don't conflict with window nav
            },
        },
    },

    -- Undotree
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Undo tree" },
        },
    },

    -- Flash (navigation/search)
    {
        "folke/flash.nvim",
        opts = {
            modes = {
                search = { enabled = false },  -- Don't hijack /
                char = { jump_labels = true },
            },
        },
    },

    -- Trouble (better diagnostics list)
    {
        "folke/trouble.nvim",
        opts = {},
    },

    -- tmux navigator
    {
        "christoomey/vim-tmux-navigator",
        event = "VeryLazy",
    },

    -- Git integration
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 500,
            },
        },
    },
}
