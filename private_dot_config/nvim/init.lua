local start_time = vim.loop.hrtime() -- Record the start time

require("gaurav.core")
require("gaurav.lazy")

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`

-- Remove the existing <Space>f mapping in normal mode
vim.api.nvim_del_keymap("n", "<Space>f")

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_augroup("SubstituteHighlight", { clear = true })

-- Highlight search matches when using substitute
vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = "SubstituteHighlight",
  pattern = { "/", "?", ":s" },
  callback = function()
    vim.opt.hlsearch = true
  end,
})

-- Disable search highlight after leaving substitute or search
vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = "SubstituteHighlight",
  pattern = { "/", "?", ":s" },
  callback = function()
    vim.opt.hlsearch = false
  end,
})

vim.api.nvim_create_autocmd("InsertEnter", {
  desc = "Change cursor shape in insert mode",
  callback = function()
    vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
  end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
  desc = "Change cursor shape back to block in normal mode",
  callback = function()
    vim.opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50"
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  desc = "Disable auto-commenting on new lines",
  callback = function()
    vim.opt.formatoptions:remove("o")
  end,
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
  pattern = "/,?",
  desc = "Highlight search results temporarily",
  callback = function()
    vim.opt.hlsearch = true
  end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  pattern = "/,?",
  desc = "Disable search highlight after searching",
  callback = function()
    vim.opt.hlsearch = false
  end,
})

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.ejs",
  command = "set filetype=html",
})

local ts_builtin = require("telescope.builtin")

vim.api.nvim_set_keymap("n", "<leader>sf", "", {
  noremap = true,
  callback = function()
    ts_builtin.treesitter({
      symbols = { "function" },
    })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  once = true, -- Ensure it only runs once
  callback = function()
    local end_time = vim.loop.hrtime() -- Record the end time
    local elapsed_ms = (end_time - start_time) / 1e6 -- Convert from nanoseconds to milliseconds
    local message = string.format("🚀 Neovim fully loaded in %.2f ms ⚡", elapsed_ms)

    -- Show the message in the command line
    vim.api.nvim_echo({ { message, "None" } }, false, {})

    -- Clear the message after 3 seconds
    vim.defer_fn(function()
      vim.api.nvim_command("echo ''")
    end, 3000) -- 3000 ms = 3 seconds
  end,
})

vim.diagnostic.config({
  float = {
    focusable = true, -- Allows focusing and scrolling the floating window
    border = "rounded", -- Rounded borders for better visibility
    source = "if_many", -- Show the source of diagnostics
    scope = "cursor", -- Show diagnostics for the current cursor
  },
})
