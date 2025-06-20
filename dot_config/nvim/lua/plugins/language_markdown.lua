local markdown_preview = {
  "toppair/peek.nvim",
  event = { "VeryLazy" },
  build = "deno task --quiet build:fast",
  opts = {},
  init = function()
    vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
    vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
  end,
}

local markview = {
  "OXY2DEV/markview.nvim",
  lazy = false,
  opts = {
    preview = {
      filetypes = { "markdown", "codecompanion", "copilot-chat" },
      ignore_buftypes = {},
    },
  },
}

-- NOTE: this guy causes some weird error on nvim startup
local sc_im = {
  "DAmesberger/sc-im.nvim",
  opts = {},
}

return { markdown_preview, markview }
