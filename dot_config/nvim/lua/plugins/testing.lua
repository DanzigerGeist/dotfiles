-- Neotest core plugin
local neotest = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-neotest/neotest-vim-test",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "markemmons/neotest-deno",
    {
      "fredrikaverpil/neotest-golang",
      dependencies = { "leoluz/nvim-dap-go" },
    },
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("neotest").setup({
      adapters = {
        require("neotest-deno"),
        require("neotest-golang")({
          go_test_args = {
            "-v",
            "-race",
            "-coverprofile=" .. vim.fn.getcwd() .. "/cover.cov",
          },
        }),
      },
    })
  end,
}

local neotest_debug = {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      event = "VeryLazy",
      dependencies = {
        "nvim-neotest/nvim-nio",
        "mfussenegger/nvim-dap",
      },
      opts = {},
      config = function(_, opts)
        local dap = require("dap")
        local dapui = require("dapui")
        dapui.setup(opts)
        dap.listeners.after.event_initialized["dapui_config"] = function()
          dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
          dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
          dapui.close({})
        end
      end,
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
    {
      "andythigpen/nvim-coverage",
      version = "*",
      config = function()
        require("coverage").setup({
          auto_reload = true,
        })
      end,
    },
  }
}

return { neotest, neotest_debug }
