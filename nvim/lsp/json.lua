return {
  cmd = {
    "npx",
    "--yes",
    "--package",
    "vscode-langservers-extracted",
    "--",
    "vscode-json-language-server",
    "--stdio",
  },
  filetypes = { "json", "jsonc" },
  init_options = {
    provideFormatter = true,
  },
  root_markers = { "package.json" },
}
