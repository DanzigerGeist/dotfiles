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
    },
    highlight_overrides = {
      all = function(colors)
        return {
          CurSearch = { bg = colors.sky },
          IncSearch = { bg = colors.sky },
          CursorLineNr = { fg = colors.blue, style = { "bold" } },
          DashboardFooter = { fg = colors.overlay0 },
          TreesitterContextBottom = { style = {} },
          WinSeparator = { fg = colors.overlay0, style = { "bold" } },
          ["@markup.italic"] = { fg = colors.blue, style = { "italic" } },
          ["@markup.strong"] = { fg = colors.blue, style = { "bold" } },
          Headline = { style = { "bold" } },
          Headline1 = { fg = colors.blue, style = { "bold" } },
          Headline2 = { fg = colors.pink, style = { "bold" } },
          Headline3 = { fg = colors.lavender, style = { "bold" } },
          Headline4 = { fg = colors.green, style = { "bold" } },
          Headline5 = { fg = colors.peach, style = { "bold" } },
          Headline6 = { fg = colors.flamingo, style = { "bold" } },
          rainbow1 = { fg = colors.blue, style = { "bold" } },
          rainbow2 = { fg = colors.pink, style = { "bold" } },
          rainbow3 = { fg = colors.lavender, style = { "bold" } },
          rainbow4 = { fg = colors.green, style = { "bold" } },
          rainbow5 = { fg = colors.peach, style = { "bold" } },
          rainbow6 = { fg = colors.flamingo, style = { "bold" } },
        }
      end,
    },
    color_overrides = {
      macchiato = {
        rosewater = "#F5B8AB",
        flamingo = "#F29D9D",
        pink = "#AD6FF7",
        mauve = "#FF8F40",
        red = "#E66767",
        maroon = "#EB788B",
        peach = "#FAB770",
        yellow = "#FACA64",
        green = "#70CF67",
        teal = "#4CD4BD",
        sky = "#61BDFF",
        sapphire = "#4BA8FA",
        blue = "#00BFFF",
        lavender = "#00BBCC",
        text = "#C1C9E6",
        subtext1 = "#A3AAC2",
        subtext0 = "#8E94AB",
        overlay2 = "#7D8296",
        overlay1 = "#676B80",
        overlay0 = "#464957",
        surface2 = "#3A3D4A",
        surface1 = "#2F313D",
        surface0 = "#1D1E29",
        base = "#0b0b12",
        mantle = "#11111a",
        crust = "#191926",
      },
    },
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
