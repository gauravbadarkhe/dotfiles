return {
  "sindrets/diffview.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  config = function()
    local diffview = require("diffview")

    diffview.setup({
      use_icons = true, -- Set to false if you don't have a Nerd Font
    })

    -- Keymaps for Diffview
    local map = vim.keymap.set
    local opts = { noremap = true, silent = true }

    map("n", "<leader>do", "<cmd>DiffviewOpen<CR>", opts) -- Open Diffview
    map("n", "<leader>dc", "<cmd>DiffviewClose<CR>", opts) -- Close Diffview
    map("n", "<leader>dh", "<cmd>DiffviewFileHistory %<CR>", opts) -- File History
    map("n", "<leader>dl", "<cmd>DiffviewLog<CR>", opts) -- Git log
    map("n", "<leader>df", "<cmd>DiffviewFileHistory<CR>", opts) -- Full repo history
  end,
}
