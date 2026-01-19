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
      "actionlint", "angularls", "ansiblels", "ansible-lint", "apex-language-server",
      "asm_lsp", "asmfmt", "awk_ls", "bashls", "bqls", "buf_ls", "checkmake",
      "cmakelang", "cmakelint", "cobol_ls", "cpptools", "csharp_ls", "csharpier",
      "cssls", "css_variables", "cssmodules_ls", "cucumber_language_server",
      "delve", "denols", "docker_compose_language_service", "docker_language_server",
      "fish_lsp", "gci", "gh", "gh_actions_ls", "gitleaks", "gitlint",
      "go-debug-adapter", "gofumpt", "goimports", "goimports-reviser",
      "golangci-lint", "golangci_lint_ls", "golines", "gomodifytags", "gopls",
      "gospel", "gotests", "gotestsum", "gradle_ls", "groovyls", "helm_ls", "html",
      "htmlbeautifier", "htmlhint", "iferr", "impl", "jq", "jqls", "jsonls",
      "kube-linter", "kubescape", "lua_ls", "luacheck", "luaformatter", "lwc_ls",
      "markdown_oxide", "markdown-toc", "markdownlint", "marksman", "mutt_ls", "mypy",
      "ocamllsp", "ocamlformat", "postgres_lsp", "powershell_es", "prettier",
      "prettierd", "pylsp", "reason_ls", "rstcheck", "rubocop", "ruby_lsp", "rubyfmt",
      "ruff", "rust_analyzer", "shfmt", "sonarlint-language-server", "sql-formatter",
      "sqlfluff", "sqlfmt", "sqlls", "sqls", "svelte", "swiftformat", "swiftlint",
      "tailwindcss", "tflint", "tfsec", "tofu_ls", "tree-sitter-cli", "ts_ls",
      "usort", "uv", "vimls", "vue_ls", "yamlls", "yamlfix", "yamlfmt", "yamllint",
      "yq", "zls"
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
