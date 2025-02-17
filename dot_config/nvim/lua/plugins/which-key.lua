return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons"
  },
  opts = {
    defaults = {}
  },
  config = function(_, _)
    local wk = require("which-key")
    wk.add({
      -- Buffers
      { "<leader>b",    group = "Buffers" },
      { "<leader>bl",       "<cmd>ls<CR>",                                                   desc = "List Opened Buffers" },
      { "<leader>bn",       "<cmd>enew<CR>",                                                 desc = "New Buffer" },
      { "<leader>bq",       "<cmd>bd<CR>",                                                   desc = "Close Buffer" },
      { "<leader>b<Left>",  "<cmd>bp<CR>",                                                   desc = "Previous Buffer" },
      { "<leader>b<Right>", "<cmd>bn<CR>",                                                   desc = "Next Buffer" },

      -- Code
      { "<leader>c",    group = "Code" },
      { "<leader>ca",   "<cmd>lua vim.lsp.buf.code_action()<CR>",                        desc = "Code Actions" },
      { "<leader>cD",   "<cmd>vsplit | lua vim.lsp.buf.declaration()<CR>",               desc = "Declaration" },
      { "<leader>cR",   "<cmd>vsplit | lua vim.lsp.buf.references()<CR>",                desc = "References" },
      { "<leader>cd",   "<cmd>vsplit | lua vim.lsp.buf.definition()<CR>",                desc = "Definition" },
      { "<leader>cf",   "<cmd>lua vim.lsp.buf.format()<CR>",                             desc = "Format" },
      { "<leader>ci",   "<cmd>lua vim.lsp.buf.hover()<CR>",                              desc = "Info" },
      { "<leader>cl",   "<cmd>Mason<CR>",                                                desc = "LSP Manager" },
      { "<leader>cq",   "<cmd>Telescope quickfix<CR>",                                   desc = "Quickfix" },
      { "<leader>cr",   "<cmd>lua vim.lsp.buf.rename()<CR>",                             desc = "Rename" },
      { "<leader>ct",   "<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>",           desc = "Type Definition" },
      { "<leader>cT",   "<cmd>vsplit | lua vim.lsp.buf.type_declaration()<CR>",          desc = "Type Declaration" },
      { "<leader>cw",   "<cmd>Telescope diagnostics<CR>",                                desc = "Warnings" },
      { "<leader>co",   "<cmd>Telescope lsp_document_symbols<CR>",                       desc = "Symbols (File)" },
      { "<leader>cO",   "<cmd>Telescope lsp_workspace_symbols<CR>",                      desc = "Symbols (Workspace)" },
      { "<leader>cn",   "<cmd>TodoTelescope<cr>",                                        desc = "Notes" },

      -- Directory
      { "<leader>d",    group = "Directories" },
      { "<leader>dc",   "<cmd>Telescope file_browser<CR>",                               desc = "Current" },
      { "<leader>db",   "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Buffer" },
      { "<leader>dh",   "<cmd>Telescope file_browser path=~<CR>",                        desc = "Home" },
      { "<leader>dR",   "<cmd>Telescope file_browser path=~/Developer<CR>",              desc = "Repositories" },

      -- Git
      { "<leader>g",    group = "Git" },
      { "<leader>gi",   "<cmd>LazyGit<CR>",                                              desc = "Interactive" },
      -- TODO: Add git commands

      -- Integrations
      { "<leader>i",    group = "Integrations" },
      { "<leader>id",   "<cmd>Lazydocker<CR>",                                           desc = "Docker" },
      { "<leader>ig",   "<cmd>LazyGit<CR>",                                              desc = "Git" },
      -- TODO: Add lazysql integration

      -- Search
      { "<leader>s",    group = "Search" },
      { "<leader>sb",   "<cmd>Telescope buffers show_all_buffers=true<CR>",              desc = "Buffers" },
      { "<leader>sf",   group = "Files" },
      { "<leader>sfR",  "<cmd>Telescope oldfiles<CR>",                                   desc = "Files (Recent)" },
      { "<leader>sfp",  "<cmd>Telescope find_files<cr>",                                 desc = "Files (Project)" },
      { "<leader>sfg",  "<cmd>Telescope find_files cwd=/<cr>",                           desc = "Files (Global)" },
      { "<leader>sfr",  "<cmd>Telescope find_files cwd=~/Developer<cr>",                 desc = "Files (Repositories)" },
      { "<leader>sfh",  "<cmd>Telescope find_files cwd=~<cr>",                           desc = "Files (Home)" },
      { "<leader>sg",   group = "Git" },
      { "<leader>sgb",  "<cmd>Telescope git_branches<cr>",                               desc = "Branches" },
      { "<leader>sgc",  "<cmd>Telescope git_commits<CR>",                                desc = "Commits (Project)" },
      { "<leader>sgC",  "<cmd>Telescope git_bcommits<CR>",                               desc = "Commits (File)" },
      { "<leader>sgS",  "<cmd>Telescope git_stash<cr>",                                  desc = "Stashes" },
      { "<leader>sgf",  "<cmd>Telescope git_files<CR>",                                  desc = "Tracked Files" },
      { "<leader>sgs",  "<cmd>Telescope git_status<CR>",                                 desc = "Uncommited Changes" },
      -- NOTE: There is also a Telescope function to search for text under cursor
      { "<leader>st",   group = "Text" },
      { "<leader>stp",  "<cmd>Telescope live_grep<cr>",                                  desc = "Text (Project)" },
      { "<leader>stg",  "<cmd>Telescope live_grep cwd=/<cr>",                            desc = "Text (Global)" },
      { "<leader>str",  "<cmd>Telescope live_grep cwd=~/Developer<cr>",                  desc = "Text (Repositories)" },
      { "<leader>sth",  "<cmd>Telescope live_grep cwd=~<cr>",                            desc = "Text (Home)" },
      { "<leader>sv",   group = "Vim" },
      { "<leader>svc",  "<cmd>Telescope commands<CR>",                                   desc = "Commands" },
      { "<leader>svk",  "<cmd>Telescope keymaps<cr>",                                    desc = "Keymaps" },
      { "<leader>svh",  "<cmd>Telescope help_tags<CR>",                                  desc = "Help Tags" },
      { "<leader>sd",   group = "Documentation" },
      { "<leader>sdm",  "<cmd>Telescope man_pages<CR>",                                  desc = "Manual Pages" },
      -- TODO: look for Dash integration

      -- Tabs
      { "<C-t>",        group = "Tabs" },
      { "<C-t>l",       "<cmd>tabs<CR>",                                                 desc = "List Opened Tabs" },
      { "<C-t>N",       "<cmd>tabnew<CR>",                                               desc = "New Tab" },
      { "<C-t>o",       "<cmd>tabnew %<CR>",                                             desc = "Open Current Buffer in New Tab" },
      { "<C-t>q",       "<cmd>tabclose<CR>",                                             desc = "Close Tab" },
      { "<C-t><Left>",  "<cmd>tabp<CR>",                                                 desc = "Previous Tab" },
      { "<C-t><Right>", "<cmd>tabn<CR>",                                                 desc = "Next Tab" },

      -- Vim
      { "<leader>v",    group = "Vim" },
      { "<leader>vc",   group = "Configuration" },
      { "<leader>vce",  "<cmd>e $MYVIMRC<CR>",                                           desc = "Edit" },
      { "<leader>vcr",  "<cmd>source $MYVIMRC<CR>",                                      desc = "Reload" },
      { "<leader>vk",   group = "Keymaps" },
      { "<leader>vke",  "<cmd>e ~/.config/nvim/lua/plugins/which-key.lua<CR>",           desc = "Edit" },
      { "<leader>vkr",  "<cmd>Lazy reload which-key.nvim<CR>",                           desc = "Reload" },
      { "<leader>vp",   "<cmd>Lazy<CR>",                                                 desc = "Plugins" },
      { "<leader>vn",   "<cmd>Telescope notify<CR>",                                     desc = "Notifications" },
      { "<leader>vt",   "<cmd>Telescope colorscheme<CR>",                                desc = "Theme" },
    })
  end,
}
