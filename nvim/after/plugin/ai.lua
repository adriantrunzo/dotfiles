local ai = require("mini.ai")

ai.setup({
  custom_textobjects = {
    -- Whole buffer.
    e = function()
      local from = { line = 1, col = 1 }
      local to = {
        line = vim.fn.line("$"),
        col = math.max(vim.fn.getline("$"):len(), 1),
      }
      return { from = from, to = to }
    end,
    -- Any common matching pairs.
    m = {
      { "%b''", '%b""', "%b``", "%b()", "%b[]", "%b{}", "%b<>" },
      "^.().*().$",
    },
  },
})
