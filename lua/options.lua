-- vim.opt.clipboard = 'unnamedplus'
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.opt.mouse = 'a'

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.showmode = false

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"
vim.opt.wrap = false

vim.opt.list = true
vim.opt.listchars = {
--  lead = '·',   -- Display spaces as dots
  tab = '»·',    -- Display tabs with a special character
  trail = '·',   -- Display trailing spaces
  extends = '⟩', -- Display character for text that extends beyond the window
  precedes = '⟨' -- Display character for text that precedes the window
}

-- enable mouse move events so that we can have cool hover effects
-- TODO
vim.opt.mousemoveevent = true

