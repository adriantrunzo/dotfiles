return {
  before_init = function(_, config)
    if not config.settings then
      config.settings = {}
    end
    if not config.settings.editor then
      config.settings.editor = {}
    end
    if not config.settings.editor.tabSize then
      config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
    end
  end,
  cmd = { "npx", "--yes", "@tailwindcss/language-server", "--stdio" },
  filetypes = {
    "css",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "markdown",
    "mdx",
    "sass",
    "scss",
    "typescript",
    "typescriptreact",
  },
  settings = {
    tailwindCSS = {
      classFunctions = { "classNames", "clsx", "joinClassNames" },
      validate = true,
    },
  },
  root_markers = {
    "tailwind.config.js",
    "tailwind.config.cjs",
    "tailwind.config.mjs",
    "tailwind.config.ts",
  },
  workspace_required = true,
}
