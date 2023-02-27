return {
  { 'tpope/vim-repeat', event = 'VeryLazy' },
  { 'tpope/vim-surround', event = 'VeryLazy' },
  { 'numToStr/Comment.nvim', config = true, event = 'VeryLazy' },
  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
    event = 'BufReadPre',
  },
  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()

      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
    event = 'InsertEnter',
  }
}
