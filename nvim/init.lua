if vim.env.USE_CLASSIC_VIMRC then
  vim.opt.runtimepath:prepend { "~/.vim" }
  vim.opt.runtimepath:append { "~/.vim/after" }
  vim.o.packpath = vim.o.runtimepath
  vim.cmd('source ~/.vimrc')
  print("using vim config")
  return
end

require('bootstrap').setup()

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

vim.keymap.set('n', '<leader>[', ':NvimTreeToggle<CR>')
vim.keymap.set('n', '<leader>]', ':NvimTreeFindFileToggle<CR>')

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
pcall(vim.cmd, "colorscheme kanagawa")
vim.opt.termguicolors = true
vim.opt.background = "dark"

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "nosplit"
vim.opt.showmatch = true

vim.opt.undofile = true

require("nvim-tree").setup({
	-- renderer = {
	-- 	icons = {
	-- 		show = {
	-- 			file = false,
	-- 			folder_arrow = false,
	-- 		},
	-- 		glyphs = {
	-- 			symlink = "↪︎",
	-- 			folder = {
	-- 				default = "▶︎",
	-- 				open = "▼",
	-- 				empty = "▷",
	-- 				symlink = "↪︎▶︎",
	-- 				symlink_open = "↪︎▼",
	-- 			},
	-- 		},
	-- 	},
	-- },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

vim.keymap.set('n', '<leader>p', "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set('n', '<leader>b', "<cmd>lua require('fzf-lua').buffers()<CR>", { silent = true })

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "ruby", "lua", "json", "dockerfile", "javascript", "typescript", "bash",
    "comment", "css", "go", "html", "python", "regex", "scss", "toml", "vim",
    "yaml", "tsx", "vue", "make", "c",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  -- ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  endwise = {
    enable = true
  }
}

vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}

require("mason").setup()
require("mason-lspconfig").setup()

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

local cmp = require'cmp'
-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
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
    { name = 'cmdline' }
  })
})
require("indent_blankline").setup {
  show_current_context = true,
  show_current_context_start = true,
}

vim.keymap.set('v', '<leader>c', ':OSCYank<CR>')

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  pattern = { "*" },
  callback = function()
    if( vim.v.event.operator == 'y' and vim.v.event.regname == '') then
      vim.cmd('OSCYank')
    end
  end
})

require('feline').setup()

-- remove trailing whitespace
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

require('Comment').setup()
require('gitsigns').setup()
require('nvim-autopairs').setup {}
require('yanky').setup({})

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
