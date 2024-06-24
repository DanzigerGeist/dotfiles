return { "mgierada/lazydocker.nvim",
    event = "VeryLazy",
    dependencies = {
        "akinsho/toggleterm.nvim"
    },
    opts = {},
    config = function()
        require("lazydocker").setup{}
        vim.keymap.set("n", "<leader>ld", "<cmd>Lazydocker<CR>", { desc = "Toggle LazyDocker" })
    end,
}
