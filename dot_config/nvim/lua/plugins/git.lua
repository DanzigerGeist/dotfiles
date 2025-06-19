local gitsigns = {
  "lewis6991/gitsigns.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    current_line_blame = true,
    signs = {
      add          = { text = "+" },
      change       = { text = "~" },
      delete       = { text = "_" },
      topdelete    = { text = "‾" },
      changedelete = { text = "~" },
    }
  }
}

local diffview = {
  "sindrets/diffview.nvim",
}

return { gitsigns, diffview }
