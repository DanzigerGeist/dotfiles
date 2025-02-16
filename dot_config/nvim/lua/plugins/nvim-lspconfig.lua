return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      "williamboman/mason.nvim",
      cmd = "Mason",
      build = ":MasonUpdate"
    },
    {
      "williamboman/mason-lspconfig.nvim",
      config = function(_, _) end,
    },
  },
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT"
            },
            diagnostics = {
              globals = {
                "vim"
              }
            },
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              },
            }
          }
        },
      }
    }
  },
  config = function(_, opts)
    require("mason").setup()
    local mason_lspconfig = require("mason-lspconfig")
    local lsp_config = require("lspconfig")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )
    local on_attach = function(client, bufnr)
      require("lsp-format").on_attach(client, bufnr)
    end
    mason_lspconfig.setup({
      ensure_installed = {
        "lua_ls",
        "terraformls",
        "pyright",
      },
      automatic_installation = true
    })
    mason_lspconfig.setup_handlers({
      function(server_name)
        lsp_config[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = opts.servers[server_name] and opts.servers[server_name].settings or {},
        })
      end,
    })
    local configs = require 'lspconfig.configs'
    if not configs.tmux then
      configs.tmux = {
        default_config = {
          cmd = { 'tmux-language-server' },
          filetypes = { 'tmux' },
          root_markers = { 'tmux.conf' },
          root_dir = lsp_config.util.root_pattern("tmux.conf")
        }
      }
    end
    lsp_config.tmux.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = opts.servers.tmux and opts.servers.tmux.settings or {},
    })
  end,
}
