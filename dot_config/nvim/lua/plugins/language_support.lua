local markdown_preview = {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  opts = {},
  init = function()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
}

local python_venv_selector = {
  'linux-cultist/venv-selector.nvim',
  lazy = false,
  branch = "regexp",
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-telescope/telescope.nvim',
    'mfussenegger/nvim-dap-python'
  },
  opts = {
    name = { "venv", ".venv" }
  }
}

local lspsaga = {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  opts = {
    lightbulb = {
      enable = true,
      sign = false,
      virtual_text = true
    }
  },
}

local gitsigns = {
  "lewis6991/gitsigns.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    current_line_blame = true
  }
}

return { markdown_preview, python_venv_selector, lspsaga, gitsigns }
