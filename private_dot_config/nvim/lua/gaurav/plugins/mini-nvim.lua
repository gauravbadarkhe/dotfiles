return {
  "echasnovski/mini.cursorword",
  "echasnovski/mini.indentscope",
  "echasnovski/mini.ai",
  config = function()
    require("mini.cursorword").setup()
    require("mini.indentscope").setup()
    require("mini.ai").setup()
  end,
}
