return {
  { 'zbirenbaum/copilot.lua',
    cmd = "Copilot",
    build = ":Copilot auth",
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require('copilot').setup({
        suggestion = {enabled = false},
        panel = {enabled = false},
      })

      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup()
    end,
    dependencies = {
      "copilot.lua"
    }
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    build = "make tiktoken",
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
