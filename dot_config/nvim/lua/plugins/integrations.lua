local toggleterm = {
  'akinsho/toggleterm.nvim',
  version = "*",
  config = function()
    require('toggleterm').setup {
      direction = 'float',
    }

    local Terminal   = require('toggleterm.terminal').Terminal
    local lazysql    = Terminal:new({ cmd = "lazysql", hidden = true, direction = "float", name = "LazySQL" })
    local jirust     = Terminal:new({ cmd = "jirust", hidden = true, direction = "float", name = "Jira" })
    local atac       = Terminal:new({ cmd = "atac", hidden = true, direction = "float", name = "ATAC" })
    local lazydocker = Terminal:new({ cmd = "lazydocker", hidden = true, direction = "float", name = "lazyDocker" })

    function CustomToggleLazySQL() lazysql:toggle() end

    function CustomToggleLazyDocker() lazydocker:toggle() end

    function CustomToggleJira() jirust:toggle() end

    function CustomToggleAtac() atac:toggle() end
  end
}

local wakatime = { 'wakatime/vim-wakatime', lazy = false }

local copilotChat = {
  "CopilotC-Nvim/CopilotChat.nvim",
  dependencies = {
    { "zbirenbaum/copilot.lua" },
    { "nvim-lua/plenary.nvim", branch = "master" }
  },
  build = "make tiktoken",
  opts = {}
}

return { toggleterm, wakatime, copilotChat }
