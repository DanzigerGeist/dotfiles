local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = {
        "bash", "c", "cmake", "comment", "cpp", "css", "csv", "diff", "dockerfile",
        "dot", "erlang", "git_config", "git_rebase", "gitattributes", "gitcommit",
        "gitignore", "go", "gomod", "gosum", "gotmpl", "gowork", "groovy", "hcl",
        "helm", "html", "http", "java", "javascript", "jq", "json", "json5", "kotlin",
        "lua", "luadoc", "make", "markdown", "markdown_inline", "mermaid", "muttrc",
        "nginx", "pem", "perl", "php", "powershell", "properties", "python", "regex",
        "ruby", "rust", "scala", "sql", "ssh_config", "swift", "tcl", "terraform",
        "toml", "typescript", "tmux", "vim", "vimdoc", "vue", "xml", "yaml"
      },
      autotag = { enable = true },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}

local mason = {
  'williamboman/mason-lspconfig.nvim',
  dependencies = {
    { "williamboman/mason.nvim",       opts = {} },
    { 'lukas-reineke/lsp-format.nvim', opts = {} },
    { "neovim/nvim-lspconfig" },
    { 'hrsh7th/cmp-nvim-lsp' },
  },
  config = function(_, opts)
    local lspconfig = require('lspconfig')
    local mason = require('mason-lspconfig')
    local on_attach = function(client, bufnr)
      require("lsp-format").on_attach(client, bufnr)
    end
    local capabilities = vim.tbl_deep_extend(
      "force", {},
      vim.lsp.protocol.make_client_capabilities(),
      require("cmp_nvim_lsp").default_capabilities()
    )
    mason.setup({
      ensure_installed = { 'lua_ls', 'ts_ls', 'denols' },
      automatic_installation = true
    })
    mason.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = opts.servers[server_name] and opts.servers[server_name].settings or {}
        })
      end,
      ["ts_ls"] = function()
        local server_name = "ts_ls"
        lspconfig[server_name].setup({
          on_attach = on_attach,
          capabilities = capabilities,
          settings = opts.servers[server_name] and opts.servers[server_name].settings or {},
          root_dir = lspconfig.util.root_pattern("package.json")
        })
      end,
      ["denols"] = function()
        local server_name = "denols"
        lspconfig[server_name].setup({
          on_attach = function(client, bufnr)
            require("lsp-format").on_attach(client, bufnr)
            local active_clients = vim.lsp.get_active_clients()
            for _, active_client in pairs(active_clients) do
              if active_client.name == "ts_ls" then
                active_client.stop()
              end
            end
          end,
          capabilities = capabilities,
          settings = opts.servers[server_name] and opts.servers[server_name].settings or {},
          root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
        })
      end
    })
  end,
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
      },
    }
  }
}

return { treesitter, mason }
