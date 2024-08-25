return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons"
  },
  opts = {
    defaults = {
      ["<leader>b"] = { name = "Browse Files / Buffers / Etc." },
      ["<leader>f"] = { name = "Find Files / Strings" },
      ["<leader>i"] = { name = "Interactive Tools" },
      ["<leader>l"] = { name = "LSP Functions" },
      ["<leader>lg"] = { name = "Go To Code..." },
      ["<leader>s"] = { name = "Split" },
      ["<leader>t"] = { name = "Tabs" },
      ["<leader>bg"] = { name = "Git..." },

    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
