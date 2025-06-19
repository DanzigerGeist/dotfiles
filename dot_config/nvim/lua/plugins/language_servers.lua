local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      auto_install = true,
      ensure_installed = {
        "bash", "c", "comment", "cpp", "css", "csv", "diff", "dockerfile",
        "dot", "fish", "git_config", "git_rebase", "gitattributes", "gitcommit",
        "gitignore", "go", "gomod", "gosum", "gotmpl", "gowork", "html", "http",
        "hcl", "helm", "java", "javascript", "jq", "json", "json5", "kotlin",
        "lua", "luadoc", "make", "markdown", "markdown_inline", "mermaid", "muttrc",
        "nginx", "nix", "perl", "pem", "php", "powershell", "proto", "properties",
        "python", "regex", "ruby", "rust", "scala", "sql", "ssh_config", "swift",
        "tcl", "terraform", "toml", "tmux", "typescript", "vim", "vimdoc", "vue",
        "xml", "yaml"
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
  opts = {
    ensure_installed = {
      "bashls", "buf_ls", "denols", "fish_lsp", "gh_actions_ls", "gopls",
      "helm_ls", "jsonls", "lua_ls", "marksman", "nginx_language_server",
      "sqls", "terraformls", "tflint", "vimls", "yamlls"
    },
    setup_handlers = {
      function(server_name)
        require("lspconfig")[server_name].setup({})
      end,
      ["lua_ls"] = function()
        require("lspconfig").lua_ls.setup({
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              diagnostics = {
                globals = { "vim", "global" },
              },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = { enable = false },
            },
          },
        })
      end
    }
  }
}

local lspsaga = {
  'nvimdev/lspsaga.nvim',
  event = 'LspAttach',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    lightbulb = {
      sign = false,
    }
  },
}

return { treesitter, mason, lspsaga }
