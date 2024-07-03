return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      vim.filetype.add({extension = {wgsl = "wgsl"}})
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection    = "<leader>nn",
            node_incremental  = "<leader>ng",
            scope_incremental = "<leader>ns",
            node_decremental  = "<leader>nd",
          },
        },
        ensure_installed = { "wgsl", "r", "c", "lua", "vim", "vimdoc", "rust", "java" }
      })
    end
  }
}
