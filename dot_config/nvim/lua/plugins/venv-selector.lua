return {
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
