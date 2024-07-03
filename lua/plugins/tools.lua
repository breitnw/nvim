-- tools found in non-editor windows, such as the terminal
return {
  -- which-key
  -- TODO: move ALL keybinds here
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function ()
      local wk = require("which-key")
      wk.register({
        ["<leader>"] = {
          f = { name = "+find" },
          b = { name = "+buffer" },
          c = { name = "+codeaction" },
          n = { name = "+node" },
          o = { name = "+open" },
          r = { name = "+refactor" },
          s = { name = "+signature" },
          w = { name = "+window" },
        }
      })
    end
  },
  -- toggleterm
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        shading_factor = '-15',
        float_opts = {
          border = 'curved',
          title_pos = 'center',
        },
        highlights = {
          FloatBorder = {
            guifg = "#859289",
            guibg = "#242b2e",
          }
        }
      })
    end
  }
}
