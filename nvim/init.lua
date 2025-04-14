local package_path = vim.fn.stdpath("data") .. "/site"
local mini_path = package_path .. "/pack/deps/start/mini.nvim"

if not vim.loop.fs_stat(mini_path) then
  vim.cmd('echo "Installing `mini.nvim`" | redraw')

  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.nvim",
    mini_path
  })
  vim.cmd("packadd mini.nvim | helptags ALL")
  vim.cmd('echo "Installed `mini.nvim`" | redraw')
end

-- Autocommand group to use throughout this configuration file.
vim.api.nvim_create_augroup("Config", { clear = true })

-- Use space for leader.
vim.g.mapleader = vim.keycode("<space>")

-- Use the sneak label mode for faster jumping.
vim.g["sneak#label"] = 1

vim.opt.colorcolumn = { "+1" }
vim.opt.expandtab = true
vim.opt.formatexpr = 'v:lua.require"conform".formatexpr()'
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ I = true })
vim.opt.showbreak = "↪"
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitkeep = "topline"
vim.opt.splitright = true
vim.opt.textwidth = 80
vim.opt.title = true
vim.opt.undofile = true
vim.opt.wildoptions = { fuzzy = true, pum = true }

require("mini.deps").setup({
  path = {
    package = package_path
  }
})

MiniDeps.add({ name = dracula, source = "dracula/vim" })
MiniDeps.add({ source = "ibhagwan/fzf-lua" })
MiniDeps.add({ source = "justinmk/vim-sneak" })
MiniDeps.add({ source = "luukvbaal/nnn.nvim" })
MiniDeps.add({ source = "neovim/nvim-lspconfig" })
MiniDeps.add({
  source = "nvim-treesitter/nvim-treesitter",
  hooks = {
    post_checkout = function()
      vim.cmd("TSUpdate")
    end
  },
})
MiniDeps.add({ source = "stevearc/conform.nvim" })
MiniDeps.add({ source = "tpope/vim-fugitive" })

local function get_statusline_git_string()
  if not MiniStatusline.is_truncated(40) then
    local git_status = vim.fn.FugitiveStatusline()

    if git_status ~= "" then
      local git_diff = vim.b.minidiff_summary_string
      local git_modifier = (git_diff ~= nil and git_diff ~= "") and "!" or ""
      local git_branch = string.match(git_status, "Git%((.+)%)")

      if git_branch ~= nil then
        local ticket = string.match(git_branch, "sc%-%d+")
        return (ticket ~= nil and ticket or git_branch) .. git_modifier
      end
    end
  end

  return ''
end

local function get_statusline_filetype_string()
  return vim.bo.filetype
end

local function get_statusline_fileinfo_string(args)
  local is_special_buffer = vim.bo.buftype ~= ""
  local is_truncated = MiniStatusline.is_truncated(args.trunc_width)

  if is_truncated or is_special_buffer then
    return ""
  end

  local format = vim.bo.fileformat
  local encoding = vim.bo.fileencoding or vim.bo.encoding

  return string.format('%s[%s]', encoding, format)
end

local function get_statusline_location_string(args)
  local is_truncated = MiniStatusline.is_truncated(args.trunc_width)
  return is_truncated and "ln:%l cn:%v" or "ln:%l/%L cn:%v"
end

local function get_active_statusline_string()
  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  local git = get_statusline_git_string()
  local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
  local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
  local filename = MiniStatusline.section_filename({ trunc_width = 140 })
  local filetype = get_statusline_filetype_string()
  local fileinfo = get_statusline_fileinfo_string({ trunc_width = 120 })
  local location = get_statusline_location_string({ trunc_width = 75 })

  return MiniStatusline.combine_groups({
    { hl = mode_hl,                  strings = { mode } },
    { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics, lsp } },
    '%<', -- Mark general truncate point
    { hl = 'MiniStatuslineFilename', strings = { filename } },
    '%=', -- End left alignment
    { hl = "MiniStatuslineFilename", strings = { filetype } },
    { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
    { hl = mode_hl,                  strings = { location } },
  })
end

require("conform").setup({
  formatters_by_ft = {
    css = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    scss = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    ['_'] = { 'trim_whitespace', 'trim_newlines' },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})
require("mini.ai").setup({
  custom_textobjects = {
    -- Whole buffer.
    e = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line('$'),
        col = math.max(vim.fn.getline('$'):len(), 1)
      }
      return { from = from, to = to }
    end,
    -- Any common matching pairs.
    m = {
      { "%b''", '%b""', '%b``', '%b()', '%b[]', '%b{}', '%b<>' },
      '^.().*().$'
    },
  },
})
require("mini.align").setup()
require("mini.bracketed").setup()
require("mini.bufremove").setup()
require("mini.diff").setup({
  view = {
    style = "sign"
  }
})
require("mini.indentscope").setup()
require("mini.move").setup()
require("mini.operators").setup()
require("mini.pairs").setup()
require("mini.splitjoin").setup()
require("mini.statusline").setup({
  content = {
    active = get_active_statusline_string
  },
})
require("mini.surround").setup({
  mappings = {
    add = 'ma', -- Add surrounding in Normal and Visual modes
    delete = 'md', -- Delete surrounding
    find = 'mf', -- Find surrounding (to the right)
    find_left = 'mF', -- Find surrounding (to the left)
    highlight = 'mh', -- Highlight surrounding
    replace = 'mr', -- Replace surrounding
    update_n_lines = 'mn', -- Update `n_lines`
  },
})
require("nnn").setup()
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "comment",
    "dockerfile",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "make",
    "nginx",
    "python",
    "ruby",
    "terraform",
    "typescript",
    "vimdoc",
    "yaml",
  },
  highlight = {
    enable = true
  },
})

vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function ()
    local palette = vim.g["dracula#palette"]

    local background = palette.bg[1]
    local comment = palette.comment[1]
    local foreground = palette.fg[1]
    local green = palette.green[1]
    local orange = palette.orange[1]
    local purple = palette.purple[1]
    local selection = palette.selection[1]
    local yellow = palette.yellow[1]

    vim.api.nvim_set_hl(0, "MiniDiffSignAdd", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "MiniDiffSignChange", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "MiniDiffSignDelete", { link = "DiffDelete" })

    vim.api.nvim_set_hl(0, "MiniStatuslineDevInfo", { bg = comment, fg = foreground })
    vim.api.nvim_set_hl(0, "MiniStatuslineFileInfo", { bg = comment, fg = foreground })
    vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = selection , fg = foreground })
    vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = selection, fg = foreground })
    vim.api.nvim_set_hl(0, "MiniStatuslineModeCommand", { bg = purple, fg = background })
    vim.api.nvim_set_hl(0, "MiniStatuslineModeInsert", { bg = green, fg = background })
    vim.api.nvim_set_hl(0, "MiniStatuslineModeNormal", { bg = purple, fg = background })
    vim.api.nvim_set_hl(0, "MiniStatuslineModeOther", { bg = green, fg = background })
    vim.api.nvim_set_hl(0, "MiniStatuslineModeReplace", { bg = orange, fg = background })
    vim.api.nvim_set_hl(0, "MiniStatuslineModeVisual", { bg = yellow, fg = background })
  end,
  group = "Config",
  pattern = "dracula"
})

vim.cmd.colorscheme("dracula")

vim.lsp.config("vtsls", {
  cmd = { 'bunx', "@vtsls/language-server", '--stdio' }
})

vim.lsp.enable("vtsls")

-- The basics.
vim.keymap.set("n", "<Leader><Space>", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader><CR>", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>b", "<Cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<Leader>e", "<Cmd>NnnPicker %:p:h<CR>")
vim.keymap.set("n", "<Leader>g", "<Cmd>G<CR>")

-- Add lines above and below without entering insert mode.
vim.keymap.set("n", "<Leader>o", "]<Space>", { remap = true })
vim.keymap.set("n", "<Leader>O", "[<Space>", { remap = true })

-- Paste from the system clipboa"d.
vim.keymap.set("n", "<Leader>p", '"*p')
vim.keymap.set("n", "<Leader>P", '"*P')
vim.keymap.set("x", "<Leader>p", '"*p')
vim.keymap.set("x", "<Leader>P", '"*P')

-- Yank to system clipboard.
vim.keymap.set("n", "<Leader>y", '"*y')
vim.keymap.set("n", "<Leader>Y", '"*yg_')
vim.keymap.set("x", "<Leader>y", '"*y')

-- Backslash is the same key as forward slash in the Engram layout.
vim.keymap.set({ "n", "v", "o" }, "\\", "?")

-- Reselect visual selection after indenting.
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move vertically by visual line with wrapping enabled.
-- nnoremap j gj
-- nnoremap k gk

-- Keep the cursor centered when gowng through search results.
vim.keymap.set('n', 'n', "nzzzv")
vim.keymap.set('n', 'N', "Nzzzv")

-- Ex mode is rarely useful.
vim.keymap.set('n', 'q', "@")
vim.keymap.set('n', 'Q', "q")

-- Use s for sneak in all modes.
vim.keymap.set('o', 's', '<Plug>Sneak_s', { remap = true })
vim.keymap.set('o', 'S', '<Plug>Sneak_S', { remap = true })
vim.keymap.set('x', 'S', '<Plug>Sneak_S', { remap = true })

-- Better redo.
vim.keymap.set('n', 'U', "<C-r>")

-- Unused y-mappings: yc yd ym yo yp yq yr ys yu yx yz
-- Make Y behave as expected, though don't yank the trailing whitespace.
-- nnoremap Y yg_

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
-- vnoremap y myy`y
-- vnoremap Y myY`y

-- Ctrl-D for <Del> when in middle of line, from rsi.vim.
-- inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
-- cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

-- Highlight on yank.
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 700 })
  end,
  group = "Config",
  pattern = "*",
})

-- Remove search highlighting when the cursor moves off a search result.
vim.api.nvim_create_autocmd('CursorMoved', {
  callback = function ()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function () vim.cmd.nohlsearch() end)
    end
  end,
  group = "Config",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

-- " Unused c-mappings: cd cm co cp cq cr cs cu cx cy cz
-- " cs is used for sneak.
-- " nnoremap <buffer> co <Cmd>LspOutline<CR>
-- " nnoremap <buffer> cpd <Cmd>LspPeekDefinition<CR>
-- " nnoremap <buffer> cpm <Cmd>LspPeekImpl<CR>
-- " nnoremap <buffer> cpr <Cmd>LspPeekReferences<CR>
-- " nnoremap <buffer> cpx <Cmd>LspPeekDeclaration<CR>
-- " nnoremap <buffer> cpy <Cmd>LspPeekTypeDef<CR>
-- nmap <silent> cd <Plug>(coc-definition)
-- nmap <silent> cm <Plug>(coc-implementation)
-- nmap <silent> cn <Plug>(coc-rename)
-- nmap <silent> cq <Plug>(coc-format)
-- nmap <silent> cr <Plug>(coc-references)
-- nmap <silent> cx <Plug>(coc-declaration)
-- nmap <silent> cy <Plug>(coc-type-definition)
-- nmap <silent> cz <Plug>(coc-codeaction-selected)
-- | `lsp_references`             | References                       |
-- | `lsp_definitions`            | Definitions                      |
-- | `lsp_declarations`           | Declarations                     |
-- | `lsp_typedefs`               | Type Definitions                 |
-- | `lsp_implementations`        | Implementations                  |
-- | `lsp_document_symbols`       | Document Symbols                 |
-- | `lsp_workspace_symbols`      | Workspace Symbols                |
-- | `lsp_live_workspace_symbols` | Workspace Symbols (live query)   |
-- | `lsp_incoming_calls`         | Incoming Calls                   |
-- | `lsp_outgoing_calls`         | Outgoing Calls                   |
-- | `lsp_code_actions`           | Code Actions                     |
-- | `lsp_finder`                 | All LSP locations, combined view |
-- | `diagnostics_document`       | Document Diagnostics             |
-- | `diagnostics_workspace`      | Workspace Diagnostics            |
-- | `lsp_document_diagnostics`   | alias to `diagnostics_document`  |
-- | `lsp_workspace_diagnostics`  | alias to `diagnostics_workspace` |
    vim.keymap.set("n", "cd", "<cmd>FzfLua lsp_definitions jump1=true<cr>", { buffer = event.buf })
    vim.keymap.set("n", "cm", "<cmd>FzfLua lsp_implementations jump1=true<cr>", { buffer = event.buf })
    vim.keymap.set("n", "cn", vim.lsp.buf.rename, { buffer = event.buf })
    vim.keymap.set("n", "cpd", "<cmd>FzfLua lsp_definitions jump1=false<cr>", { buffer = event.buf })
    vim.keymap.set("n", "cpm", "<cmd>FzfLua lsp_implementations jump1=false<cr>", { buffer = event.buf })
    vim.keymap.set("n", "cpr", "<cmd>FzfLua lsp_references jump1=false<cr>", { buffer = event.buf })
    vim.keymap.set("n", "cpy", "<cmd>FzfLua lsp_typedefs jump1=false<cr>", { buffer = event.buf })
    vim.keymap.set("n", "cq", vim.lsp.buf.format, { buffer = event.buf })
    vim.keymap.set("n", "cr", "<cmd>FzfLua lsp_references jump1=true<cr>", { buffer = event.buf })
    vim.keymap.set("n", "cy", "<cmd>FzfLua lsp_typedefs jump1=true<cr>", { buffer = event.buf })
    vim.keymap.set("n", "cz", "<cmd>FzfLua lsp_code_actions<cr>", { buffer = event.buf })

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end
  end,
  group = "Config"
})
