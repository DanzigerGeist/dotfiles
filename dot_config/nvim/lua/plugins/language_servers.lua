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
        "xml", "yaml", "jsdoc"
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
      "sqls", "terraformls", "tflint", "vimls", "yamlls", "ts_ls"
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

return { treesitter, mason, lspsaga, lazydev, trouble }
