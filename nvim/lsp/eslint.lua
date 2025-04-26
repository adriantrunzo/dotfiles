vim.lsp.config("eslint", {
  --- @diagnostic disable-next-line: unused-local
  before_init = function(params, config)
    local root_dir = config.root_dir

    if root_dir then
      config.settings = config.settings or {}
      config.settings.workspaceFolder = {
        uri = root_dir,
        name = vim.fn.fnamemodify(root_dir, ":t"),
      }

      local flat_config_files = {
        "eslint.config.js",
        "eslint.config.mjs",
        "eslint.config.cjs",
        "eslint.config.ts",
        "eslint.config.mts",
        "eslint.config.cts",
      }

      for _, file in ipairs(flat_config_files) do
        if vim.fn.filereadable(root_dir .. "/" .. file) == 1 then
          config.settings.experimental = config.settings.experimental or {}
          config.settings.experimental.useFlatConfig = true
          break
        end
      end
    end
  end,
  cmd = {
    "npx",
    "--yes",
    "--package",
    "vscode-langservers-extracted",
    "--",
    "vscode-eslint-language-server",
    "--stdio",
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "svelte",
    "astro",
    "graphql",
  },
  handlers = {
    ["eslint/openDoc"] = function(_, result)
      if result then
        vim.ui.open(result.url)
      end
      return {}
    end,
    ["eslint/confirmESLintExecution"] = function(_, result)
      if not result then
        return
      end
      return 4
    end,
    ["eslint/probeFailed"] = function()
      vim.notify("[lspconfig] ESLint probe failed.", vim.log.levels.WARN)
      return {}
    end,
    ["eslint/noLibrary"] = function()
      vim.notify(
        "[lspconfig] Unable to find ESLint library.",
        vim.log.levels.WARN
      )
      return {}
    end,
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_create_user_command("LspEslintFixAll", function()
      client:exec_cmd({
        title = "Fix all Eslint errors for current buffer",
        command = "eslint.applyAllFixes",
        arguments = {
          {
            uri = vim.uri_from_bufnr(bufnr),
            version = vim.lsp.util.buf_versions[bufnr],
          },
        },
      }, { bufnr = bufnr })
    end, {})

    vim.api.nvim_create_autocmd("LspEslintFixAll", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
  root_markers = {
    ".eslintrc",
    ".eslintrc.js",
    ".eslintrc.cjs",
    ".eslintrc.yaml",
    ".eslintrc.yml",
    ".eslintrc.json",
    "eslint.config.js",
    "eslint.config.mjs",
    "eslint.config.cjs",
    "eslint.config.ts",
    "eslint.config.mts",
    "eslint.config.cts",
  },
  settings = {
    codeAction = {
      disableRuleComment = { enable = true, location = "separateLine" },
      showDocumentation = { enable = true },
    },
    codeActionOnSave = { enable = false, mode = "all" },
    experimental = { useFlatConfig = false },
    format = false,
    nodePath = "",
    onIgnoredFiles = "off",
    options = {},
    packageManager = nil,
    problems = { shortenToSingleLine = false },
    quiet = false,
    rulesCustomizations = {},
    run = "onType",
    useESLintClass = false,
    validate = "on",
    workingDirectory = { mode = "location" },
  },
})
