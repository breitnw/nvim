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
        ensure_installed = {
          'lua_ls',
          'rust_analyzer',
          'clangd',
          'cmake',
          'r_language_server',
          'jinja_lsp', -- TODO: Make this actually work
          'pyright',
          'wgsl_analyzer',
          'jdtls',
        },
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local function opts(desc)
        return {
          desc = "lsp: " .. desc,
          noremap = true,
          silent = true,
          nowait = true
        }
      end
      -- diagnostic-related keymaps
      vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts("Open diagnostics"))
      vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts("Previous diagnostic"))
      vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts("Next diagnostic"))
      vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts("List diagnostic info"))

      local lspconfig = require('lspconfig')

      -- disable virtual text to declutter (currently i want this enabled though)
      vim.diagnostic.config({
        virtual_text = false,
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
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts("Go to declaration"))
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts("Go to definition"))
        vim.keymap.set('n', '<leader>d', vim.lsp.buf.hover, opts("Open documentation")) -- documentation
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts("Go to implementation"))
        vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, opts("Signature help"))
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts("Add workspace folder"))
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts("Remove workspace folder"))
        vim.keymap.set('n', '<leader>wl', function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts("List workspace folders"))
        vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, opts("Go to type definition"))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts("Rename"))
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts("Code action"))
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts("Show references"))

        vim.keymap.set("n", "<leader>bf", function()
          vim.lsp.buf.format({ async = true })
        end, opts("Format buffer"))

        -- enable inlay hints
        -- TODO: doesn't work on java
        if vim.lsp.inlay_hint then
          vim.lsp.inlay_hint.enable(true)
        end
      end

      -- enable nvim-cmp capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      require('lspconfig')['jdtls'].setup {
        capabilities = capabilities,
      }

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
      lspconfig.rust_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.clangd.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.cmake.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.pyright.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.wgsl_analyzer.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.jinja_lsp.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.r_language_server.setup({ on_attach = on_attach, capabilities = capabilities })
      lspconfig.bashls.setup({ on_attach = on_attach, capabilities = capabilities })

      lspconfig.jdtls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        -- disable noisy messages from jdtls
        handlers = {
          ['language/status'] = function(_, result)
            -- vim.print('***')
          end,
          ['$/progress'] = function(_, result, ctx)
            -- vim.print('---')
          end,
        },
        -- load jdtls settings to disable TODO underline
        settings = {
          ['java.settings.url'] = '~/.config/nvim/jdtls_settings.pref',
        }
      });

      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
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
