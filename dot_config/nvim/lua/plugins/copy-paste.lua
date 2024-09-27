return {
  {
    'gbprod/yanky.nvim',
    config = true,
    keys = {
      {'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }},
      {'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }},
      {'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }},
      {'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }},
      {'<c-p>', '<Plug>(YankyCycleForward)'},
      {'<c-n>', '<Plug>(YankyCycleBackward)'},
    }
  },
  {
    'ojroques/nvim-osc52',
    config = true,
    keys = {
      {
        '<leader>c',
        function()
          require('osc52').copy_operator()
          require('notify')('Copied to clipboard', vim.log.levels.INFO)
        end,
        desc = "Copy via osc52"
      },
      { '<leader>cc', '<leader>c_', remap = true },
      {
        '<leader>c', function()
          require('osc52').copy_visual()
          require('notify')('Copied to clipboard', vim.log.levels.INFO)
        end,
        mode = {'v'},
        desc = "Copy via osc52"
      },
    },
  },
}
