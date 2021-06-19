local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]], false)

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'neovim/nvim-lspconfig',
    config = function()
      local lsp = require('lspconfig')

      lsp.cssls.setup({})
      lsp.html.setup({})
      lsp.jsonls.setup({})
      lsp.tsserver.setup({})
    end
  }

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      local ts = require('nvim-treesitter.configs')

      ts.setup({
        ensure_installed = 'maintained',
        highlight = {
          enable = true
        }
      })
    end
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  use { 'dracula/vim', as = 'dracula' }

  use 'justinmk/vim-sneak'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
end)

vim.opt.termguicolors = true
vim.cmd 'colorscheme dracula'

vim.opt.hidden = true

vim.opt.signcolumn = 'yes'

vim.opt.showmode = false

vim.opt.cursorline = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.scrolloff = 3

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.title = true

vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.expandtab = true

vim.opt.textwidth = 80
vim.opt.colorcolumn = '+1'

vim.opt.showbreak = '↪'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.api.nvim_set_keymap('n', '<up>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<down>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<left>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<right>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<up>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<down>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<left>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<right>', '', { noremap = true })

vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true })

vim.api.nvim_set_keymap('v', 'v', '<esc>', { noremap = true })

vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true })
vim.api.nvim_set_keymap('n', 'J', 'G', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', 'gg', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true })

vim.api.nvim_set_keymap('n', 'U', '<c-r>', { noremap = true })

vim.api.nvim_set_keymap('n', '<cr>', ':', { noremap = true })

vim.g.mapleader = ' '

vim.api.nvim_set_keymap('n', '<leader>bd', '<cmd>bdelete<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bl', ':ls<cr>:b<space>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bn', '<cmd>bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd>bprevious<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>cd', '<plug>(coc-definition)', {})
vim.api.nvim_set_keymap('n', '<leader>cf', '<cmd>Rg<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ci', '<plug>(coc-implementation)', {})
vim.api.nvim_set_keymap('n', '<leader>cn', '<plug>(coc-diagnostic-next)', {})
vim.api.nvim_set_keymap('n', '<leader>cN', '<plug>(coc-diagnostic-prev)', {})
vim.api.nvim_set_keymap('n', '<leader>cq', '<plug>(coc-fix-current)', {})
vim.api.nvim_set_keymap('n', '<leader>cr', '<plug>(coc-rename)', {})

vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>edit $MYVIMRC<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fe', '<cmd>CHADopen<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>source $MYVIMRC<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>update<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>gf', '<cmd>GFiles<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gc', '<cmd>Git commit<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>Git<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gp', '<cmd>Git push<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>quit<cr>', { noremap = true })
