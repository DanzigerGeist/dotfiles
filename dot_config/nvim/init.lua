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

-----------------------------------------------------------
-- Theme settings
-----------------------------------------------------------
vim.cmd [[colorscheme terafox]]

-----------------------------------------------------------
-- Keymappings
-----------------------------------------------------------
keymap.set("n", "<S-Up>", "10k")   -- Shift+Up jumps 10 lines up
keymap.set("n", "<S-Down>", "10j") -- Shift+Down jumps 10 lines down
keymap.set("n", "x", '"_x')        -- delete single character without copying into register

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
    vim.opt_local.conceallevel = 0
  end,
})

-- Make sure that Terraform files are recognized as `terraform`.
vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})
