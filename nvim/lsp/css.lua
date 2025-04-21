return {
  cmd = {
    "npx",
    "--yes",
    "--package",
    "vscode-langservers-extracted",
    "--",
    "vscode-css-language-server",
    "--stdio",
  },
  filetypes = { "css", "scss", "less" },
  init_options = { provideFormatter = true },
  root_markers = { "package.json" },
  settings = {
    css = { validate = true },
    scss = { validate = true },
    less = { validate = true },
  },
}
