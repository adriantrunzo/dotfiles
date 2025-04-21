return {
  cmd = {
    "npx",
    "--yes",
    "--package",
    "vscode-langservers-extracted",
    "--",
    "vscode-html-language-server",
    "--stdio",
  },
  filetypes = { "html", "templ" },
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { "html", "css", "javascript" },
  },
  root_markers = { "package.json" },
  settings = {},
}
