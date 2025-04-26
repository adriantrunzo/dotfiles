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
  root_dir = function(bufnr, on_dir)
    local root_files = {
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs",
      "tailwind.config.ts",
    }

    local buffer_file_name = vim.api.nvim_buf_get_name(bufnr)
    local buffer_file_path = vim.fn.fnamemodify(buffer_file_name, ":h")
    local package_directory = vim.fs.dirname(
      vim.fs.find("package.json", { path = buffer_file_path, upward = true })[1]
    )

    if package_directory then
      for line in io.lines(package_directory .. "/package.json") do
        if line:find("tailwindcss") then
          root_files[#root_files + 1] = "package.json"
          break
        end
      end
    end

    on_dir(
      vim.fs.dirname(
        vim.fs.find(root_files, { path = buffer_file_name, upward = true })[1]
      )
    )
  end,
  settings = {
    tailwindCSS = {
      classFunctions = { "classNames", "clsx", "joinClassNames" },
      validate = true,
    },
  },
  workspace_required = true,
}
