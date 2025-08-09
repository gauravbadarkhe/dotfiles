return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- Follow latest release
      build = "make install_jsregexp",
    },
    "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "rafamadriz/friendly-snippets", -- useful snippets
    "onsails/lspkind.nvim", -- vs-code like pictograms
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- Load snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    vim.g.copilot_no_tab_map = true
    vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
          vim.fn["vsnip#anonymous"](args.body) -- You can use `luasnip`, `vsnip`, or others here
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- Add sorting logic to prioritize Field over Text
      sorting = {
        priority_weight = 2,
        comparators = {
          cmp.config.compare.offset,
          cmp.config.compare.exact,
          cmp.config.compare.score,
          -- Custom comparator for Field over Method
          function(entry1, entry2)
            local kind_priority = {
              Field = 1, -- Highest priority
              Method = 2, -- Lower than Field
              Text = 3, -- Lower than Method
            }
            print("Entry 1 kind:", entry1:get_kind())
            print("Entry 2 kind:", entry2:get_kind())
            local kind1 = kind_priority[entry1:get_kind()] or 100
            local kind2 = kind_priority[entry2:get_kind()] or 100
            if kind1 ~= kind2 then
              return kind1 < kind2
            end
          end,
          cmp.config.compare.kind,
          cmp.config.compare.sort_text,
          cmp.config.compare.length,
          cmp.config.compare.order,
        },
      },
      -- Sources for autocompletion
      sources = cmp.config.sources({
        -- { name = "copilot", priority = 1000 },
        { name = "nvim_lsp", priority = 900 }, -- Includes Fields and Methods
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }),
      -- Formatting settings for vs-code like pictograms
      formatting = {
        fields = { "abbr", "kind", "menu" },
        expandable_indicator = true,
        format = lspkind.cmp_format({
          maxwidth = 50,
          ellipsis_char = "...",
          with_text = true,
          menu = {
            copilot = "[Copilot]",
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            path = "[Path]",
          },
        }),
      },
      experimental = {
        ghost_text = true,
      },
    })
  end,
}
