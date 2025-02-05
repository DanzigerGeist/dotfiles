return {
  'hrsh7th/nvim-cmp',
  dependencies = {
    'zbirenbaum/copilot.lua',
    'zbirenbaum/copilot-cmp',
    'tzachar/cmp-ai',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-vsnip',
    'hrsh7th/cmp-omni',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'saadparwaiz1/cmp_luasnip',
    'vrslev/cmp-pypi',
    'onsails/lspkind.nvim',
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'Snikimonkd/cmp-go-pkgs'
  },
  -- TODO: this needs restructuring to be more modular
  config = function()
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    local copilot = require('copilot')
    local copilot_cmp = require('copilot_cmp')

    copilot.setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    copilot_cmp.setup()

    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      formatting = {
        format = lspkind.cmp_format({
          symbol_map = {
            Copilot = ""
          },
          menu = {
            copilot = '[Copilot]',
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            nvim_lua = '[Lua]',
            cmp_ai = '[AI]',
            path = '[Path]',
            go_pkgs = "[Go Pkg]",
          },
          mode = 'symbol_text',     -- show symbol and text annotations
          maxwidth = 50,            -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
          ellipsis_char = '...',    -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
          show_labelDetails = true, -- show labelDetails in menu. Disabled by default
          before = function(_, vim_item)
            return vim_item
          end
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
      sources = cmp.config.sources({
        { name = "copilot" },
        { name = 'vsnip' },
        { name = 'omni' },
        { name = 'nvim_lsp_signature_help' },
        { name = "pypi",                   keyword_length = 4 },
        { name = "go_pkgs" },
        -- { name = 'cmp_ai' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
      }),
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
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })

    -- TODO: cmp_ai is working but it's too slow

    -- local cmp_ai = require('cmp_ai.config')
    -- cmp_ai:setup({
    --   max_lines = 100,
    --   provider = 'Ollama',
    --   provider_options = {
    --     model = 'codellama:7b-code',
    --   },
    --   notify = false,
    --   notify_callback = function(msg)
    --     vim.notify(msg)
    --   end,
    --   run_on_every_keystroke = true,
    --   ignored_file_types = {
    --     -- default is not to ignore
    --     -- uncomment to ignore in lua:
    --     -- lua = true
    --   },
    -- })
  end,
}
