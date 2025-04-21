local surround = require("mini.surround")

surround.setup({
  custom_surroundings = {
    -- Replicate the <Plug>(sandwich-delete-auto) and
    -- <Plug>(sandwich-replace-auto) mappings from vim-sandwich so you can
    -- easily delete the nearest balanced surroundings without having to think
    -- about which keys to press.
    m = {
      input = {
        { "%b''", '%b""', "%b``", "%b()", "%b[]", "%b{}", "%b<>" },
        "^.().*().$",
      },
    },
  },
  mappings = {
    add = "ma",
    delete = "md",
    find = "mf",
    find_left = "mF",
    highlight = "mh",
    replace = "mr",
    update_n_lines = "mn",
  },
})
