-- Set the leader key before plugins might add their own mappings.
vim.g.mapleader = ' '

-- Install packer.nvim if it doesn't already exist.
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.api.nvim_command 'packadd packer.nvim'
end

-- Run :PackerCompile whenever we make changes to the configuration.
vim.api.nvim_exec([[
augroup Packer
  autocmd!
  autocmd BufWritePost init.lua PackerCompile
augroup end
]], false)

--
-- Plugin configuration functions.
--

-- Configure CHADTree file explorer.
local configure_chadtree = function()
  local settings = {
    options = {
      close_on_open = true
    },
    theme = {
      discrete_colour_map = {
          black = vim.g['dracula#palette']['color_0'],
          red = vim.g['dracula#palette']['color_1'],
          green = vim.g['dracula#palette']['color_2'],
          yellow = vim.g['dracula#palette']['color_3'],
          blue = vim.g['dracula#palette']['color_4'],
          magenta = vim.g['dracula#palette']['color_5'],
          cyan = vim.g['dracula#palette']['color_6'],
          white = vim.g['dracula#palette']['color_7'],
          bright_black = vim.g['dracula#palette']['color_8'],
          bright_red = vim.g['dracula#palette']['color_9'],
          bright_green = vim.g['dracula#palette']['color_10'],
          bright_yellow = vim.g['dracula#palette']['color_11'],
          bright_blue = vim.g['dracula#palette']['color_12'],
          bright_magenta = vim.g['dracula#palette']['color_13'],
          bright_cyan = vim.g['dracula#palette']['color_14'],
          bright_white = vim.g['dracula#palette']['color_15'],
      }
    }
  }

  vim.api.nvim_set_var('chadtree_settings', settings)
end

local configure_compe_autocomplete = function()
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
    elseif check_back_space() then
      return t "<Tab>"
    else
      return vim.fn['compe#complete']()
    end
  end

  _G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
      return t "<C-p>"
    else
      return t "<S-Tab>"
    end
  end

  vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
  vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
  vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
  vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
end

-- Configure dracula color theme.
local configure_dracula = function()
  vim.cmd 'colorscheme dracula'
end

-- Configure gitsigns.
-- https://github.com/lewis6991/gitsigns.nvim#usage
local configure_gitsigns = function()
  require('gitsigns').setup()
end

-- Configure the LSP client:
-- https://github.com/neovim/nvim-lspconfig/blob/master/README.md
local configure_lsp = function()
  local lsp = require('lspconfig')

  lsp.cssls.setup({})
  lsp.html.setup({})
  lsp.jsonls.setup({})
  lsp.tsserver.setup({})
end

local configure_lualine = function()
  -- Shorter git branch text.
  local function get_branch()
    local branch = vim.fn['fugitive#head']()

    -- Clubhouse branches contain the ticket identifier preceded by "ch".
    local story = string.match(branch, 'ch%d+')

    -- Truncate to first ten characters if Clubhouse identifier not found.
    if (story == nil) then
      return string.sub(branch, 0, 9)
    end

    -- Use the "ch" identifier if we found one.
    return story
  end

  -- Simplify the fileformat and encoding to look like airline.
  local function get_file_info()
    local format = vim.bo.fileformat
    local encoding = vim.bo.fenc

    if encoding == '' then
      encoding = vim.go.enc
    end

    return encoding .. '[' .. format .. ']'
  end

  -- More compact line and column numbering.
  local function get_location()
    return [[ln:%l/%L cn:%c]]
  end

  -- Use the custom location display in fugitive window.
  local fugitive_extension = {
    sections = {
      lualine_a = { 'branch' },
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

local configure_telescope = function()
  local telescope = require('telescope')
  local actions = require('telescope.actions')

  telescope.setup({
    defaults = {
      layout_config = {
        horizontal = {
          preview_width = 0.5
        }
      },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous
        }
      }
    }
  })
end

-- Configure treesitter parsing.
-- https://github.com/nvim-treesitter/nvim-treesitter#quickstart
local configure_treesitter = function()
  local ts = require('nvim-treesitter.configs')

  ts.setup({
    ensure_installed = 'maintained',
    highlight = {
      enable = true
    }
  })

end

-- Configure vim-sandwich.
-- https://github.com/machakann/vim-sandwich/blob/master/README.md
local configure_vim_sandwich = function()
  -- Use vim-surround mappings to not conflict with vim-sneak.
  vim.cmd 'runtime macros/sandwich/keymap/surround.vim'
end

--
-- Install plugins.
--

require('packer').startup(function(use)
  -- Let packer mangage itself.
  use 'wbthomason/packer.nvim'

  use {
    'dracula/vim',
    as = 'dracula',
    config = configure_dracula
  }

  use {
    'hrsh7th/nvim-compe',
    config = configure_compe_autocomplete
  }

  use 'justinmk/vim-sneak'

  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = configure_gitsigns
  }

  use {
    'hoob3rt/lualine.nvim',
    config = configure_lualine
  }

  use {
    'machakann/vim-sandwich',
    config = configure_vim_sandwich
  }

  use {
    'ms-jpq/chadtree',
    after = 'dracula',
    branch = 'chad',
    run = 'python3 -m chadtree deps',
    config = configure_chadtree
  }

  use {
    'neovim/nvim-lspconfig',
    config = configure_lsp
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
    config = configure_telescope
  }
  
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = configure_treesitter
  }

  use {
    'nvim-treesitter/playground',
    run = ':TSInstall query'
  }

  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-rhubarb'
end)

--
-- Vim settings.
--

-- Enable 24-bit color.
vim.opt.termguicolors = true

-- Allow for hidden buffers. Necessary for some plugins.
vim.opt.hidden = true

-- Shorter update time for better experience.
vim.opt.updatetime = 500

-- Show a popup for autocomplettion and don't select an option by default.
vim.opt.completeopt = { 'menuone', 'noselect' }

-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append({ c = true })

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics or git signs appear/resolve.
vim.opt.signcolumn = 'yes'

-- Don't show the mode as lualine will already display it for us.
vim.opt.showmode = false

-- Show line numbers and make them relative to the cursor.
vim.opt.number = true
vim.opt.relativenumber = true

-- Always show lines above and below cursor when scrolling.
vim.opt.scrolloff = 3

-- Always put splits below or to the right.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set the title of the terminal window appropriately.
vim.opt.title = true

-- Use two columns for tabs in insert mode and for reindent operations.
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

-- Expand tabs to spaces in insert mode.
vim.opt.expandtab = true

-- Wrap text at 80 chars and show the ruler at 81.
vim.opt.textwidth = 80
vim.opt.colorcolumn = '+1'

-- Show a symbol for wrapped lines.
vim.opt.showbreak = '↪'

-- Case insensitive search, unless any capitals are used.
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undofile = true

-- au VimResized * :wincmd =

--
-- Mappings
--

-- Disable arrow keys in normal mode.
vim.api.nvim_set_keymap('n', '<up>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<down>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<left>', '', { noremap = true })
vim.api.nvim_set_keymap('n', '<right>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<up>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<down>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<left>', '', { noremap = true })
vim.api.nvim_set_keymap('i', '<right>', '', { noremap = true })

-- Quick escape from insert mode.
vim.api.nvim_set_keymap('i', 'jj', '<esc>', { noremap = true })

-- Easier redo.
vim.api.nvim_set_keymap('n', 'U', '<c-r>', { noremap = true })

-- Quick command mode.
vim.api.nvim_set_keymap('n', '<cr>', ':', { noremap = true })

-- LSP
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>cd', '<cmd>lua vim.lsp.buf.definition()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ci', '<cmd>lua vim.lsp.buf.implementation()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ct', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>rr', '<cmd>lua vim.lsp.buf.references()<cr>', { noremap = true })

-- Files
vim.api.nvim_set_keymap('n', '<leader>fc', '<cmd>bdelete<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fe', '<cmd>CHADopen<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ff', '<cmd>Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fl', ':ls<cr>:b<space>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fn', '<cmd>bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fo', '<cmd>Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fp', '<cmd>bprevious<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fs', '<cmd>update<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>vc', '<cmd>edit $MYVIMRC<cr>', { noremap = true })

-- Git
vim.api.nvim_set_keymap('n', '<leader>g', '<cmd>Git<cr>', { noremap = true })

-- Quit
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>quit<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>Q', '<cmd>quit!<cr>', { noremap = true })

-- Search
vim.api.nvim_set_keymap('n', '<leader>sn', '<cmd>noh<cr>', { noremap = true })
