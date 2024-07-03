-- plugins to help in navigating between files, buffers, projects, etc.
return {
  -- bufferline provides a "tab bar" type thing at the top.
  -- TODO: resolve rendering issues
  -- TODO: remove first bar if sidebar isn't visible?
  {
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local colors = require("evergarden").colors()

      local red = colors.red[1]
      local yellow = colors.yellow[1]
      local sep = colors.bg2[1]
      local fg_dark = colors.bg4[1]
      local bg = colors.bg0[1]
      local fg = colors.fg[1]

      local is_picking_focus = require('cokeline.mappings').is_picking_focus
      local is_picking_close = require('cokeline.mappings').is_picking_close

      local diag_color = function(buffer, fallback_color)
        return buffer.diagnostics.errors > 0 and red
            or buffer.diagnostics.warnings > 0 and yellow
            or fallback_color
      end

      require("cokeline").setup({
        pick = {
          use_filename = true,
          letters = "arstneiodhkmxcvbzuywfplgjq;"
        },
        sidebar = {
          filetype = "NvimTree",
          components = {
            {
              text = "  Filesystem",
              fg = fg_dark,
              bg = bg,
            }
          }
        },
        default_hl = {
          fg = function(buffer)
            return buffer.is_focused
                and fg
                or fg_dark
          end,
          bg = bg,
          sp = sep,
        },
        fill_hl = 'NvimTreeNormal',
        components = {
          {
            text = function(buffer)
              return buffer.is_first and '│' or '|';
            end,
            fg = sep,
          },
          -- spacer :O
          {
            text = '   ',
          },
          -- the file icon, or the letter of we're picking focus/close
          {
            text = function(buffer)
              return (is_picking_focus() or is_picking_close())
                  and buffer.pick_letter .. ' '
                  or buffer.devicon.icon
            end,
            fg = function(buffer)
              return (is_picking_focus() and yellow)
                  or (is_picking_close() and red)
                  or diag_color(buffer, buffer.is_focused and buffer.devicon.color or fg_dark)
            end,
            italic = function()
              return (is_picking_focus() or is_picking_close())
            end,
            bold = function()
              return (is_picking_focus() or is_picking_close())
            end
          },
          -- spacer :P
          {
            text = ' '
          },
          -- the filename
          {
            text = function(buffer)
              return buffer.filename .. '  '
            end,
            bold = function(buffer)
              return buffer.is_focused
            end,
            italic = function(buffer)
              return not (buffer.is_focused or buffer.buf_hovered)
            end,
            fg = function (buffer)
              return buffer.is_focused and diag_color(buffer, fg) or fg_dark
            end
          },
          -- a close button, of course... or a unsaved indicator
          {
            text = function(buffer)
              return buffer.is_modified and '● '
                  or buffer.buf_hovered and '× '
                  or '  '
            end,
            fg = function(buffer)
              return buffer.is_modified and yellow
                  or buffer.is_hovered and red
                  or fg_dark
            end,
            on_click = function(_, _, _, _, buffer)
              buffer:delete()
            end,
          },
        }
      })
    end
  },
  -- icons for neotree
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      -- TODO: work on keymaps
      require('nvim-web-devicons').setup {
        override = {
          make = {
            icon = ''
          }
        }
      }
    end
  },
  -- nvim-tree: better than neotree?
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require("nvim-tree").setup({
        -- project.nvim integration
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true
        },
        -- other config
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
        on_attach = function(bufnr)
          -- TODO: move this to a function in keymaps.lua
          local function opts(desc)
            return {
              desc = "nvim-tree: " .. desc,
              buffer = bufnr,
              noremap = true,
              silent = true,
              nowait = true
            }
          end
          local api = require("nvim-tree.api")
          -- api.config.mappings.default_on_attach(bufnr)
          vim.keymap.set('n', '?', api.tree.toggle_help, opts("Toggle Help"))
          vim.keymap.set('n', '.', api.tree.change_root_to_node, opts("Change root"))
          vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts("Navigate Up"))
          vim.keymap.set('n', '/', api.tree.search_node, opts("Search"))
          vim.keymap.set('n', '-', api.tree.reload, opts("Refresh"))
          vim.keymap.set('n', 'v', api.node.open.vertical, opts("Open in Vertical Split"))
          vim.keymap.set('n', 'h', api.node.open.horizontal, opts("Open in Horizontal Split"))
          vim.keymap.set('n', '<CR>', api.node.open.edit, opts("Open"))
          vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts("Open"))
          vim.keymap.set('n', '<Tab>', api.node.open.preview, opts("Open Preview"))
          vim.keymap.set('n', 'R', api.fs.rename_sub, opts("Rename (Omit Filename)"))
          vim.keymap.set('n', 'r', api.fs.rename_basename, opts("Rename"))
          vim.keymap.set('n', 'a', api.fs.create, opts("Add File or Directory"))
          vim.keymap.set('n', '<BS>', api.fs.trash, opts("Trash"))
          vim.keymap.set('n', 'y', api.fs.copy.node, opts("Copy"))
          vim.keymap.set('n', 'p', api.fs.paste, opts("Paste"))
          vim.keymap.set('n', 'x', api.fs.cut, opts("Cut"))
        end
      })
    end
  },
  -- fuzzy finder for files, buffers, live grep, etc.
  {
    "nvim-telescope/telescope.nvim",
    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local function opts(desc)
        return {
          desc = "telescope: " .. desc,
          noremap = true,
          silent = true,
          nowait = true
        }
      end
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, opts("Find files"))
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, opts("Live grep"))
      vim.keymap.set('n', '<leader>fb', builtin.buffers, opts("Find buffers"))
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, opts("Help"))
      vim.keymap.set('n', '<leader>fp', ':Telescope projects<CR>', opts("Find projects"))
    end,
  },
  -- project manager
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup({})
    end
  }
}
