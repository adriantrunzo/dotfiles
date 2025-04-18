local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    css = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
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
