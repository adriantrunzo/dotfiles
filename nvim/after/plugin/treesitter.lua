local treesitter = require("nvim-treesitter")

local common = {
  "css",
  "html",
  "javascript",
  "json",
  "jsonc",
  "lua",
  "python",
  "ruby",
  "terraform",
  "typescript",
  "yaml",
}

local parsers = vim.list_extend({
  "comment",
  "dockerfile",
  "jsx",
  "make",
  "nginx",
  "tsx",
  "vimdoc",
}, common)

local filetypes = vim.list_extend({
  "javascriptreact",
  "typescriptreact",
}, common)

treesitter.install(parsers)

vim.api.nvim_create_autocmd("FileType", {
  pattern = filetypes,
  callback = function()
    vim.treesitter.start()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
