return {
  "akinsho/bufferline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  config = function(_, _)
    local bufferline = require('bufferline')
    bufferline.setup {
      options = {
        mode = "buffers",
        separator_style = "slope",
        diagnostics = "nvim_lsp",
      },
    }
  end,
}
