local markdown_preview = {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  config = function()
    require("peek").setup()
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
  config = function()
    require('venv-selector').setup {
      name = { "venv", ".venv" },
    }
  end,
}

local lspsaga = {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons',     -- optional
  },
  config = function()
    require('lspsaga').setup({
      lightbulb = {
        sign = false,
      },
    })
  end,
}

local gitsigns = {
  "lewis6991/gitsigns.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("gitsigns").setup({
      current_line_blame = true
    })
  end
}

return { markdown_preview, python_venv_selector, gitsigns }
