return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    opts = {
      event_handlers = {
        {
          event = 'file_opened',
          handler = function(file_path)
            require('neo-tree').close_all()
          end,
        },
      },
      window = {
        mappings = {
          ['o'] = 'open',
        },
      },
    },
    branch = 'v2.x',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>[', ':Neotree toggle=true<CR>', desc = 'Neotree filesystem toggle' },
      { '<leader>]', ':Neotree filesystem reveal<CR>', desc = 'Find file in NvimTree' },
    },
    event = 'BufEnter',
  },
}
