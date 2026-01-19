local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  lazy = false,
  event = "BufRead",
  branch = "main",
  build = ":TSUpdate",
}

local treesitter_query_loader = {
  "Corn207/ts-query-loader.nvim",
  version = "*",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    ensure_installed = { "all" }
  },
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
      "actionlint", "angular-language-server", "ansible-language-server", "ansible-lint",
      "apex-language-server", "asm-lsp", "asmfmt", "awk-language-server",
      "bash-language-server", "bqls", "buf", "checkmake", "cmakelang", "cmakelint",
      "cobol-language-support", "cpptools", "csharp-language-server", "csharpier",
      "css-lsp", "css-variables-language-server", "cssmodules-language-server",
      "cucumber-language-server", "delve", "deno", "docker-compose-language-service",
      "docker-language-server", "fish-lsp", "gci", "gh", "gh-actions-language-server",
      "gitleaks", "gitlint", "go-debug-adapter", "gofumpt", "goimports",
      "goimports-reviser", "golangci-lint", "golangci-lint-langserver", "golines",
      "gomodifytags", "gopls", "gospel", "gotests", "gotestsum",
      "gradle-language-server", "groovy-language-server", "helm-ls", "html-lsp",
      "htmlbeautifier", "htmlhint", "iferr", "impl", "jq", "jq-lsp", "json-lsp",
      "kube-linter", "kubescape", "lua-language-server", "luacheck", "luaformatter",
      "lwc-language-server", "markdown-oxide", "markdown-toc", "markdownlint",
      "marksman", "mutt-language-server", "mypy", "ocaml-lsp", "ocamlformat",
      "postgres-language-server", "powershell-editor-services", "prettier", "prettierd",
      "python-lsp-server", "reason-language-server", "rstcheck", "rubocop", "ruby-lsp",
      "rubyfmt", "ruff", "rust-analyzer", "shfmt", "sonarlint-language-server",
      "sql-formatter", "sqlfluff", "sqlfmt", "sqlls", "sqls",
      "svelte-language-server", "swiftformat", "swiftlint", "tailwindcss-language-server",
      "tflint", "tfsec", "tofu-ls", "tree-sitter-cli", "typescript-language-server",
      "usort", "uv", "vim-language-server", "vue-language-server", "yaml-language-server",
      "yamlfix", "yamlfmt", "yamllint", "yq", "zls",
      "bashls", "buf_ls", "denols", "fish_lsp", "gh_actions_ls", "helm_ls", "jsonls",
      "lua_ls", "tofu_ls", "vimls", "yamlls", "ts_ls"
    },
  },
  config = function(_, opts)
    local mason_lspconfig = require("mason-lspconfig")
    mason_lspconfig.setup(opts)

    local util = require("lspconfig.util")

    vim.lsp.config("denols", {
      root_markers = { "deno.json" },
      workspace_required = true,
    })

    vim.lsp.config("ts_ls", {
      root_markers = { "package.json" },
      workspace_required = true,
    })
  end,
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

local lazydev = {
  "folke/lazydev.nvim",
  ft = "lua",
  opts = {
    enabled = true,
  }
}

local trouble = {
  "folke/trouble.nvim",
  cmd = "Trouble",
  opts = {}
}

return { treesitter, treesitter_query_loader, mason, lspsaga, lazydev, trouble }
