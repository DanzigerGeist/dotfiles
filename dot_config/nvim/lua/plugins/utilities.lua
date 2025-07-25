local snacks = {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    dim = { enabled = true },
    explorer = { enabled = true, replace_netrw = true },
    image = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = {
      enabled = true,
      sources = {
        explorer = {
          -- auto_close = true,
          -- focus = "input"
        }
      }
    },
    notifier = { enabled = true, style = 'fancy' },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
  },
  config = function(_, opts)
    local snacks = require("snacks")
    snacks.setup(opts)
    snacks.rename.on_rename_file = function(from, to, _)
      vim.lsp.util.rename(from, to, {
        overwrite = false,
        ignoreIfExists = false,
      })
    end
  end,
}

local todo_comments = {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {}
}

local ts_comments = {
  "folke/ts-comments.nvim",
  opts = {},
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10.0") == 1,
}

local mini_diff = {
  "echasnovski/mini.diff",
  version = false,
  config = function()
    local diff = require("mini.diff")
    diff.setup({
      source = diff.gen_source.none(),
    })
  end,
}

local img_clip = {
  "HakonHarnes/img-clip.nvim",
  opts = {
    filetypes = {
      codecompanion = {
        prompt_for_file_name = false,
        template = "[Image]($FILE_PATH)",
        use_absolute_path = true,
      },
    },
  },
}

local overseer = {
  "stevearc/overseer.nvim",
  opts = {
    templates = { "builtin" },
  },
}

local makefiles = {
  "burgr033/mf-runner.nvim",
  cmd = { "MFROpen", "MFRRun", "MFREdit" },
  dependencies = {
    "folke/snacks.nvim",
  },
  opts = {},
}

return { snacks, todo_comments, ts_comments, mini_diff, img_clip, overseer, makefiles }
