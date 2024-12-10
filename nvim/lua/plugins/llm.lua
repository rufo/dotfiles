return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    opts = {

    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      -- {
      --   -- support for image pasting
      --   "HakonHarnes/img-clip.nvim",
      --   event = "VeryLazy",
      --   opts = {
      --     -- recommended settings
      --     default = {
      --       embed_image_as_base64 = false,
      --       prompt_for_file_name = false,
      --       drag_and_drop = {
      --         insert_mode = true,
      --       },
      --       -- required for Windows users
      --       use_absolute_path = true,
      --     },
      --   },
      -- },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    }
        },
  },
  {
    'milanglacier/minuet-ai.nvim',
    opts = {
      provider = "gemini",
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'hrsh7th/nvim-cmp' },
    }
  },
  {
    "olimorris/codecompanion.nvim",
    enabled = false,
    depdendencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:op read 'op://Private/Anthropic API Key/credential' --no-newline"
              }
            })
          end,
          -- codestral = function()
          --   return require("codecompanion.adapters").extend("openai_compatible", {
          --     env = {
          --       url = "https://api.mistral.ai",
          --       api_key = "cmd:op read 'op://Private/Mistral/codestral api key' --no-newline",
          --       model = "codestral-latest"
          --     }
          --   })
          -- end
        },
        strategies = {
          chat = {
            adapter = "anthropic",
          },
          inline = {
            adapter = "anthropic"
          }
        },
      })
    end
  }
}
