local lualine = {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local theme = function()
      local colors = {
        darkgray = "#16161d",
        gray = "#727169",
        outerbg = "#16161D",
        normal = "#7aa2f7",  -- Tokyonight blue
        insert = "#9ece6a",  -- Tokyonight green
        visual = "#bb9af7",  -- Tokyonight purple
        replace = "#f7768e", -- Tokyonight red
        command = "#e0af68", -- Tokyonight yellow
      }
      return {
        inactive = {
          a = { fg = colors.gray, bg = colors.outerbg, gui = "bold" },
          b = { fg = colors.gray, bg = colors.outerbg },
          c = { fg = colors.gray, bg = "none" },
        },
        visual = {
          a = { fg = colors.darkgray, bg = colors.visual, gui = "bold" },
          b = { fg = colors.gray, bg = colors.outerbg },
          c = { fg = colors.gray, bg = "none" },
        },
        replace = {
          a = { fg = colors.darkgray, bg = colors.replace, gui = "bold" },
          b = { fg = colors.gray, bg = colors.outerbg },
          c = { fg = colors.gray, bg = "none" },
        },
        normal = {
          a = { fg = colors.darkgray, bg = colors.normal, gui = "bold" },
          b = { fg = colors.gray, bg = colors.outerbg },
          c = { fg = colors.gray, bg = "none" },
        },
        insert = {
          a = { fg = colors.darkgray, bg = colors.insert, gui = "bold" },
          b = { fg = colors.gray, bg = colors.outerbg },
          c = { fg = colors.gray, bg = "none" },
        },
        command = {
          a = { fg = colors.darkgray, bg = colors.command, gui = "bold" },
          b = { fg = colors.gray, bg = colors.outerbg },
          c = { fg = colors.gray, bg = "none" },
        },
      }
    end
    require('lualine').setup({
      options = {
        theme = theme(),
        icons_enabled = true,
        section_separators = { left = "", right = "" },
      },
      extensions = { 'trouble', 'quickfix' },
    })
  end
}

local noice = {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true
      },
    },
    popupmenu = {
      backend = "cmp"
    },
    presets = {
      command_palette = true,
      long_message_to_split = true,
      lsp_doc_border = false,
    },
  },
  init = function()
    vim.opt.lazyredraw = false
  end
}

local tokyonight = {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true,
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    }
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd('colorscheme tokyonight')
    -- vim.api.nvim_set_hl(0, "CursorLine", { underline = true, bg = "none" })
    -- vim.api.nvim_set_hl(0, "PmenuSel", { underline = true, bg = "none", fg = "none" })
  end
}

local bufferline = {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  -- config = function()
  --   local bufferline = require('bufferline')
  --   bufferline.setup {
  --     options = {
  --       diagnostics = 'nvim_lsp',
  --       diagnostics_indicator = function(_, _, diagnostics_dict, _)
  --         local s = " "
  --         for e, n in pairs(diagnostics_dict) do
  --           local sym = e == "error" and " "
  --               or (e == "warning" and " " or " ")
  --           s = s .. n .. sym
  --         end
  --         return s
  --       end,
  --       mode = 'buffers',
  --     },
  --   }
  -- end
}

return { lualine, noice, bufferline, tokyonight }
