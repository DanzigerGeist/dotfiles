local g = vim.g       -- Global variables
local opt = vim.opt   -- Set options (global/buffer/windows-scoped)

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = 'a'                                -- Enable mouse support
opt.clipboard = 'unnamedplus'                  -- Copy/paste to system clipboard
opt.swapfile = false                           -- Don't use swapfile
opt.completeopt = 'menuone,noinsert,noselect'  -- Autocomplete options

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.number = true           -- Show line number
opt.relativenumber = true   -- Show relative line numbers
opt.showmatch = true        -- Highlight matching parenthesis
opt.foldmethod = 'marker'   -- Enable folding (default 'foldmarker')
opt.splitright = true       -- Vertical split to the right
opt.splitbelow = true       -- Horizontal split to the bottom
opt.linebreak = true        -- Wrap on word boundary
opt.termguicolors = true    -- Enable 24-bit RGB colors
opt.laststatus=3            -- Set global statusline
opt.background = "dark"     -- Colorschemes will be made dark
opt.cursorline = true       -- highlight cursor line underneath the cursor 
opt.lazyredraw = false 

-----------------------------------------------------------
--- Search
-----------------------------------------------------------
opt.ignorecase = true       -- Ignore case letters when search
opt.smartcase = true        -- Ignore lowercase for the whole pattern
opt.incsearch = true        -- Search as characters are entered
opt.hlsearch = true         -- Highlight matches

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.shiftwidth = 4          -- Shift 4 spaces when tab
opt.tabstop = 4             -- 1 tab == 4 spaces
opt.smartindent = true      -- Autoindent new lines
opt.expandtab = true        -- Use spaces instead of tabs
opt.backspace = "indent,eol,start" -- allow backspace on indent

-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true           -- Enable background buffers
opt.history = 100           -- Remember N lines in history
opt.lazyredraw = true       -- Faster scrolling
opt.synmaxcol = 240         -- Max column for syntax highlight
opt.updatetime = 250        -- ms to wait for trigger an event
