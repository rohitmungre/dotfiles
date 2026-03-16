-- ─────────────────────────────────────────────
-- Neovim Options
-- ─────────────────────────────────────────────

local opt = vim.opt

-- ── General ──────────────────────────────────
opt.clipboard = "unnamedplus"       -- System clipboard
opt.mouse = "a"                     -- Mouse support
opt.undofile = true                 -- Persistent undo
opt.undolevels = 10000
opt.updatetime = 200                -- Faster completion
opt.timeoutlen = 300                -- Faster key sequences
opt.confirm = true                  -- Confirm unsaved changes
opt.autowrite = true                -- Auto-save before commands

-- ── UI ───────────────────────────────────────
opt.number = true                   -- Line numbers
opt.relativenumber = true           -- Relative line numbers
opt.signcolumn = "yes"              -- Always show sign column
opt.cursorline = true               -- Highlight current line
opt.termguicolors = true            -- True colors
opt.showmode = false                -- Don't show mode (statusline handles it)
opt.laststatus = 3                  -- Global statusline
opt.pumblend = 10                   -- Popup transparency
opt.pumheight = 12                  -- Popup max height
opt.scrolloff = 8                   -- Lines above/below cursor
opt.sidescrolloff = 8               -- Columns left/right of cursor
opt.splitbelow = true               -- Horizontal splits below
opt.splitright = true               -- Vertical splits right
opt.splitkeep = "screen"            -- Keep screen position on split
opt.wrap = false                    -- No line wrapping
opt.linebreak = true                -- Break at word boundaries (when wrap is on)
opt.fillchars = { eob = " ", fold = " ", foldopen = "", foldsep = " ", foldclose = "" }

-- ── Search ───────────────────────────────────
opt.ignorecase = true               -- Case-insensitive search
opt.smartcase = true                -- ...unless uppercase used
opt.hlsearch = true                 -- Highlight matches
opt.incsearch = true                -- Incremental search
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"       -- Use ripgrep for :grep

-- ── Indentation ──────────────────────────────
opt.expandtab = true                -- Spaces over tabs
opt.tabstop = 4                     -- Tab width
opt.shiftwidth = 4                  -- Indent width
opt.softtabstop = 4
opt.smartindent = true              -- Smart auto-indent
opt.shiftround = true               -- Round indent to shiftwidth

-- ── Folding (Treesitter) ─────────────────────
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- ── Completion ───────────────────────────────
opt.completeopt = "menu,menuone,noselect"
opt.wildmode = "longest:full,full"

-- ── Formatting ───────────────────────────────
opt.formatoptions = "jcroqlnt"

-- ── Sessions ─────────────────────────────────
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }

-- ── Filetype-specific ────────────────────────
vim.g.markdown_recommended_style = 0

-- ── Leader ───────────────────────────────────
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
