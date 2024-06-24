-- nvim-tree asked me to disable netrw idk what this means
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- setup options and keymaps, since we need the leader key mapped before loading lazy
require('options')
require('keymaps')

-- initialize lazy.nvim plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

-- setup user interface settings
-- we need to load this after lazy because it accesses lspconfig to modify window appearance
require('ui_settings')
