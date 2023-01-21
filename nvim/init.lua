if vim.env.USE_CLASSIC_VIMRC then
  vim.opt.runtimepath:prepend { "~/.vim" }
  vim.opt.runtimepath:append { "~/.vim/after" }
  vim.o.packpath = vim.o.runtimepath
  vim.cmd('source ~/.vimrc')
  print("using vim config")
  return
end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local PKGS = {
  {'nvim-lua/plenary.nvim',
    lazy = true,
  };
  {'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme kanagawa]])
    end
  };
  {'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = "BufReadPost",
    opts = {
      ensure_installed = {
        "ruby",
        "lua",
        "json",
        "dockerfile",
        "javascript",
        "typescript",
        "bash",
        "comment",
        "css",
        "go",
        "html",
        "python",
        "regex",
        "scss",
        "toml",
        "vim",
        "yaml",
        "tsx",
        "vue",
        "make",
        "c",
        "markdown",
        "markdown_inline",
        "help",
      },
      -- Install parsers synchronously when headless
      sync_install = #vim.api.nvim_list_uis() == 0,

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },

      endwise = {
        enable = true,
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = {'RRethy/nvim-treesitter-endwise',},
  };
  {'wincent/ferret',
    cmd = {
      "Ack",
      "Lack",
      "Back",
      "Black",
      "Quack",
      "Acks",
      "Lacks",
      "Qargs",
      "Largs",
    }
  };
  {'tpope/vim-repeat',
    event = "VeryLazy",
  };
  {'tpope/vim-surround',
    event = "VeryLazy",
  };
  {'tpope/vim-fugitive',
    event = "VeryLazy",
  };
  {'tpope/vim-rails',
    event = "VeryLazy",
  };
  {'nvim-neo-tree/neo-tree.nvim',
    opts = {
      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path)
            require("neo-tree").close_all()
          end
        }
      },
      window = {
        mappings = {
          ["o"] = "open"
        }
      }
    },
    branch = "v2.x",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>[", ":Neotree toggle=true<CR>", desc = "Neotree filesystem toggle" },
      { "<leader>]", ":Neotree filesystem reveal<CR>", desc = "Find file in NvimTree" },
    },
    event = "BufEnter"
  };
  {'numToStr/Comment.nvim',
    config = true,
    event = "VeryLazy",
  };
  {'junegunn/fzf',
    build = './install --bin',
    lazy = true,
  };
  {'ibhagwan/fzf-lua',
    dependencies = {
      "junegunn/fzf",
    },
    keys = {
      { "<leader>p", "<cmd>lua require('fzf-lua').files()<CR>", desc = "FZF Files" },
      { "<leader>b", "<cmd>lua require('fzf-lua').buffers()<CR>", desc = "FZF Buffers" },
    }
  };
  {'lewis6991/gitsigns.nvim',
    config = true,
    event = "BufReadPre",
  };
  {'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end,
    event = "InsertEnter",
  };
  {'VonHeikemen/lsp-zero.nvim',
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup()
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      lsp.nvim_workspace()
      lsp.setup()

      lsp.configure('yamlls', {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "docker-compose.yml",
            }
          }
        }
      })
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip'
    },
    event = "BufReadPre"
  };
  {'jose-elias-alvarez/null-ls.nvim',
    event = "BufReadPre",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.formatting.erb_lint,
          null_ls.builtins.diagnostics.rubocop,
          null_ls.builtins.formatting.rubocop,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.formatting.eslint,
          null_ls.builtins.completion.spell,
        },
      })
    end,
    dependencies = {
      'williamboman/mason.nvim',
    },
  };
  {'williamboman/mason.nvim',
    cmd = "Mason",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
      }
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  };

  -- Autocompletion
  {'hrsh7th/nvim-cmp',
    event = {
      "InsertEnter",
      "CmdlineEnter",
    },
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require('cmp')
      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = {
          { name = "luasnip" }
        }
      }
      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'buffer' },
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            { name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              }
            }
          })
      })
    end
  };

  {'hrsh7th/cmp-nvim-lua',
    ft = "lua",
    config = function()
      require('cmp').setup {
        sources = {
          { name = "nvim_lua" }
        }
      }
    end
  },

  -- Snippets
  {'L3MON4D3/LuaSnip',
    dependencies = {
      'rafamadriz/friendly-snippets',
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    lazy = true,
  };

  {'RRethy/nvim-treesitter-endwise',
    lazy = true,
  };

  {'lukas-reineke/indent-blankline.nvim',
    opts = {
      show_current_context = true,
      show_current_context_start = true,
    },
    event = "BufReadPre",
  };

  {'ojroques/vim-oscyank',
    cmd = "OSCYank",
  };

  {'zbirenbaum/copilot.lua',
    event = "VeryLazy",
    config = true,
  };

  {'gbprod/yanky.nvim',
    config = true,
    event = "VeryLazy",
  };

  {'feline-nvim/feline.nvim',
    config = true,
  };
}

require('lazy').setup(PKGS)

vim.cmd [[ cnoreabbrev W w ]]
vim.cmd [[ cnoreabbrev Wq wq ]]
vim.cmd [[ cnoreabbrev Q q ]]
vim.cmd [[ cnoreabbrev Qa qa ]]
vim.cmd [[ cnoreabbrev Qa! qa! ]]
vim.cmd [[ cnoreabbrev Q! q! ]]

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'jj', '<ESC>')

vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({"n","x"}, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({"n","x"}, "gP", "<Plug>(YankyGPutBefore)")
vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleForward)", {})
vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)", {})
vim.keymap.del("n", "Y") -- too used to the old behavior /shrug

vim.opt.mouse = "a"

vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.scrolloff = 5
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit"
vim.opt.showmatch = true

vim.opt.undofile = true

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}

vim.keymap.set('v', '<leader>c', ':OSCYank<CR>')

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function()
    if( vim.v.event.operator == 'y' and vim.v.event.regname == '') then
      vim.cmd('OSCYank')
    end
  end
})

-- remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
