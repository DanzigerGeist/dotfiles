return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    { 'someone-stole-my-name/yaml-companion.nvim', dependencies = { 'neovim/nvim-lspconfig' } }
  },
  config = function()
    local telescope = require('telescope')
    telescope.setup {
      pickers = {
        colorscheme = {
          enable_preview = true
        }
      }
    }
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")
    telescope.load_extension("yaml_schema")
  end
}
