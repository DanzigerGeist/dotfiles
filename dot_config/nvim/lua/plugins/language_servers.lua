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
      -- 🧠 LSP Servers
      "bash-language-server",      -- bash, sh
      "deno",                      -- denols (js/ts)
      "gopls",                     -- Go LSP
      "helm-ls",                   -- Helm
      "json-lsp",                  -- JSON
      "lua-language-server",       -- Lua
      "marksman",                  -- Markdown
      "nginx-language-server",     -- Nginx
      "sonarlint-language-server", -- Multi-language (Java, JS, HTML, etc.)
      "terraform-ls",              -- Terraform LSP
      "vim-language-server",       -- Vimscript
      "yaml-language-server",      -- YAML

      -- ✏️ Formatters / Linters
      "actionlint",             -- GitHub Actions
      "checkmake",              -- Makefile linter
      "cmakelang",              -- CMake formatter
      "cmakelint",              -- CMake linter
      "golangci-lint",          -- Go linter
      "luacheck",               -- Lua linter
      "luaformatter",           -- Lua formatter
      "markdownlint",           -- Markdown linter
      "nginx-config-formatter", -- Nginx config formatter
      "sql-formatter",          -- SQL formatter
      "sqlfmt",                 -- SQL formatter
      "swiftlint",              -- Swift linter
      "tflint",                 -- Terraform linter
      "tfsec",                  -- Terraform security scanner
      "xmlformatter",           -- XML formatter
      "yamlfix",                -- YAML formatter/fixer
      "yamlfmt",                -- YAML formatter
      "yamllint",               -- YAML linter

      -- 🧩 Tools / DAP / Extras
      "fish-lsp",                   -- Fish shell language server
      "buf",                        -- Protobuf tool
      "gh",                         -- GitHub CLI integration
      "gh-actions-language-server", -- YAML Actions
      "go-debug-adapter",           -- Go debugger
      "gofumpt",                    -- Go formatter
      "goimports",                  -- Go imports formatter
      "goimports-reviser",          -- Go import cleaner
      "golines",                    -- Line-wrapping for Go
      "gomodifytags",               -- Struct tag generator for Go
      "gotests",                    -- Test generator for Go
      "gotestsum",                  -- Better Go test runner
      "jq",                         -- JSON CLI tool
      "js-debug-adapter",           -- JS/TS debugger
      "json-to-struct",             -- Go struct generator from JSON
      "kube-linter",                -- Kubernetes linter (YAML/Helm)
      "sqls",                       -- SQL Language Server
      "sqlls",                      -- SQL Language Server (alt)
      "yq",                         -- YAML CLI processor
    }
  }
}

return { treesitter, mason }
