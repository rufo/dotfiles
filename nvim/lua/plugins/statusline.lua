return {
  {
    'SmiteshP/nvim-navic',
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require('lsp-zero').on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require('nvim-navic').attach(client, buffer)
        end
      end)
    end,
    opts = { separator = ' ', highlight = true, depth_limit = 5 },
  },
  {
    'feline-nvim/feline.nvim',
    config = function()
      local components = require('feline.default_components').statusline.icons

      local navic = require('nvim-navic')
      table.insert(components.active[1], {
        provider = navic.get_location,
        enabled = navic.is_available,
        left_sep = {
          '  ',
          {
            str = 'slant_left',
            hl = {
              fg = 'fg',
              bg = 'bg',
            },
          },
          ' ',
        },
      })

      local force_inactive = {
        filetypes = {
          '^NvimTree$',
          '^packer$',
          '^startify$',
          '^fugitive$',
          '^fugitiveblame$',
          '^qf$',
          '^help$',
          '^neo%-tree$',
        },
        buftypes = {
          '^terminal$'
        },
        bufnames = {}
      }

      require('feline').setup({ components = components, force_inactive = force_inactive })
    end,
    event = 'VeryLazy',
  },
}
