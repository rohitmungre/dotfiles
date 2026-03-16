-- ─────────────────────────────────────────────
-- Autocommands
-- ─────────────────────────────────────────────

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ── Highlight on yank ────────────────────────
autocmd("TextYankPost", {
    group = augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
    end,
})

-- ── Restore cursor position ──────────────────
autocmd("BufReadPost", {
    group = augroup("RestoreCursor", { clear = true }),
    callback = function(event)
        local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
        local lcount = vim.api.nvim_buf_line_count(event.buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- ── Auto-resize splits on window resize ──────
autocmd("VimResized", {
    group = augroup("ResizeSplits", { clear = true }),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd("tabdo wincmd =")
        vim.cmd("tabnext " .. current_tab)
    end,
})

-- ── Remove trailing whitespace on save ───────
autocmd("BufWritePre", {
    group = augroup("TrimWhitespace", { clear = true }),
    pattern = "*",
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- ── Close certain filetypes with <q> ─────────
autocmd("FileType", {
    group = augroup("CloseWithQ", { clear = true }),
    pattern = {
        "help", "lspinfo", "notify", "qf", "query",
        "startuptime", "checkhealth", "man",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
})

-- ── Filetype-specific settings ───────────────
autocmd("FileType", {
    group = augroup("IndentSettings", { clear = true }),
    pattern = { "lua", "javascript", "typescript", "typescriptreact", "json", "yaml", "html", "css", "jsx", "tsx" },
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
})

autocmd("FileType", {
    group = augroup("PythonSettings", { clear = true }),
    pattern = { "python" },
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
})

-- ── Spell check in text files ────────────────
autocmd("FileType", {
    group = augroup("SpellCheck", { clear = true }),
    pattern = { "markdown", "gitcommit", "text" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.wrap = true
    end,
})

-- ── Auto-create parent directories on save ───
autocmd("BufWritePre", {
    group = augroup("AutoCreateDir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then return end
        local file = vim.loop.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
