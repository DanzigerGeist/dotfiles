return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-ui-select.nvim',
    'nvim-telescope/telescope-file-browser.nvim'
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
  end
}
