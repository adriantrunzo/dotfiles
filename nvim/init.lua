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

  use {
    'dracula/vim',
    as = 'dracula',
    config = function()
      vim.cmd 'colorscheme dracula'
    end
  }

  use {
    'ms-jpq/chadtree',
    branch = 'chad',
    run = 'python3 -m chadtree deps',
    config = function()
      local settings = {
        options = {
          close_on_open = true
        }
      }

      vim.api.nvim_set_var('chadtree_settings', settings)
    end
  }

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }

  use {
    'hoob3rt/lualine.nvim',
    config = function()
      local function get_branch()
        local branch = vim.fn['fugitive#head']()
        local story = string.match(branch, '%W(ch%d+)%W')

        if (story == nil) then
          return string.sub(branch, 1, 10)
        end

        return story
      end

      local function get_file_info()
        local format = vim.bo.fileformat
        local encoding = vim.bo.fenc

	if encoding == '' then
          encoding = vim.go.enc
	end

        return encoding .. '[' .. format .. ']'
      end

      local function get_location()
        return [[ln: %l/%L cn: %2c]]
      end

      local fugitive_extension = {
        sections = {
          lualine_a = { get_branch },
          lualine_z = { get_location }
        },
        filetypes = { 'fugitive' }
      }

      require('lualine').setup({
        options = {
          component_separators = '|',
          icons_enabled = false,
          section_separators = '',
          theme = 'dracula'
        },
        sections = {
          lualine_b = { get_branch },
          lualine_x = {
            {
              'diagnostics',
              sources = { 'nvim_lsp' }
            },
            'filetype'
          },
          lualine_y = { get_file_info },
          lualine_z = { get_location }
        },
        extensions = {
          'chadtree',
          fugitive_extension
        }
      })
    end
  }

  use {
    'hrsh7th/nvim-compe',
    config = function()
      require('compe').setup({
        source = {
          path = true,
          buffer = true,
          nvim_lsp = true,
          nvim_lua = true
        }
      })

      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end

      local check_back_space = function()
        local col = vim.fn.col('.') - 1
        if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
          return true
        else
          return false
        end
      end

      -- Use (s-)tab to:
      --- move to prev/next item in completion menuone
      --- jump to prev/next snippet's placeholder
      _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
          return t "<C-n>"
        elseif vim.fn.call("vsnip#available", {1}) == 1 then
          return t "<Plug>(vsnip-expand-or-jump)"
        elseif check_back_space() then
          return t "<Tab>"
        else
          return vim.fn['compe#complete']()
        end
      end
      _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
          return t "<C-p>"
        elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
          return t "<Plug>(vsnip-jump-prev)"
        else
          -- If <S-Tab> is not working in your terminal, change it to <C-h>
          return t "<S-Tab>"
        end
      end

      vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
    end
  }

  use 'justinmk/vim-sneak'
  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
end)

vim.opt.termguicolors = true

vim.opt.hidden = true

vim.opt.updatetime = 500

vim.opt.completeopt = { 'menuone', 'noselect' }

vim.opt.shortmess:append({ c = true })

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

-- set shortmess+=c
-- au VimResized * :wincmd =

--
-- Mappings
--

-- Use space for leader key.
vim.g.mapleader = ' '

-- Disable arrow keys in normal mode.
vim.api.nvim_set_keymap('n', '<up>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<down>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<left>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<right>', '', { noremap = true })

-- Document movements.
vim.api.nvim_set_keymap('n', 'H', '^', { noremap = true })
vim.api.nvim_set_keymap('n', 'J', 'G', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', 'gg', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', '$', { noremap = true })

-- Easier undo.
vim.api.nvim_set_keymap('n', 'U', '<c-r>', { noremap = true })

-- Quick command mode.
vim.api.nvim_set_keymap('n', '<cr>', ':', { noremap = true })

-- Buffers
vim.api.nvim_set_keymap('n', '<leader>bd', '<cmd>bdelete<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bl', ':ls<cr>:b<space>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bn', '<cmd>bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>bp', '<cmd>bprevious<cr>', { noremap = true })

-- Code
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>lua vim.lsp.buf.definition()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cf', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ch', '<cmd>lua vim.lsp.buf.hover()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ci', '<cmd>lua vim.lsp.buf.implementation()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cn', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cN', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cR', '<cmd>lua vim.lsp.buf.references()<cr>', { noremap = true })

-- Files
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>edit $MYVIMRC<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fe', '<cmd>CHADopen<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>source $MYVIMRC<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>update<cr>', { noremap = true })

-- Git
vim.api.nvim_set_keymap('n', '<leader>gf', '<cmd>Telescope git_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gc', '<cmd>Git commit<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gg', '<cmd>Git<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>gp', '<cmd>Git push<cr>', { noremap = true })

-- General
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>quit<cr>', { noremap = true })

-- Disable arrow keys in insert mode.
vim.api.nvim_set_keymap('i', '<up>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<down>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<left>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<right>', '', { noremap = true })

-- Quick escape from insert mode.
vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true })

-- Quick escape from visual mode.
vim.api.nvim_set_keymap('v', 'v', '<esc>', { noremap = true })

