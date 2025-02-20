local nightfox_config = function()
  require('nightfox').setup({
    options = {
      transparent = true
    }
  })
end

return {
  { "bluz71/vim-nightfly-colors", name = "theme-nightfly",   lazy = false, priority = 1000 },
  { "EdenEast/nightfox.nvim",     name = "theme-nightfox",   lazy = false, priority = 1000, config = nightfox_config },
  { "folke/tokyonight.nvim",      name = "theme-tokyonight", lazy = false, priority = 1000 }
}
