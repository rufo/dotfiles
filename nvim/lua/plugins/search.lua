return {
  {
    'wincent/ferret',
    cmd = {
      'Ack',
      'Lack',
      'Back',
      'Black',
      'Quack',
      'Acks',
      'Lacks',
      'Qargs',
      'Largs',
    },
  },
  { 'junegunn/fzf', build = './install --bin', lazy = true },
  {
    'ibhagwan/fzf-lua',
    dependencies = {
      'junegunn/fzf',
    },
    keys = {
      { '<leader>p', "<cmd>lua require('fzf-lua').files()<CR>", desc = 'FZF Files' },
      { '<leader>b', "<cmd>lua require('fzf-lua').buffers()<CR>", desc = 'FZF Buffers' },
    },
  },
}
