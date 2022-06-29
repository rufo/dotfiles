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
