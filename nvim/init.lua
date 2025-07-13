-- Autocommand group to use throughout this configuration file.
vim.api.nvim_create_augroup("Config", { clear = true })

-- Use space for leader.
vim.g.mapleader = vim.keycode("<Space>")

-- Use the sneak label mode for faster jumping.
vim.g["sneak#label"] = 1

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

-- Break text after 80 characters.
vim.opt.textwidth = 80

-- Persistent undo.
vim.opt.undofile = true

-- Don't automatically select a wildmenu option. Sort buffers by last used.
vim.opt.wildmode = { "noselect:lastused", "full" }

-- Use fuzzy matching and the pum for the wildmenu.
vim.opt.wildoptions = { "fuzzy", "pum" }

-- Default to rounded float borders.
vim.opt.winborder = "rounded"

-- Allow customizing a color scheme using the "after/colors" directory.
-- https://vi.stackexchange.com/a/24847
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.cmd.runtime("after/colors/" .. vim.fn.expand("<amatch>") .. ".lua")
  end,
  group = "Config",
  pattern = "*",
})

-- Use the Dracula color scheme.
vim.cmd.colorscheme("dracula")

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
  virtual_lines = true,
})

-- Configure language servers.
vim.lsp.config("cssls", {
  cmd = {
    "npx",
    "--yes",
    "--package",
    "vscode-langservers-extracted",
    "--",
    "vscode-css-language-server",
    "--stdio",
  },
})

vim.lsp.config("html", {
  cmd = {
    "npx",
    "--yes",
    "--package",
    "vscode-langservers-extracted",
    "--",
    "vscode-html-language-server",
    "--stdio",
  },
})

vim.lsp.config("jsonls", {
  cmd = {
    "npx",
    "--yes",
    "--package",
    "vscode-langservers-extracted",
    "--",
    "vscode-json-language-server",
    "--stdio",
  },
})

vim.lsp.config("eslint", {
  cmd = {
    "npx",
    "--yes",
    "--package",
    "vscode-langservers-extracted",
    "--",
    "vscode-eslint-language-server",
    "--stdio",
  },
})

vim.lsp.config("tailwindcss", {
  cmd = {
    "npx",
    "--yes",
    "@tailwindcss/language-server",
    "--stdio",
  },
})

vim.lsp.config("vtsls", {
  cmd = { "npx", "--yes", "@vtsls/language-server", "--stdio" },
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

-- Enable LSP servers.
vim.lsp.enable("cssls")
vim.lsp.enable("html")
vim.lsp.enable("jsonls")
vim.lsp.enable("eslint")
vim.lsp.enable("lua_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("vtsls")

-- The basics.
vim.keymap.set("n", "<Leader><Space>", "<Cmd>FzfLua files<CR>")
vim.keymap.set("n", "<Leader>b", "<Cmd>FzfLua buffers<CR>")
vim.keymap.set("n", "<Leader>c", "<Cmd>close<CR>")
vim.keymap.set("n", "<Leader>d", "<Cmd>bdelete<CR>")
vim.keymap.set("n", "<Leader>e", "<Cmd>Oil<CR>")
vim.keymap.set("n", "<Leader>ff", "<Cmd>FzfLua live_grep<CR>")
vim.keymap.set("n", "<Leader>fw", "<Cmd>FzfLua grep_cword<CR>")
vim.keymap.set("n", "<Leader>fW", "<Cmd>FzfLua grep_cWORD<CR>")
vim.keymap.set("v", "<Leader>f", "<Cmd>FzfLua grep_visual<CR>")
vim.keymap.set("n", "<Leader>g", "<Cmd>Git<CR>")
vim.keymap.set("n", "<Leader>s", "<Cmd>update<CR>")
vim.keymap.set("n", "<Leader>x", "<Cmd>exit<CR>")

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
vim.keymap.set({ "n", "x" }, "m", "<Nop>")

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
vim.keymap.set(
  "n",
  "U",
  "<C-r><Cmd>lua MiniBracketed.register_undo_state()<CR>"
)

-- Unused y-mappings: yc yd ym yo yp yq yr ys yu yx yz
-- Make Y behave as expected, though don't yank the trailing whitespace.
vim.keymap.set("n", "Y", "yg_")

-- Maintain the cursor position when yanking a visual selection.
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
vim.keymap.set("v", "y", "myy`y")
vim.keymap.set("v", "Y", "myY`y")

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
      vim.api.nvim_create_autocmd(
        { "CursorMoved", "InsertEnter", "BufLeave" },
        {
          buffer = buffer,
          callback = vim.lsp.buf.clear_references,
          group = "ConfigLsp",
        }
      )
    end

    -- " Unused c-mappings: cd cm co cp cq cr cs cu cx cy cz
    -- " nnoremap <buffer> co <Cmd>LspOutline<CR>
    -- " nnoremap <buffer> cpx <Cmd>LspPeekDeclaration<CR>
    -- " nnoremap <buffer> cpy <Cmd>LspPeekTypeDef<CR>
    -- nmap <silent> cq <Plug>(coc-format)
    -- nmap <silent> cx <Plug>(coc-declaration)
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
    vim.keymap.set(
      "n",
      "cd",
      "<Cmd>FzfLua lsp_definitions jump1=true<CR>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cm",
      "<Cmd>FzfLua lsp_implementations jump1=true<CR>",
      { buffer = event.buf }
    )
    vim.keymap.set("n", "cn", vim.lsp.buf.rename, { buffer = event.buf })
    vim.keymap.set(
      "n",
      "cpd",
      "<Cmd>FzfLua lsp_definitions jump1=false<CR>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cpm",
      "<Cmd>FzfLua lsp_implementations jump1=false<CR>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cpr",
      "<Cmd>FzfLua lsp_references jump1=false<CR>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cpy",
      "<Cmd>FzfLua lsp_typedefs jump1=false<CR>",
      { buffer = event.buf }
    )
    vim.keymap.set("n", "cq", vim.lsp.buf.format, { buffer = event.buf })
    vim.keymap.set(
      "n",
      "cr",
      "<Cmd>FzfLua lsp_references jump1=true<CR>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cy",
      "<Cmd>FzfLua lsp_typedefs jump1=true<CR>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cz",
      "<Cmd>FzfLua lsp_code_actions<CR>",
      { buffer = event.buf }
    )
  end,
  group = "Config",
})
