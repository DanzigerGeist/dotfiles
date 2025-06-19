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
      "bashls",                -- Bash
      "buf_ls",                -- Protobuf
      "denols",                -- Deno
      "fish_lsp",              -- Fish shell
      "gh_actions_ls",         -- GitHub Actions
      "gopls",                 -- Go
      "helm_ls",               -- Helm
      "jsonls",                -- JSON
      "lua_ls",                -- Lua
      "marksman",              -- Markdown
      "nginx_language_server", -- Nginx
      "sqls",                  -- SQL
      "terraformls",           -- Terraform
      "tflint",                -- Terraform (lint)
      "vimls",                 -- Vimscript
      "yamlls",                -- YAML
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
