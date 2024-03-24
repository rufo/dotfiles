if vim.env.USE_CLASSIC_VIMRC then
  vim.opt.runtimepath:prepend({ '~/.vim' })
  vim.opt.runtimepath:append({ '~/.vim/after' })
  vim.o.packpath = vim.o.runtimepath
  vim.cmd('source ~/.vimrc')
  print('using vim config')
  return
end

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins')

vim.cmd([[ cnoreabbrev W w ]])
vim.cmd([[ cnoreabbrev Wq wq ]])
vim.cmd([[ cnoreabbrev Q q ]])
vim.cmd([[ cnoreabbrev Qa qa ]])
vim.cmd([[ cnoreabbrev Qa! qa! ]])
vim.cmd([[ cnoreabbrev Q! q! ]])

vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('i', 'jj', '<ESC>')

-- F5 escape code is ^[[15~
vim.keymap.set('n', '<F5>', ':w<CR>')
vim.keymap.set('i', '<F5>', '<ESC>:w<CR>')

-- get the old behavior of Y back that my mind is too warped not to use
vim.keymap.del('n', 'Y')

vim.opt.mouse = 'a'

vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.scrolloff = 5
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = 'nosplit'
vim.opt.showmatch = true

vim.opt.undofile = true

vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }

vim.opt.guifont = "BerkeleyMono Nerd Font:h10"

function SetupAutoCopy()
  vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
    pattern = { '*' },
    callback = function()
      if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
        require('osc52').copy_register('')
      end
    end,
  })
end

-- remove trailing whitespace
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
