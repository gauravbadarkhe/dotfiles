return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- Load telescope and its extensions
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local builtin = require("telescope.builtin") -- Add this line to require builtin pickers

    local fb_actions = require("telescope").extensions.file_browser.actions

    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "🔍 ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
        file_ignore_patterns = { ".*~", "%.min.js", "%.min.css", "%.log", ".env", "dist/*" }, -- Ignore files with ~
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "━", "│", "━", "│", "┏", "┓", "┛", "┗" }, -- Proper border chars
        color_devicons = true,
        use_less = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- find_command = { "fd", "--type", "f", "--hidden", "--strip-cwd-prefix" }, -- Custom find_command using fd
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },

        file_browser = {
          hijack_netrw = true,
          hidden = true, -- Show hidden files in the file browser
          mappings = {
            ["i"] = {
              ["<C-h>"] = fb_actions.goto_parent_dir,
              ["<C-l>"] = fb_actions.change_cwd,
              ["<C-n>"] = fb_actions.create, -- create new file
              ["<C-e>"] = fb_actions.rename, -- rename file
            },
            ["n"] = {
              ["<C-h>"] = fb_actions.goto_parent_dir,
              ["<C-l>"] = fb_actions.change_cwd,
              ["<C-n>"] = fb_actions.create, -- create new file
              ["<C-e>"] = fb_actions.rename, -- rename file
            },
          },
        },
      },
      treesitter = {
        require("telescope.themes").get_dropdown({
          layout_config = { height = 15 }, -- Adjust as needed
        }),
      },
      mappings = {
        i = {
          ["<C-k>"] = actions.move_selection_previous, -- move to prev result
          ["<C-j>"] = actions.move_selection_next, -- move to next result
          ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-x>"] = actions.select_horizontal, -- open in horizontal split
          ["<C-v>"] = actions.select_vertical, -- open in vertical split
          ["<C-t>"] = actions.select_tab, -- open in new tab
          ["<C-n>"] = fb_actions.create, -- create new file
          ["<C-e>"] = fb_actions.rename, -- rename file
        },
        n = {
          ["<C-x>"] = actions.select_horizontal, -- open in horizontal split
          ["<C-v>"] = actions.select_vertical, -- open in vertical split
          ["<C-t>"] = actions.select_tab, -- open in new tab
          ["<C-n>"] = fb_actions.create, -- create new file
          ["<C-e>"] = fb_actions.rename, -- rename file
        },
      },
    })
    telescope.load_extension("file_browser")
    telescope.load_extension("fzf")
    -- telescope.load_extension("treesitter")
    -- Set keymaps for Telescope commands
    local keymap = vim.keymap -- for conciseness

    -- Key mappings for file browser
    keymap.set("n", "<leader>ee", "<cmd>Telescope file_browser<CR>", { desc = "Open file explorer" })
    keymap.set("n", "<leader>ec", "<cmd>Telescope file_browser close<CR>", { desc = "Close file explorer" })
    keymap.set("n", "<leader>er", "<cmd>Telescope file_browser<CR>", { desc = "Refresh file explorer" })
    keymap.set(
      "n",
      "<leader>ef",
      "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>",
      { desc = "Toggle file explorer on current file" }
    )
    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>fb", "<cmd>Telescope git_branches<cr>", { desc = "Switch Branches in current cwd" })

    -- Add this line to map project-wide diagnostics
    keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find project-wide diagnostics" })

    -- vim.api.nvim_set_keymap("n", "<leader>sf", ":Telescope treesitter<CR>", { noremap = true })
    -- vim.api.nvim_set_keymap("n", "<leader>sm", ":Telescope treesitter query=@method.outer<CR>", { noremap = true })
    --
    -- -- Function to open Telescope file browser in a floating window
    local function open_telescope_file_browser()
      require("telescope").extensions.file_browser.file_browser({
        cwd = vim.fn.getcwd(),
        respect_gitignore = false,
        hidden = true,
        grouped = true,
        previewer = false,
        initial_mode = "normal",
        layout_config = {
          width = 0.8,
          height = 0.8,
          preview_cutoff = 120,
          prompt_position = "top",
        },
      })
    end

    -- Autocommand to open Telescope file browser when starting Neovim with an empty buffer or directory
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function()
        -- Only open file explorer if no file is specified
        if vim.fn.argc() == 0 and tonumber(vim.fn.line2byte("$")) == -1 then
          open_telescope_file_browser()
        end
      end,
    })
  end,
}
