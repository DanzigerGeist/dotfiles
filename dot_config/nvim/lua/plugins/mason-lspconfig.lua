return { 'williamboman/mason-lspconfig.nvim',
  dependencies = { 
        'williamboman/mason.nvim', 
        'neovim/nvim-lspconfig' 
    },
  config = function()
    require('mason-lspconfig').setup({
      ensure_installed = { 
        'lua_ls',
        'terraformls',
        'pyright'
      },
      automatic_installation = true,
    })
  end,
}
