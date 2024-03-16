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
  }
}
