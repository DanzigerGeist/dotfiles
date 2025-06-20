local ts_tools = {
  "pmizio/typescript-tools.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function(_, _)
    local lspconfig_util = require("lspconfig.util")
    local ts_tools = require("typescript-tools")
    ts_tools.setup({
      single_file_support = false,
      root_dir = function(fname)
        -- Ensure we dont load this plugin for Deno projects
        if lspconfig_util.root_pattern("deno.json", "deno.jsonc")(fname) then
          return nil
        end
        return lspconfig_util.root_pattern("package.json", "tsconfig.json")(fname)
      end,
    })
  end,
}

return { ts_tools }
