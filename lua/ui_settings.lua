-- miscellaneous stuff relating to user interface - undercurl, window borders, icons, etc.

-- configure highlight groups with undercurl
local undercurl_hl_groups = {
  'DiagnosticUnderlineError',
  'DiagnosticUnderlineWarn',
  'DiagnosticUnderlineInfo',
  'DiagnosticUnderlineHint'
};

for _, hl in ipairs(undercurl_hl_groups) do
  vim.cmd.highlight(hl .. ' gui=undercurl')
end

-- rounded borders for floats
local _border = "rounded"

-- for hover docs (?)
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

-- for signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

-- for diagnostics
vim.diagnostic.config {
  float = { border = _border }
}

-- for lspconfig
require('lspconfig.ui.windows').default_options = {
  border = _border
}

-- Configure other icons
-- silly faces...
vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })


-- chunky window borders
-- vim.opt.fillchars = { horiz = '━', horizup = '┻', horizdown = '┳', vert = '┃', vertleft = '┫', vertright = '┣', verthoriz = '╋', }

-- window borders aligned to the windows properly
-- vim.opt.fillchars = {
--   horiz = '─',
--   horizup = '─',
--   horizdown = '─',
--   vert = '▏',
--   vertleft = '▏',
--   vertright = '─',
--   verthoriz = '─',
-- }

-- horizontal window borders via global status line
vim.opt.laststatus = 3
