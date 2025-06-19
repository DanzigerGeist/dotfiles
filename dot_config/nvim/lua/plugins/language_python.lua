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

return { python_venv_selector }
