return {
  -- autocomplete pictograms
  {
    "onsails/lspkind.nvim",
    event = { "VimEnter" },
  },
  -- autocomplete
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",                -- lsp auto-completion
      "hrsh7th/cmp-nvim-lsp-signature-help", -- lsp auto-completion
      -- "hrsh7th/cmp-buffer",                  -- buffer auto-completion
      "hrsh7th/cmp-path",                    -- path auto-completion
      "hrsh7th/cmp-cmdline",                 -- cmdline auto-completion
    },
    config = function()
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      local cmp = require("cmp")
      local types = require("cmp.types")
      local str = require("cmp.utils.str")

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- Use <C-b/f> to scroll the docs
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          -- Use <C-k/j> to switch in items
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          -- Use <CR>(Enter) to confirm selection
          -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

          -- A super tab
          -- sourc: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
          ["<Tab>"] = cmp.mapping(function(fallback)
            -- Hint: if the completion menu is visible select next one
            if cmp.visible() then
              cmp.select_next_item()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }), -- i - insert mode; s - select mode
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

        -- Let's configure the item's appearance
        formatting = {
          fields = {
            cmp.ItemField.Abbr,
            cmp.ItemField.Kind,
            cmp.ItemField.Menu,
          },
          format = lspkind.cmp_format({
            with_text = true,
            menu = {},
            -- menu = {
            --   buffer = "[buffer]",
            --   nvim_lsp = "[lsp]",
            --   luasnip = "[luasnip]",
            --   path = "[path]",
            -- },

            -- show only symbol annotations
            -- mode = 'symbol',
            -- prevent the popup from showing more than provided characters
            -- can also be a function to dynamically calculate max width such as maxwidth = function()
            -- return math.floor(0.45 * vim.o.columns) end
            maxwidth = function ()
              return math.floor(0.45 * vim.o.columns)
            end,

            -- when popup menu exceeds maxwidth, the truncated part would show ellipsis_char
            ellipsis_char = '...',

            -- show label details in menu. disabled by default
            -- show_labelDetails = true,

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization.
            -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              -- Get the full snippet (and only keep first line)
              -- local word = entry:get_insert_text()
              -- word = str.oneline(word)
              --
              -- if entry.completion_item.insertTextFormat == types.lsp.InsertTextFormat.Snippet
              --     and string.sub(vim_item.abbr, -1, -1) == "~"
              -- then
              --   word = word .. "~"
              -- end
              -- vim_item.abbr = word

              return vim_item
            end
          })
        },

        experimental = {
          ghost_text = true,
        },

        -- Set source precedence
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },   -- For nvim-lsp
          -- { name = 'nvim_lsp_signature_help' },
          { name = 'luasnip', },    -- For luasnip user
          -- { name = 'buffer' },      -- For buffer word completion
          { name = 'path' },       -- For path completion
        })
      })
    end,
  },
}
