local autocmd = vim.api.nvim_create_autocmd

vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})

autocmd("FileType", {
  pattern = "terraform",
  callback = function()
    vim.bo.commentstring = "# %s"
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.tabstop = 2
  end
})
