return {
  --   "github/copilot.vim",
  --   config = function()
  --     -- Disable default Tab mapping for CoPilot
  --     vim.g.copilot_no_tab_map = true
  --
  --     -- Set custom keybinding for accepting suggestions using vim.keymap.set
  --     vim.keymap.set("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
  --   end,
}
