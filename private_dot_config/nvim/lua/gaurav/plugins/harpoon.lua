return {
  "theprimeagen/harpoon",
  config = function()
    -- Ensure harpoon is properly required
    local status_mark, mark = pcall(require, "harpoon.mark")
    local status_ui, ui = pcall(require, "harpoon.ui")

    if not status_mark or not status_ui then
      print("Error loading harpoon modules")
      return
    end

    -- Add key mappings
    vim.keymap.set("n", "<leader>a", mark.add_file, { noremap = true, silent = true })
    vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, { noremap = true, silent = true })
    vim.keymap.set("n", "<C-p>", function()
      ui.nav_prev()
    end)
    vim.keymap.set("n", "<C-n>", function()
      ui.nav_next()
    end)
  end,
}
