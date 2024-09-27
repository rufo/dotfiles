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
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>p", "<cmd>Telescope find_files<CR>", desc = "FZF Files" },
      { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "FZF Buffers" },
    },
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require('telescope').setup()
      require('telescope').load_extension('fzf')
    end,
  },
}
