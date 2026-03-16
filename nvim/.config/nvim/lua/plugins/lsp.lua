-- ─────────────────────────────────────────────
-- LSP & Completion Plugins
-- ─────────────────────────────────────────────

return {
    -- Mason (LSP/formatter/linter installer)
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- LSP
                "lua-language-server",
                "pyright",
                "ruff",
                "typescript-language-server",
                "tailwindcss-language-server",
                "json-lsp",
                "yaml-language-server",
                "dockerfile-language-server",
                "terraform-ls",
                "gopls",
                "html-lsp",
                "css-lsp",

                -- Formatters
                "stylua",
                "prettier",
                "black",
                "isort",
                "shfmt",
                "gofumpt",
                "goimports",

                -- Linters
                "eslint_d",
                "shellcheck",
                "hadolint",
                "markdownlint",
            },
        },
    },

    -- LSP config overrides
    {
        "neovim/nvim-lspconfig",
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 4,
                    source = "if_many",
                    prefix = "●",
                },
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                },
            },
            inlay_hints = { enabled = true },
            servers = {
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "basic",
                                autoImportCompletions = true,
                            },
                        },
                    },
                },
                ruff = {},
                ts_ls = {
                    settings = {
                        typescript = {
                            inlayHints = {
                                includeInlayParameterNameHints = "all",
                                includeInlayFunctionParameterTypeHints = true,
                                includeInlayVariableTypeHints = true,
                            },
                        },
                    },
                },
                gopls = {
                    settings = {
                        gopls = {
                            analyses = {
                                unusedparams = true,
                                shadow = true,
                            },
                            staticcheck = true,
                            gofumpt = true,
                        },
                    },
                },
            },
        },
    },

    -- Formatting
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { "prettier" },
                typescript = { "prettier" },
                typescriptreact = { "prettier" },
                javascriptreact = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                html = { "prettier" },
                css = { "prettier" },
                go = { "goimports", "gofumpt" },
                sh = { "shfmt" },
                terraform = { "terraform_fmt" },
                ["_"] = { "trim_whitespace" },
            },
            format_on_save = {
                timeout_ms = 3000,
                lsp_fallback = true,
            },
        },
    },
}
