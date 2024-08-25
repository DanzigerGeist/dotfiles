
local global = vim.g      -- Global variables
local opt = vim.opt       -- Set options (global/buffer/windows-scoped)
local keymap = vim.keymap -- Set Keymaps
global.mapleader = " "    -- set leader key to space

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                               -- Enable mouse support
opt.clipboard = 'unnamedplus'                 -- Copy/paste to system clipboard
opt.swapfile = false                          -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect' -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true         -- Show line number
opt.relativenumber = true -- Show relative line numbers
opt.showmatch = true      -- Highlight matching parenthesis
opt.foldmethod = 'marker' -- Enable folding (default 'foldmarker')
opt.splitright = true     -- Vertical split to the right
opt.splitbelow = true     -- Horizontal split to the bottom
opt.linebreak = true      -- Wrap on word boundary
opt.termguicolors = true  -- Enable 24-bit RGB colors
opt.laststatus = 3        -- Set global statusline
opt.background = "dark"   -- Colorschemes will be made dark (if supported)
opt.cursorline = true     -- highlight cursor line underneath the cursor
opt.lazyredraw = false

-----------------------------------------------------------
--- Search
-----------------------------------------------------------
opt.ignorecase = true -- Ignore case letters when search
opt.smartcase = true  -- Ignore lowercase for the whole pattern
opt.incsearch = true  -- Search as characters are entered
opt.hlsearch = true   -- Highlight matches

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.shiftwidth = 4                 -- Shift 4 spaces when tab
opt.tabstop = 4                    -- 1 tab == 4 spaces
opt.smartindent = true             -- Autoindent new lines
opt.expandtab = true               -- Use spaces instead of tabs
opt.backspace = "indent,eol,start" -- allow backspace on indent

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true     -- Enable background buffers
opt.history = 100     -- Remember N lines in history
opt.lazyredraw = true -- Faster scrolling
opt.synmaxcol = 240   -- Max column for syntax highlight
opt.updatetime = 250  -- ms to wait for trigger an event

-----------------------------------------------------------
-- Install plugins
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
opt.rtp:prepend(lazypath)
require('lazy').setup('plugins', {
  change_detection = {
    notify = false
  }
})
-- Disable lazyredraw
opt.lazyredraw = false

-----------------------------------------------------------
-- Theme settings
-----------------------------------------------------------
vim.cmd [[colorscheme tokyonight]]

-----------------------------------------------------------
-- Keymappings
-----------------------------------------------------------
keymap.set("n", "<S-Up>", "10k")   -- Shift+Up jumps 10 lines up
keymap.set("n", "<S-Down>", "10j") -- Shift+Down jumps 10 lines down
keymap.set("n", "x", '"_x')        -- delete single character without copying into register

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })     -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })   -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })      -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Interactive Tools
keymap.set("n", "<leader>il", "<cmd>Mason<CR>", { desc = "LSP Manager" })
keymap.set("n", "<leader>ip", "<cmd>Lazy<CR>", { desc = "Plugin Manager" })
keymap.set("n", "<leader>ig", "<cmd>LazyGit<CR>", { desc = "Git" })
keymap.set("n", "<leader>id", "<cmd>Lazydocker<CR>", { desc = "Docker" })

-- Browsers (Telescope)
keymap.set("n", "<leader>bf", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Files" })
keymap.set("n", "<leader>bt", "<cmd>Telescope buffers show_all_buffers=true<CR>", { desc = "Tabs" })
keymap.set("n", "<leader>bh", "<cmd>Telescope man_pages<CR>", { desc = "Manual Pages" })
keymap.set("n", "<leader>bh", "<cmd>Telescope help_tags<CR>", { desc = "Help Tags" })
keymap.set("n", "<leader>bc", "<cmd>Telescope commands<CR>", { desc = "Commands" })
keymap.set("n", "<leader>bw", "<cmd>Telescope diagnostics<CR>", { desc = "Diagnostics" })
keymap.set("n", "<leader>bq", "<cmd>Telescope quickfix<CR>", { desc = "Quickfix" })
keymap.set("n", "<leader>bn", "<cmd>TodoTelescope<cr>", { desc = "Notes / Todos" })
keymap.set("n", "<leader>bgb", "<cmd>Telescope git_branches<cr>", { desc = "Branches" })
keymap.set("n", "<leader>bgc", "<cmd>Telescope git_commits<cr>", { desc = "Commits" })
keymap.set("n", "<leader>bgs", "<cmd>Telescope git_stash<cr>", { desc = "Stash" })

-- Finders
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files (CWD)" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string (CWD)" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor (CWD)" })

-- LSP Functions
keymap.set("n", "<leader>ld", "<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>", { desc = "Type Definition" })
keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<CR>", { desc = "Format Code" })
keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Show Info" })
keymap.set("n", "<leader>lgD", "<cmd>vsplit | lua vim.lsp.buf.declaration()<CR>", { desc = "Declaration" })
keymap.set("n", "<leader>lgd", "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>", { desc = "Definition" })
keymap.set("n", "<leader>lgi", "<cmd>vsplit | lua vim.lsp.buf.implementation()<CR>", { desc = "Implementation" })
keymap.set("n", "<leader>lgr", "<cmd>vsplit | lua vim.lsp.buf.references()<CR>", { desc = "References" })

-----------------------------------------------------------
-- Language-specific settings
-----------------------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- Some of the languages are better with 2 spaces instead of default 4.
autocmd("FileType", {
  pattern = {
    "vim",
    "html",
    "css",
    "json",
    "javascript",
    "javascriptreact",
    "markdown.mdx",
    "terraform",
    "typescript",
    "typescriptreact",
    "lua",
    "sh",
    "zsh",
  },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.tabstop = 2
  end,
})

-- Tweaks for Markdown.
autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.conceallevel = 2
  end,
})

