return {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'folke/trouble.nvim',
    'nvim-tree/nvim-web-devicons'
  },
  opts = function(_, options)
    local trouble = require("trouble")
    local symbols = trouble.statusline({
      mode = "lsp_document_symbols",
      groups = {},
      title = false,
      filter = { range = true },
      format = "{kind_icon}{symbol.name:Normal}",
      hl_group = "lualine_c_normal",
    })
  end,
}
