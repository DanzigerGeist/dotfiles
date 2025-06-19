local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    auto_install = true,
    ensure_installed = {
      -- 🧠 Programming Languages
      "bash", "c", "cpp", "go", "java", "javascript", "kotlin",
      "lua", "perl", "php", "python", "ruby", "rust", "scala", "swift", "typescript",

      -- 🌐 Markup / Data / Infra
      "css", "csv", "dockerfile", "dot", "hcl", "helm", "html", "http",
      "json", "json5", "make", "markdown", "markdown_inline", "mermaid", "nginx",
      "pem", "powershell", "proto", "properties", "sql", "terraform", "toml",
      "vimdoc", "xml", "yaml",

      -- 🛠️ Tooling / Editors / Git
      "comment", "diff", "fish", "git_config", "git_rebase", "gitattributes",
      "gitcommit", "gitignore", "gomod", "gosum", "gotmpl", "gowork", "jq",
      "luadoc", "muttrc", "regex", "ssh_config", "tcl", "tmux", "vim", "vue"
    },
    autotag = { enable = true },
    highlight = { enable = true },
    indent = { enable = true },
  }
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

return { treesitter, mason }
