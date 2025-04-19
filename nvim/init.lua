-- Autocommand group to use throughout this configuration file.
vim.api.nvim_create_augroup("Config", { clear = true })

-- Use space for leader.
vim.g.mapleader = vim.keycode("<space>")

-- Highlight the column after textwidth.
vim.opt.colorcolumn = { "+1" }

-- Expand tabs to spaces in insert mode.
vim.opt.expandtab = true

-- Use conform for gq.
vim.opt.formatexpr = 'v:lua.require"conform".formatexpr()'

-- Ignore case when searching.
vim.opt.ignorecase = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.shiftwidth = 2
vim.opt.shortmess:append({ I = true })
vim.opt.showbreak = "↪"
vim.opt.showmode = false
vim.opt.signcolumn = "yes:2"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.splitbelow = true
vim.opt.splitkeep = "topline"
vim.opt.splitright = true
vim.opt.textwidth = 80
vim.opt.title = true
vim.opt.undofile = true
vim.opt.wildoptions = { fuzzy = true, pum = true }

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
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

    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineDevInfo",
      { bg = comment, fg = foreground }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineFileInfo",
      { bg = comment, fg = foreground }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineFilename",
      { bg = selection, fg = foreground }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineInactive",
      { bg = selection, fg = foreground }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineModeCommand",
      { bg = purple, fg = background }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineModeInsert",
      { bg = green, fg = background }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineModeNormal",
      { bg = purple, fg = background }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineModeOther",
      { bg = green, fg = background }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineModeReplace",
      { bg = orange, fg = background }
    )
    vim.api.nvim_set_hl(
      0,
      "MiniStatuslineModeVisual",
      { bg = yellow, fg = background }
    )
  end,
  group = "Config",
  pattern = "dracula",
})

vim.cmd.colorscheme("dracula")

vim.lsp.enable("css")
vim.lsp.enable("html")
vim.lsp.enable("json")
vim.lsp.enable("eslint")
vim.lsp.enable("lua")
vim.lsp.enable("vtsls")

-- The basics.
vim.keymap.set("n", "<leader><space>", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<leader><cr>", "<cmd>FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>b", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>c", "<cmd>close<cr>")
vim.keymap.set("n", "<leader>d", "<cmd>bdelete<cr>")
vim.keymap.set("n", "<leader>e", "<cmd>NnnPicker %:p:h<cr>")
vim.keymap.set("n", "<leader>g", "<cmd>Git<cr>")
vim.keymap.set("n", "<leader>s", "<cmd>update<cr>")
vim.keymap.set("n", "<leader>x", "<cmd>exit<cr>")

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
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Ex mode is rarely useful.
vim.keymap.set("n", "q", "@")
vim.keymap.set("n", "Q", "q")

-- Better redo.
vim.keymap.set("n", "U", "<C-r>")

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

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    -- " Unused c-mappings: cd cm co cp cq cr cs cu cx cy cz
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
    vim.keymap.set(
      "n",
      "cd",
      "<cmd>FzfLua lsp_definitions jump1=true<cr>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cm",
      "<cmd>FzfLua lsp_implementations jump1=true<cr>",
      { buffer = event.buf }
    )
    vim.keymap.set("n", "cn", vim.lsp.buf.rename, { buffer = event.buf })
    vim.keymap.set(
      "n",
      "cpd",
      "<cmd>FzfLua lsp_definitions jump1=false<cr>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cpm",
      "<cmd>FzfLua lsp_implementations jump1=false<cr>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cpr",
      "<cmd>FzfLua lsp_references jump1=false<cr>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cpy",
      "<cmd>FzfLua lsp_typedefs jump1=false<cr>",
      { buffer = event.buf }
    )
    vim.keymap.set("n", "cq", vim.lsp.buf.format, { buffer = event.buf })
    vim.keymap.set(
      "n",
      "cr",
      "<cmd>FzfLua lsp_references jump1=true<cr>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cy",
      "<cmd>FzfLua lsp_typedefs jump1=true<cr>",
      { buffer = event.buf }
    )
    vim.keymap.set(
      "n",
      "cz",
      "<cmd>FzfLua lsp_code_actions<cr>",
      { buffer = event.buf }
    )

    -- if client:supports_method("textDocument/completion") then
    --   vim.lsp.completion.enable(
    --     true,
    --     client.id,
    --     event.buf,
    --     { autotrigger = true }
    --   )
    -- end
  end,
  group = "Config",
})
