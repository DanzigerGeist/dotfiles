local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
  pattern = {
    "typescript",
  },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.tabstop = 2
  end,
})
