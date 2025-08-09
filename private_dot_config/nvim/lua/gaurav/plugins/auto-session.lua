return {
  "rmagatti/auto-session",
  config = function()
    require("auto-session").setup({
      log_level = "error",
      auto_session_enable_last_session = false,
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_session_enabled = true,
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Projects" },
    })

    local keymap = vim.keymap
    keymap.set("n", "<leader>wr", "<cmd>silent SessionRestore<CR>", { desc = "Restore session for cwd" }) -- restore last workspace session for current directory
    keymap.set("n", "<leader>ws", "<cmd>silent SessionSave<CR>", { desc = "Save session for auto session root dir" }) -- save workspace session for current working directory
    --   vim.cmd([[
    --     augroup AutoSessionSetup
    --       autocmd!
    --       autocmd VimEnter * silent! lua require('auto-session').AutoRestoreSession()
    --     augroup end
    --   ]])
  end,
}
