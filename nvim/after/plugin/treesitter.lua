local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
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
