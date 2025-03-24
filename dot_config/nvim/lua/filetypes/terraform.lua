local autocmd = vim.api.nvim_create_autocmd

-- Make sure that Terraform files are recognized as `terraform`.
vim.filetype.add({
  extension = {
    tf = "terraform"
  }
})

-- Make vim understand that Terraform files use `#` for comments.
autocmd("FileType", {
  pattern = "terraform",
  callback = function()
    vim.bo.commentstring = "# %s"
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.tabstop = 2
  end
})
