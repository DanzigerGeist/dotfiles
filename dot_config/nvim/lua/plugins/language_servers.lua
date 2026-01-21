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
      "bashls",
      "buf_ls",
      "cucumber_language_server",
      "denols",
      "docker_compose_language_service",
      "docker_language_server",
      "fish_lsp",
      "gh_actions_ls",
      "golangci_lint_ls",
      "gopls",
      "helm_ls",
      "html",
      "jqls",
      "jsonls",
      "lua_ls",
      "ocamllsp",
      "postgres_lsp",
      "pylsp",
      "rubocop",
      "ruby_lsp",
      "rust_analyzer",
      "sqlls",
      "sqls",
      "tflint",
      "tofu_ls",
      "ts_ls",
      "vimls",
      "yamlls",
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
