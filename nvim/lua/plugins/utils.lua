return {
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
  },
  {
    'Joakker/lua-json5',
    build = './install.sh'
  },
  {
    "EthanJWright/vs-tasks.nvim",
    config = function()
      require("vstask").setup({
          json_parser = require('json5').parse
      })
    end,
    dependencies = {
      "nvim-lua/popup.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "Joakker/lua-json5",
    },
  }
}
