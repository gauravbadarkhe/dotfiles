return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  opts = {},
  config = function()
    require("catppuccin").setup({
      -- flavour = "latte", -- Use the light version
      transparent_background = true, -- Enable transparency
    })

    vim.cmd.colorscheme("catppuccin")

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "VertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
  end,
}

-- return {
--   "rose-pine/neovim",
--   name = "rose-pine",
--   priority = 1000, -- Load early
--   config = function()
--     require("rose-pine").setup({
--       variant = "dawn", -- Use the light variant
--       disable_background = false, -- Keep background visible
--     })
--     vim.cmd.colorscheme("rose-pine")
--   end,
-- }
-- return {
--   {
--     "folke/tokyonight.nvim",
--     priority = 1000, -- make sure to load this before all the other start plugins
--     config = function()
--       -- local bg = "#011628"
--       -- local bg_dark = "#011423"
--       -- local bg_highlight = "#143652"
--       -- local bg_search = "#0A64AC"
--       -- local bg_visual = "#275378"
--       -- local fg = "#CBE0F0"
--       -- local fg_dark = "#B4D0E9"
--       -- local fg_gutter = "#627E97"
--       -- local border = "#547998"
--
--       -- require("tokyonight").setup({
--       --   style = "moon",
--       --   on_colors = function(colors)
--       --     --   colors.bg = bg
--       --     --   colors.bg_dark = bg_dark
--       --     --   colors.bg_float = bg_dark
--       --     --   colors.bg_highlight = bg_highlight
--       --     --   colors.bg_popup = bg_dark
--       --     --   colors.bg_search = bg_search
--       --     --   colors.bg_sidebar = bg_dark
--       --     --   colors.bg_statusline = bg_dark
--       --     --   colors.bg_visual = bg_visual
--       --     --   colors.border = border
--       --     --   colors.fg = fg
--       --     --   colors.fg_dark = fg_dark
--       --     --   colors.fg_float = fg
--       --     --   colors.fg_gutter = fg_gutter
--       --     --   colors.fg_sidebar = fg_dark
--       --   end,
--       -- })
--       -- load the colorscheme here
--       vim.cmd([[colorscheme tokyonight-storm]])
--     end,
--   },
-- }
