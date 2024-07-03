-- plugins relating to, well, loading the colorscheme
return {
  {
    "comfysage/evergarden",
    priority = 1000,
    config = function ()
      local evergarden = require("evergarden")
      evergarden.setup({
        transparent_background = false,
      })

      local colors = evergarden.colors()
      -- load the colors from evergarden:
      --   bg0_hard    = { "#1A2024", 0 },
      --   bg0         = { "#242B2E", 0 },
      --   bg0_soft    = { "#2D363B", 0 },
      --   bg1         = { "#343E44", 8 },
      --   bg2         = { "#3D494F", 8 },
      --   bg3         = { "#46545B", 8 },
      --   bg4         = { "#5E6C70", 8 },
      --   bg5         = { "#6E8585", 8 },
      --   fg          = { "#D6CBB4", 7 },
      --   red         = { "#E67E80", 1 },
      --   orange      = { "#E69875", 11 },
      --   yellow      = { "#DBBC7F", 3 },
      --   green       = { "#B2C98F", 2 },
      --   aqua        = { "#93C9A1", 6 },
      --   skye        = { "#97C9C3", 4 },
      --   blue        = { "#9BB5CF", 4 },
      --   purple      = { "#D6A0D1", 5 },
      --   pink        = { "#E3A8D1", 5 },
      --   grey0       = { "#7A8478", 8 },
      --   grey1       = { "#859289", 15 },
      --   grey2       = { "#9DA9A0", 8 },

      -- set evergarden as the color scheme
      vim.cmd([[colorscheme evergarden]])

      -- configure other highlight groups to play nice with it
      -- nvim-tree highlight groups
      -- vim.api.nvim_set_hl(0, 'NvimTreeNormal', {
      --   bg = colors.bg0_hard[1]
      -- })
      -- vim.api.nvim_set_hl(0, 'NvimTreeWinSeparator', {
      --   fg = colors.bg0_hard[1],
      --   bg = colors.bg0[1]
      -- })
      -- vim.api.nvim_set_hl(0, 'WinSeparator', {
      --   fg = colors.bg0_hard[1],
      --   bg = colors.bg0[1]
      -- })

      -- configure float highlight groups
      vim.api.nvim_set_hl(0, 'NormalFloat', { fg = colors.fg[1], bg = colors.bg0[1] })
      vim.api.nvim_set_hl(0, 'FloatBorder', { fg = colors.grey0[1], bg = colors.bg0[1] })
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { fg = colors.fg[1], bg = colors.bg0[1] })
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { fg = colors.grey0[1], bg = colors.bg0[1] })

      vim.api.nvim_set_hl(0, 'OkFloat', { link = "OkText" })
      vim.api.nvim_set_hl(0, 'ErrorFloat', { link = "ErrorText" })
      vim.api.nvim_set_hl(0, 'WarningFloat', { link = "WarningText" })
      vim.api.nvim_set_hl(0, 'InfoFloat', { link = "InfoText" })
      vim.api.nvim_set_hl(0, 'HintFloat', { link = "HintText" })
    end
  }
}
