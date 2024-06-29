-- plugins related to editing individual files. includes stuff like autocomplete,
-- editor commands, etc. 

return {
  -- smooth scrolling
  'psliwka/vim-smoothie',
  -- autopairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equalent to setup({}) function
  },
  -- comment
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
    config = function ()
      require('Comment').setup({})
    end
  },
  -- surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function ()
      require("nvim-surround").setup({})
    end
  },
  -- automatically indent to the correct width when tab is pressed
  {
    'vidocqh/auto-indent.nvim',
    config = function ()
      require("auto-indent").setup({
        ignore_filetype = {},
        indentexpr = function(lnum)
          return require("nvim-treesitter.indent").get_indent(lnum)
        end
      })
    end
  },
  -- motions
  -- {
  --   'smoka7/hop.nvim',
  --   version = "*",
  --   opts = {
  --     keys = "arstneiodhkmxcvbzuywfplgjq;"
  --   },
  --   config = function ()
  --     local hop = require("hop")
  --     local directions = require('hop.hint').HintDirection
  --     vim.keymap.set('', 'f', function()
  --       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
  --     end, {remap=true})
  --     vim.keymap.set('', 'F', function()
  --       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
  --     end, {remap=true})
  --     vim.keymap.set('', 'k', function()
  --       hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
  --     end, {remap=true})
  --     vim.keymap.set('', 'K', function()
  --       hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
  --     end, {remap=true})
  --   end
  -- }
}
