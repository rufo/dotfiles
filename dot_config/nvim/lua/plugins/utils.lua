return {
  {
    'dstein64/vim-startuptime',
    cmd = 'StartupTime',
    config = function()
      vim.g.startuptime_tries = 10
    end,
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
      {"MikuAuahDark/json5.lua",
        build = function(plugin)
          local plug_path = function(path) return vim.fs.normalize(plugin.dir .. path) end

          vim.fn.mkdir(plug_path("/lua"), "p")
          local uv = vim.uv or vim.loop
          uv.fs_copyfile(plug_path("/json5.lua"), plug_path("/lua/json5.lua"))
        end
      },
    },
  }
}
