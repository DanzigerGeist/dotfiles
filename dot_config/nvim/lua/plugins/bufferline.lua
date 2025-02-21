return {
  'akinsho/bufferline.nvim',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function(_, _)
    local bufferline = require('bufferline')
    bufferline.setup {
      options = {
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local s = " "
          for e, n in pairs(diagnostics_dict) do
            local sym = e == "error" and " "
                or (e == "warning" and " " or " ")
            s = s .. n .. sym
          end
          return s
        end,
        mode = 'buffers',
        separator_style = 'thin',
        style_preset = bufferline.style_preset.no_italic,
      },
    }
  end
}
