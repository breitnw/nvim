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
  }
}
