if not vim.env.USE_NEW_NVIM_CONFIG then
  vim.opt.runtimepath:prepend { "~/.vim" }
  vim.opt.runtimepath:append { "~/.vim/after" }
  vim.o.packpath = vim.o.runtimepath
  vim.cmd('source ~/.vimrc')
  print("using vim config")
  return
end

print("using neovim config")

require('plugins')

vim.cmd [[ cnoreabbrev W w ]]
vim.cmd [[ cnoreabbrev Wq wq ]]
vim.cmd [[ cnoreabbrev Q q ]]
vim.cmd [[ cnoreabbrev Qa qa ]]
vim.cmd [[ cnoreabbrev Qa! qa! ]]
vim.cmd [[ cnoreabbrev Q! q! ]]

vim.api.nvim_set_keymap('i', 'jk', '<ESC>', { noremap = true })
vim.api.nvim_set_keymap('i', 'jj', '<ESC>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>[', ':NvimTreeToggle<CR>', { noremap = true})
vim.api.nvim_set_keymap('n', '<leader>]', ':NvimTreeFindFileToggle<CR>', { noremap = true})

vim.opt.mouse = "a"

vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.colorcolumn = "80"
vim.opt.cursorline = true
vim.cmd "colorscheme kanagawa"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.inccommand = "nosplit"

require("nvim-tree").setup({
	renderer = {
		icons = {
			show = {
				file = false,
				folder_arrow = false,
			},
			glyphs = {
				symlink = "↪︎",
				folder = {
					default = "▶︎",
					open = "▼",
					empty = "▷",
					symlink = "↪︎▶︎",
					symlink_open = "↪︎▼",
				},
			},
		},
	},
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

vim.api.nvim_set_keymap('n', '<leader>p',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b',
    "<cmd>lua require('fzf-lua').buffers()<CR>",
    { noremap = true, silent = true })

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "ruby", "lua", "json", "dockerfile", "javascript", "typescript", "bash", "comment", "css", "go", "html", "python", "regex", "scss", "toml", "vim", "yaml", "tsx", "vue", "make", "c" },

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
}

require("nvim-lsp-installer").setup {}

vim.o.completeopt = "menu,menuone,noselect"

local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

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

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

