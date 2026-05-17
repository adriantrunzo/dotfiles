local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    css = { "oxfmt", "prettier", stop_after_first = true },
    handlebars = { "oxfmt", "prettier", stop_after_first = true },
    javascript = { "oxfmt", "prettier", stop_after_first = true },
    javascriptreact = { "oxfmt", "prettier", stop_after_first = true },
    json = { "oxfmt", "prettier", stop_after_first = true },
    lua = { "stylua" },
    markdown = { "oxfmt", "prettier", stop_after_first = true },
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
