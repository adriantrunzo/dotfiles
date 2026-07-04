-- Use space for leader.
vim.g.mapleader = vim.keycode("<Space>")

-- Disable default mappings in the following plugins.
vim.g.sandwich_no_default_key_mappings = 1

-- Use the sneak label mode for faster jumping.
vim.g["sneak#label"] = 1

-- Use vim-matchup instead of matchit.
vim.g.loaded_matchit = 1

-- Don't show offscreen matches as they cause odd statusline issues.
vim.g.matchup_matchparen_offscreen = {}

-- Highlight the column after textwidth.
vim.opt.colorcolumn = { "+1" }

-- More intuitive insert completion.
vim.opt.completeopt = { "fuzzy", "menuone", "noinsert" }

-- Expand tabs to spaces in insert mode.
vim.opt.expandtab = true

-- Allow project configuration files.
vim.opt.exrc = true

-- Use conform for gq.
vim.opt.formatexpr = 'v:lua.require"conform".formatexpr()'

-- Ignore case when searching.
vim.opt.ignorecase = true

-- Disable mouse support.
vim.opt.mouse = ""

-- Show line numbers.
vim.opt.number = true

-- Make the line numbers relative.
vim.opt.relativenumber = true

-- Always show lines above and below cursor when scrolling.
vim.opt.scrolloff = 5

-- Use two spaces when indenting.
vim.opt.shiftwidth = 2

-- Don't show completion menu messages.
vim.opt.shortmess:append({ c = true })

-- Don't show the intro message when starting vim.
vim.opt.shortmess:append({ I = true })

-- Show a symbol for wrapped lines.
vim.opt.showbreak = "↪"

-- Don't show the mode as mini.statusline displays it for us.
vim.opt.showmode = false

-- Always show enough space for two signs.
vim.opt.signcolumn = "yes:2"

-- Make search case-sensitive if capital letters are used.
vim.opt.smartcase = true

-- Use two spaces for the tab key.
vim.opt.softtabstop = 2

-- Open horizontal splits below.
vim.opt.splitbelow = true

-- Don't shift the buffer when splitting below.
vim.opt.splitkeep = "topline"

-- Open vertical splits to the right.
vim.opt.splitright = true

-- Break text after 100 characters.
vim.opt.textwidth = 100

-- Persistent undo.
vim.opt.undofile = true

-- Default to rounded float borders.
vim.opt.winborder = "rounded"

-- Configure diagnostics.
vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "●",
      [vim.diagnostic.severity.HINT] = "●",
      [vim.diagnostic.severity.INFO] = "●",
      [vim.diagnostic.severity.WARN] = "●",
    },
  },
})

-- Autocommand group to use throughout this configuration file.
vim.api.nvim_create_augroup("Config", { clear = true })

-- Restore default <CR> mapping in command-line window.
-- https://stackoverflow.com/a/16360104
vim.api.nvim_create_autocmd("CmdWinEnter", {
  callback = function(event)
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = event.buf })
  end,
  group = "Config",
  pattern = "*",
})

-- Restore default <CR> mapping in location and quickfix windows.
-- https://stackoverflow.com/a/16360104
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function(event)
    vim.keymap.set("n", "<CR>", "<CR>", { buffer = event.buf })
  end,
  group = "Config",
  pattern = "quickfix",
})

-- Highlight on yank.
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank({ higroup = "IncSearch", timeout = 500 })
  end,
  group = "Config",
  pattern = "*",
})

-- Remove search highlighting when the cursor moves off a search result.
vim.api.nvim_create_autocmd("CursorMoved", {
  callback = function()
    if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
      vim.schedule(function()
        vim.cmd.nohlsearch()
      end)
    end
  end,
  group = "Config",
})

-- Open the quickfix window automatically.
-- https://noahfrederick.com/log/vim-streamlining-grep
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd.cwindow()
  end,
  group = "Config",
  pattern = "[^l]*",
})

-- Open the location window automatically.
-- https://noahfrederick.com/log/vim-streamlining-grep
vim.api.nvim_create_autocmd("QuickFixCmdPost", {
  callback = function()
    vim.cmd.lwindow()
  end,
  group = "Config",
  pattern = "l*",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local buffer = event.buf
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
    local methods = vim.lsp.protocol.Methods

    vim.api.nvim_create_augroup("ConfigLsp", { clear = false })

    if client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = buffer,
        command = "LspEslintFixAll",
        group = "ConfigLsp",
      })
    end

    if client:supports_method(methods.textDocument_documentHighlight) then
      vim.api.nvim_create_autocmd({ "CursorHold", "InsertLeave" }, {
        buffer = buffer,
        callback = vim.lsp.buf.document_highlight,
        group = "ConfigLsp",
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "InsertEnter", "BufLeave" }, {
        buffer = buffer,
        callback = vim.lsp.buf.clear_references,
        group = "ConfigLsp",
      })
    end

    -- " Unused c-mappings: cd cm co cp cq cr cs cu cx cy cz
    vim.keymap.set("n", "cd", "<Cmd>Pick lsp scope='definition'<CR>", { buffer = event.buf })
    vim.keymap.set("n", "cm", "<Cmd>Pick lsp scope='implementation'<CR>", { buffer = event.buf })
    vim.keymap.set("n", "cn", vim.lsp.buf.rename, { buffer = event.buf })
    vim.keymap.set("n", "cq", vim.lsp.buf.format, { buffer = event.buf })
    vim.keymap.set("n", "cr", "<Cmd>Pick lsp scope='references'<CR>", { buffer = event.buf })
    vim.keymap.set("n", "cy", "<Cmd>Pick lsp scope='type_definition'<CR>", { buffer = event.buf })
    vim.keymap.set("n", "cz", vim.lsp.buf.code_action, { buffer = event.buf })
  end,
  group = "Config",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.number = true
    vim.opt_local.relativenumber = true
  end,
  group = "Config",
  pattern = "help",
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
  group = "Config",
  pattern = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "lua",
    "python",
    "ruby",
    "terraform",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(event)
    local active, kind, name = event.data.active, event.data.kind, event.data.spec.name

    if name == "treesitter" and kind == "update" then
      if not active then
        vim.cmd.packadd("treesitter")
      end

      vim.cmd("TSUpdate")
    end
  end,
  group = "Config",
})

vim.pack.add({
  { name = "conform", src = "https://github.com/stevearc/conform.nvim" },
  { name = "dracula", src = "https://github.com/dracula/vim" },
  { name = "fugitive", src = "https://github.com/tpope/vim-fugitive" },
  { name = "lspconfig", src = "https://github.com/neovim/nvim-lspconfig" },
  { name = "matchup", src = "https://github.com/andymass/vim-matchup" },
  { name = "mini", src = "https://github.com/nvim-mini/mini.nvim" },
  { name = "rsi", src = "https://github.com/tpope/vim-rsi" },
  { name = "sandwich", src = "https://github.com/machakann/vim-sandwich" },
  { name = "sneak", src = "https://github.com/justinmk/vim-sneak" },
  { name = "treesitter", src = "https://github.com/nvim-treesitter/nvim-treesitter" },
})

vim.cmd.colorscheme("dracula")

-- nvim-treesitter stores queries in the runtime/, which packadd does not automatically add to the
-- runtime path.
vim.opt.runtimepath:append(vim.pack.get({ "treesitter" })[1].path .. "/runtime")

local conform = require("conform")
local mini_ai = require("mini.ai")
local mini_bracketed = require("mini.bracketed")
local mini_cmdline = require("mini.cmdline")
local mini_completion = require("mini.completion")
local mini_diff = require("mini.diff")
local mini_extra = require("mini.extra")
local mini_files = require("mini.files")
local mini_indentscope = require("mini.indentscope")
local mini_keymap = require("mini.keymap")
local mini_move = require("mini.move")
local mini_operators = require("mini.operators")
local mini_pairs = require("mini.pairs")
local mini_pick = require("mini.pick")
local mini_statusline = require("mini.statusline")
local mini_trailspace = require("mini.trailspace")
local treesitter = require("nvim-treesitter")

conform.setup({
  formatters_by_ft = {
    css = { "oxfmt", "prettier", stop_after_first = true },
    handlebars = { "oxfmt", "prettier", stop_after_first = true },
    javascript = { "oxfmt", "prettier", stop_after_first = true },
    javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
    json = { "oxfmt", "prettier", stop_after_first = true },
    lua = { "stylua" },
    markdown = { "oxfmt", "prettier", stop_after_first = true },
    python = {
      "ruff_fix",
      "ruff_format",
      "ruff_organize_imports",
    },
    scss = { "oxfmt", "prettier", stop_after_first = true },
    typescript = { "oxfmt", "prettier", stop_after_first = true },
    typescriptreact = { "oxfmt", "prettier", stop_after_first = true },
    yaml = { "oxfmt", "prettier", stop_after_first = true },
    ["_"] = { "trim_whitespace", "trim_newlines" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})

mini_ai.setup({
  custom_textobjects = {
    e = mini_extra.gen_ai_spec.buffer(),
  },
})

mini_bracketed.setup()
mini_completion.setup()
mini_cmdline.setup()

mini_diff.setup({
  view = {
    style = "sign",
  },
})

mini_extra.setup()

mini_files.setup({
  mappings = {
    close = "<Esc>",
    go_in_plus = "<CR>",
    go_out = "",
    go_out_plus = "h",
  },
})

mini_indentscope.setup({
  draw = {
    animation = mini_indentscope.gen_animation.none(),
  },
  options = {
    indent_at_cursor = false,
  },
})

mini_move.setup()

mini_operators.setup({
  evaluate = {
    prefix = "",
  },
  exchange = {
    prefix = "yx",
  },
  multiply = {
    prefix = "",
  },
  replace = {
    prefix = "yp",
  },
  sort = {
    prefix = "gs",
  },
})

mini_pairs.setup()

mini_pick.setup({
  window = {
    config = function()
      local height = math.floor(0.75 * vim.o.lines)
      local width = math.floor(0.90 * vim.o.columns)

      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end,
  },
})

mini_statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({})

      local buffer_type = vim.bo.buftype
      local file_format = vim.bo.fileformat
      local file_encoding = vim.bo.fileencoding or vim.bo.encoding

      local git_diff = vim.b.minidiff_summary_string or ""
      local git_status = vim.fn.FugitiveStatusline() or ""
      local git_modifier = (git_diff ~= "") and "!" or ""
      local git_branch = string.match(git_status, "Git%((.+)%)") or ""
      local ticket = string.match(git_branch, "sc%-%d+")

      local is_tiny = MiniStatusline.is_truncated(100)
      local is_small = MiniStatusline.is_truncated(120)
      local is_terminal = buffer_type == "terminal"
      local is_special_buffer = buffer_type ~= ""

      local vcs = (ticket or git_branch) .. git_modifier
      local diagnostics = is_tiny and ""
        or MiniStatusline.section_diagnostics({
          icon = "",
          signs = {
            ERROR = "%#DiagnosticError#●%#DraculaFg# ",
            WARN = "%#DiagnosticWarn#●%#DraculaFg# ",
            INFO = "%#DraculaYellow#●%#DraculaFg# ",
            HINT = "%#DiagnosticInfo#●%#DraculaFg# ",
          },
        })
      local file_info = (is_small or is_special_buffer) and ""
        or string.format("%s[%s]", file_encoding, file_format)
      local file_name = is_terminal and "%t" or (is_small and "%f%m%r" or "%F%m%r")
      local file_type = vim.bo.filetype
      local location = "%l:%v"

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { vcs } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { file_name } },
        "%=", -- End left alignment
        { strings = { diagnostics, file_type } },
        { hl = "MiniStatuslineFileinfo", strings = { file_info } },
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
  use_icons = false,
})

mini_trailspace.setup()

treesitter.install({
  "comment",
  "css",
  "dockerfile",
  "html",
  "javascript",
  "json",
  "jsx",
  "lua",
  "make",
  "nginx",
  "python",
  "ruby",
  "terraform",
  "tsx",
  "typescript",
  "vimdoc",
  "yaml",
})

vim.lsp.config("cssls", {
  cmd = {
    "npx",
    "--package",
    "vscode-langservers-extracted",
    "--yes",
    "--",
    "vscode-css-language-server",
    "--stdio",
  },
})

vim.lsp.config("html", {
  cmd = {
    "npx",
    "--package",
    "vscode-langservers-extracted",
    "--yes",
    "--",
    "vscode-html-language-server",
    "--stdio",
  },
})

vim.lsp.config("jsonls", {
  cmd = {
    "npx",
    "--package",
    "vscode-langservers-extracted",
    "--yes",
    "--",
    "vscode-json-language-server",
    "--stdio",
  },
})

vim.lsp.config("eslint", {
  cmd = {
    "npx",
    "--package",
    "vscode-langservers-extracted",
    "--yes",
    "--",
    "vscode-eslint-language-server",
    "--stdio",
  },
})

vim.lsp.config("tailwindcss", {
  cmd = {
    "npx",
    "--package",
    "@tailwindcss/language-server",
    "--yes",
    "--",
    "tailwindcss-language-server",
    "--stdio",
  },
})

vim.lsp.config("vtsls", {
  cmd = { "npx", "--yes", "--", "@vtsls/language-server", "--stdio" },
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
  },
})

vim.lsp.enable("cssls")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("eslint")
vim.lsp.enable("lua_ls")
vim.lsp.enable("ruff")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("ty")
vim.lsp.enable("vtsls")

-- Sandwich text-objects for matching characters.
vim.keymap.set({ "x", "o" }, "am", "<Plug>(textobj-sandwich-auto-a)")
vim.keymap.set({ "x", "o" }, "im", "<Plug>(textobj-sandwich-auto-i)")

-- The basics.
vim.keymap.set("n", "<Leader><Space>", "<Cmd>Pick files<CR>")
vim.keymap.set("n", "<Leader>b", "<Cmd>Pick buffers<CR>")
vim.keymap.set("n", "<Leader>c", "<Cmd>close<CR>")
vim.keymap.set("n", "<Leader>d", "<Cmd>bdelete<CR>")
vim.keymap.set("n", "<Leader>e", "<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>")
vim.keymap.set("n", "<Leader>f", "<Cmd>Pick grep_live<CR>")
vim.keymap.set("n", "<Leader>g", "<Cmd>Git<CR>")
vim.keymap.set("n", "<Leader>s", "<Cmd>update<CR>")
vim.keymap.set("n", "<Leader>x", "<Cmd>exit<CR>")
vim.keymap.set("n", "<Leader>yp", '"*yp', { remap = true })
vim.keymap.set("n", "<Leader>yP", '"*ypg_', { remap = true })

mini_keymap.map_multistep(
  "i",
  "<Tab>",
  { "minisnippets_next", "minisnippets_expand", "pmenu_next" }
)
mini_keymap.map_multistep("i", "<S-Tab>", { "minisnippets_prev", "pmenu_prev" })
mini_keymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
mini_keymap.map_multistep("i", "<BS>", { "minipairs_bs" })

-- Thumb clusters on Advantage keyboard.
vim.keymap.set("n", "<CR>", "<Cmd>update<CR>")
vim.keymap.set("n", "<S-CR>", "<Cmd>exit<CR>")
vim.keymap.set("n", "<Backspace>", "<Cmd>bdelete<CR>")
vim.keymap.set("n", "<S-Backspace>", "<Cmd>quit<cr>")

-- Add lines above and below without entering insert mode.
vim.keymap.set("n", "<Leader>o", "]<Space>", { remap = true })
vim.keymap.set("n", "<Leader>O", "[<Space>", { remap = true })

-- Paste from the system clipboard.
vim.keymap.set({ "n", "x" }, "<Leader>p", '"*p')
vim.keymap.set({ "n", "x" }, "<Leader>P", '"*P')

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
-- https://vi.stackexchange.com/a/37629
vim.keymap.set("n", "j", "&wrap && v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "&wrap && v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Use "m" for matches and moves.
vim.keymap.set({ "n", "x", "o" }, "m", "<Nop>")
vim.keymap.set({ "n", "x", "o" }, "ma", "<Plug>(sandwich-add)", { silent = true })
vim.keymap.set({ "n", "x" }, "md", "<Plug>(sandwich-delete)", { silent = true })
vim.keymap.set("n", "mdd", "<Plug>(sandwich-delete-auto)", { silent = true })
vim.keymap.set({ "n", "x" }, "mr", "<Plug>(sandwich-replace)", { silent = true })
vim.keymap.set("n", "mrr", "<Plug>(sandwich-replace-auto)", { silent = true })

-- Keep the cursor centered when gowng through search results.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Ex mode is rarely useful.
vim.keymap.set({ "n", "v" }, "q", "@")
vim.keymap.set({ "n", "v" }, "Q", "q")

-- Use s for sneak in all modes.
vim.keymap.set("o", "s", "<Plug>Sneak_s")
vim.keymap.set({ "o", "x" }, "S", "<Plug>Sneak_S")

-- Better redo.
vim.keymap.set("n", "U", "<C-r><Cmd>lua MiniBracketed.register_undo_state()<CR>")

vim.keymap.set("n", "yP", "ypg_", { remap = true })

-- Unused y-mappings: yc yd ym yo yp yq yr ys yu yx yz
-- Make Y behave as expected, though don't yank the trailing whitespace.
vim.keymap.set("n", "Y", "yg_")

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")
