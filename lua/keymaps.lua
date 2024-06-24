local opts = {
  noremap = true,
  silent = true,
}

-- remap U to redo
vim.keymap.set('', 'U', '<c-r>')

-- change movement keys
vim.keymap.set('', 'n', 'j', opts)
vim.keymap.set('', 'e', 'k', opts)
vim.keymap.set('', 's', 'h', opts)
vim.keymap.set('', 't', 'l', opts)

-- l: "end" - "last"
vim.keymap.set('', 'l', 'e', opts)
vim.keymap.set('', 'L', 'E', opts)

-- k: "towards" - "kin"
vim.keymap.set('', 'k', 't', opts)
vim.keymap.set('', 'K', 'T', opts)

-- h: "next / previous" - "hop"
vim.keymap.set('', 'h', 'n', opts)
vim.keymap.set('', 'H', 'N', opts)

-- smoothie mappings
vim.keymap.set('', 'N', '<cmd>call smoothie#downwards()<CR>', opts)
vim.keymap.set('', 'E', '<cmd>call smoothie#upwards()<CR>', opts)
vim.keymap.set('', 'S', '<cmd>call smoothie#backwards()<CR>', opts)
vim.keymap.set('', 'T', '<cmd>call smoothie#forwards()<CR>', opts)

-- leader
vim.g.mapleader = " "
vim.keymap.set('', '<leader>', '<nop>', opts)

-- a few shortcuts with the leader
vim.keymap.set('', '<leader>ww', '<C-w>w', opts)
vim.keymap.set('', '<leader>wc', '<C-w>c', opts)
vim.keymap.set('', '<leader>wo', '<C-w>o', opts)
vim.keymap.set('', '<leader>wh', '<C-w>s', opts) -- split horizontal
vim.keymap.set('', '<leader>wv', '<C-w>v', opts) -- split vertical

-- navigate windows directionally
vim.keymap.set('', '<leader>wn', '<C-w>j', opts)
vim.keymap.set('', '<leader>we', '<C-w>k', opts)
vim.keymap.set('', '<leader>ws', '<C-w>h', opts)
vim.keymap.set('', '<leader>wt', '<C-w>l', opts)

vim.keymap.set('', '<leader>wN', '<C-w>J', opts)
vim.keymap.set('', '<leader>wE', '<C-w>K', opts)
vim.keymap.set('', '<leader>wS', '<C-w>H', opts)
vim.keymap.set('', '<leader>wT', '<C-w>L', opts)

-- yank to registers with <num>y, paste with <num>p
for i=0,9 do
  vim.keymap.set('v', i .. 'y', '"' .. i .. "y", opts)
  vim.keymap.set('n', i .. 'p', '"' .. i .. "p", opts)
end

-- open neotree
vim.keymap.set('', '<leader>op', ':NvimTreeToggle<CR>', opts)
-- vim.keymap.set('', '\\', ':Neotree float<CR>', opts)

-- simple buffer navigation 
-- TODO: use cokeline for this instead
vim.keymap.set('', '<leader>bp', ':bp<CR>', { desc = "Go to the previous buffer"})
vim.keymap.set('', '<leader>bn', ':bn<CR>', { desc = "Go to the next buffer"})

vim.keymap.set('', '<leader>bb', function ()
  require('cokeline.mappings').pick("focus")
end, { desc = "Pick a buffer to focus "})
