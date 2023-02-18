return {
  {'feline-nvim/feline.nvim',
    config = function ()
      local components = require('feline.default_components').statusline.icons

      local navic = require("nvim-navic")
      table.insert(components.active[1], {
        provider = function()
          return navic.get_location()
        end,
        enabled = function()
          return navic.is_available()
        end,
        left_sep = {
          "  ",
          { str = "slant_left",
            hl = {
              fg = 'fg',
              bg = 'bg',
            }
          },
          " ",
        }
      })
      require('feline').setup({components = components})
    end,
    event = "VeryLazy",
  };
}