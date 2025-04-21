local ai = require("mini.ai")
local extra = require("mini.extra")

ai.setup({
  custom_textobjects = {
    e = extra.gen_ai_spec.buffer(),
    i = extra.gen_ai_spec.indent(),
    -- Any common matching pairs.
    m = {
      { "%b''", '%b""', "%b``", "%b()", "%b[]", "%b{}", "%b<>" },
      "^.().*().$",
    },
  },
})
