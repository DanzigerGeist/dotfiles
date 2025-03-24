local codecompanion = {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

local copilot_setup = function()
  require('copilot').setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
  })
end

local copilot_cmp_setup = function()
  require('copilot_cmp').setup()
end

local cmp_setup = function()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = {
      { name = "copilot" },
      { name = 'vsnip' },
      { name = 'omni' },
      { name = 'nvim_lsp_signature_help' },
      { name = "pypi" },
      { name = "go_pkgs" },
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
      { name = 'path' },
      per_filetype = {
        codecompanion = { "codecompanion" },
      }
    },
    formatting = {
      format = lspkind.cmp_format({
        preset = 'codicons',
        symbol_map = {
          Copilot = "",
        },
        menu = {
          copilot = '[Copilot]',
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          nvim_lua = '[Lua]',
          path = '[Path]',
          go_pkgs = "[Go Pkg]",
        },
        mode = 'symbol_text',     -- show symbol and text annotations
        maxwidth = 50,            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
        ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
        show_labelDetails = true, -- show labelDetails in menu. Disabled by default
      })
    },
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }),
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' },
    }, {
      { name = 'buffer' },
    })
  })

  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  cmp.setup.cmdline(':', {
    sources = {
      { name = 'cmdline' }
    }
  })
end

local nvim_cmp = {
  'hrsh7th/nvim-cmp',
  dependencies = {
    { 'zbirenbaum/copilot.lua',             config = copilot_setup },
    { 'zbirenbaum/copilot-cmp',             config = copilot_cmp_setup },
    { 'hrsh7th/vim-vsnip' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/cmp-omni' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'vrslev/cmp-pypi' },
    { 'onsails/lspkind.nvim' },
    { 'L3MON4D3/LuaSnip' },
    { 'rafamadriz/friendly-snippets' },
    { 'Snikimonkd/cmp-go-pkgs' },
    { 'petertriho/cmp-git' },
    { 'olimorris/codecompanion.nvim' }
  },
  config = cmp_setup
}

return { nvim_cmp, codecompanion }
