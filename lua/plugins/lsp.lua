-- plugins for loading language servers
return {
  -- LSP manager
  {
    "williamboman/mason.nvim",
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require('mason-lspconfig').setup({
        -- A list of servers to automatically install if they're not already installed
        ensure_installed = { 'lua_ls', 'rust_analyzer', 'jdtls', 'clangd', 'cmake' },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()

      -- diagnostic-related keymaps
      local opts = { noremap = true, silent = true }
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

      local lspconfig = require('lspconfig')

      -- disable virtual text to declutter (currently i want this enabled though)
      vim.diagnostic.config({
        virtual_text = false;
      })

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        -- NAVIGATION
        -- gD: go to declaration
        -- gd: go to definition
        -- gi: go to implementation
        -- gt: go to type definition
        -- gr: go to references

        -- DOCUMENTATION AND ACTIONS
        -- spc d: open documentation
        -- spc s h: signature help
        -- spc r n: rename
        -- spc c a: code action
        -- spc f: format
        -- spc e: open diagnostic
        -- spc q: diagnostic setloclist(?)
        -- [d: prev diagnostic
        -- ]d: next diagnostic

        -- WORKSPACE
        -- spc w a: add workspace folder
        -- spc w r: remove workspace folder
        -- spc w l: list workspace folders

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<leader>d', vim.lsp.buf.hover, bufopts) -- documentation
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)

        vim.keymap.set("n", "<leader>f", function()
          vim.lsp.buf.format({ async = true })
        end, bufopts)

        -- enable inlay hints
        -- TODO: doesn't work on java
        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true)
        end
      end

      -- Set different settings for different languages' LSP
      --
      -- LSP list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
      -- How to use setup({}): https://github.com/neovim/nvim-lspconfig/wiki/Understanding-setup-%7B%7D
      --     - the settings table is sent to the LSP
      --     - on_attach: a lua callback function to run after LSP attaches to a given buffer
      --
      -- How to add LSP for a specific language?
      -- 1. use `:Mason` to install corresponding LSP
      -- 2. add configuration below
      lspconfig.rust_analyzer.setup({ on_attach = on_attach })
      lspconfig.jdtls.setup({ on_attach = on_attach })
      lspconfig.clangd.setup({ on_attach = on_attach })
      lspconfig.cmake.setup({ on_attach = on_attach })
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths here.
                -- "${3rd}/luv/library"
                -- "${3rd}/busted/library",
              }
              -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
              -- library = vim.api.nvim_get_runtime_file("", true)
            }
          })
        end,
        settings = {
          Lua = {}
        }
      }
    end
  },
}
