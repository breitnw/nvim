-- tools found in non-editor windows, such as the terminal
return {
  -- toggleterm
  {
    'akinsho/toggleterm.nvim', version = "*",
    config = function()
      require("toggleterm").setup({
        open_mapping = [[<c-\>]],
        shading_factor = '-15',
        float_opts = {
          border = 'curved',
          title_pos = 'center',
        },
        highlights = {
          floatborder = {
            guifg = "#7a8478",
            guibg = "#242b2e",
          }
        }
      })
    end
  }
}
