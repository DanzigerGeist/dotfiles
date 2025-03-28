local lualine = {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      -- theme = 'tokyonight',
      icons_enabled = true,
      section_separators = { left = "", right = "" },
    },
    extensions = { 'trouble', 'quickfix' }
  }
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

local catppuccin = {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {
    flavour = 'mocha',
    transparent_background = true,
    term_colors = true,
    integrations = {
      notify = true
    }
  },
  init = function()
    vim.cmd.colorscheme("catppuccin")
  end
}

local kanagawa = {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    transparent = true
  },
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
}

local bufferline = {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(_, _, diagnostics_dict, _)
        local s = " "
        for e, n in pairs(diagnostics_dict) do
          local sym = e == "error" and " "
              or (e == "warning" and " " or " ")
          s = s .. n .. sym
        end
        return s
      end,
      mode = 'buffers',
    }
  }
}

return { lualine, noice, bufferline, tokyonight, kanagawa, catppuccin }
