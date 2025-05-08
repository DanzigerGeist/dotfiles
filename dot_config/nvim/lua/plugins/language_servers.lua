local treesitter = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = { "windwp/nvim-ts-autotag" },
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    auto_install = true,
    ensure_installed = {
      "bash", "c", "cmake", "comment", "cpp", "css", "csv", "diff", "dockerfile",
      "dot", "erlang", "git_config", "git_rebase", "gitattributes", "gitcommit",
      "gitignore", "go", "gomod", "gosum", "gotmpl", "gowork", "groovy", "hcl",
      "helm", "html", "http", "java", "javascript", "jq", "json", "json5", "kotlin",
      "lua", "luadoc", "make", "markdown", "markdown_inline", "mermaid", "muttrc",
      "nginx", "pem", "perl", "php", "powershell", "properties", "proto", "python", "regex",
      "ruby", "rust", "scala", "sql", "ssh_config", "swift", "tcl", "terraform",
      "toml", "typescript", "tmux", "vim", "vimdoc", "vue", "xml", "yaml"
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
    ensure_installed = { 'lua_ls' }
  }
}

return { treesitter, mason }
