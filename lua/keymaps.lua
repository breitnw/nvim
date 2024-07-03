-- local opts = {
--   noremap = true,
--   silent = true,
-- }
local function opts(desc)
  return {
    desc = desc,
    noremap = true,
    silent = true,
    nowait = true
  }
end

-- Colemak remaps ------------------------------------------------------

-- remap o to navigation after f/k because ; is inconvenient in colemak
-- also remap O to :
vim.keymap.set('n', 'o', ';')
vim.keymap.set('n', 'O', ':')
vim.keymap.set('v', 'o', ';')
vim.keymap.set('v', 'O', ':')

-- and ' and " can open lines since they're close to the enter key
vim.keymap.set('n', '\'', 'o')
vim.keymap.set('n', '\"', 'O')
vim.keymap.set('v', '\'', 'o')
vim.keymap.set('v', '\"', 'O')

-- from evil-colemak-basics -------------------------------------------

-- change movement keys
vim.keymap.set('n', 'h', 'h', opts("Move left"))
vim.keymap.set('n', 'n', 'j', opts("Move down"))
vim.keymap.set('n', 'e', 'k', opts("Move up"))
vim.keymap.set('n', 'i', 'l', opts("Move right"))
vim.keymap.set('v', 'h', 'h', opts("Move left"))
vim.keymap.set('v', 'n', 'j', opts("Move down"))
vim.keymap.set('v', 'e', 'k', opts("Move up"))
vim.keymap.set('v', 'i', 'l', opts("Move right"))

-- search next/previous
vim.keymap.set('n', 'k', 'n', opts("Search next"))
vim.keymap.set('n', 'K', 'N', opts("Search previous"))
vim.keymap.set('v', 'k', 'n', opts("Search next"))
vim.keymap.set('v', 'K', 'N', opts("Search previous"))

-- u/U insert (and inner word selector)
-- OFF LIMITS
vim.keymap.set('', 'u', 'i', opts("Insert"))
vim.keymap.set('', 'U', 'I', opts("Insert"))

-- undo/redo
vim.keymap.set('n', 'l', 'u', opts("Undo"))
vim.keymap.set('v', 'l', 'u', opts("Undo"))
vim.keymap.set('n', 'L', '<c-r>', opts("Redo"))
vim.keymap.set('v', 'L', '<c-r>', opts("Redo"))

-- join lines
vim.keymap.set("n", ";", "J", opts("Join lines"))
vim.keymap.set("v", ";", "J", opts("Join lines"))

-- F/f: move to end of word
vim.keymap.set('n', 'f', 'e', opts("Move to the end of word"))
vim.keymap.set('n', 'F', 'E', opts("Move to the beginning of word"))
vim.keymap.set('v', 'f', 'e', opts("Move to the end of word"))
vim.keymap.set('v', 'F', 'E', opts("Move to the beginning of word"))

-- t: jump to character
-- OFF LIMITS
vim.keymap.set('', 't', 'f', opts("Jump to character"))
vim.keymap.set('', 'T', 'F', opts("Jump to character"))

-- j: jump until character
-- OFF LIMITS
vim.keymap.set('', 'j', 't', opts("Jump until character"))
vim.keymap.set('', 'J', 'T', opts("Jump until character"))

-- smoothie mappings
vim.keymap.set('n', 'N', '<cmd>call smoothie#downwards()<CR>', opts("Smoothie: downwards"))
vim.keymap.set('n', 'E', '<cmd>call smoothie#upwards()<CR>', opts("Smoothie: upwards"))
vim.keymap.set('v', 'N', '<cmd>call smoothie#downwards()<CR>', opts("Smoothie: downwards"))
vim.keymap.set('v', 'E', '<cmd>call smoothie#upwards()<CR>', opts("Smoothie: upwards"))

-- quick horizontal navigation
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'I', '$')

-- leader -----------------------------------------------------------------

vim.g.mapleader = " "
vim.keymap.set('', '<leader>', '<nop>', opts("<nop>"))

-- a few shortcuts with the leader
vim.keymap.set('', '<leader>ww', '<C-w>w', opts("Switch window"))
vim.keymap.set('', '<leader>wc', '<C-w>c', opts("Close window"))
vim.keymap.set('', '<leader>wo', '<C-w>o', opts("Close other windows"))
vim.keymap.set('', '<leader>ws', '<C-w>s', opts("Split horizontal")) -- split horizontal
vim.keymap.set('', '<leader>wv', '<C-w>v', opts("Split vertical"))   -- split vertical

-- navigate windows directionally
vim.keymap.set('', '<leader>wh', '<C-w>h', opts("Move to window left"))
vim.keymap.set('', '<leader>wn', '<C-w>j', opts("Move to window below"))
vim.keymap.set('', '<leader>we', '<C-w>k', opts("Move to window above"))
vim.keymap.set('', '<leader>wi', '<C-w>l', opts("Move to window right"))

-- yank to registers with <num>y, paste with <num>p
for i = 0, 9 do
  vim.keymap.set('v', i .. 'y', '"' .. i .. "y", opts("Yank to register " .. i))
  vim.keymap.set('', i .. 'p', '"' .. i .. "p", opts("Paste from register " .. i))
end

-- open NvimTree
vim.keymap.set('', '<leader>op', ':NvimTreeToggle<CR>', opts("Open NvimTree"))
vim.keymap.set('', '<leader>ot', ':ToggleTerm direction=float<CR>', opts("Open NvimTree"))

-- simple buffer navigation
-- TODO: use cokeline for this instead
vim.keymap.set('', '<leader>bp', ':bp<CR>', opts("Go to the previous buffer"))
vim.keymap.set('', '<leader>bn', ':bn<CR>', opts("Go to the next buffer"))

vim.keymap.set('', '<leader>bb', function()
  require('cokeline.mappings').pick("focus")
end, opts("Cokeline: Pick a buffer to focus"))
