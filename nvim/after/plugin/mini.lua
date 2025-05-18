local mini_ai = require("mini.ai")
local mini_bracketed = require("mini.bracketed")
local mini_completion = require("mini.completion")
local mini_diff = require("mini.diff")
local mini_extra = require("mini.extra")
local mini_keymap = require("mini.keymap")
local mini_move = require("mini.move")
local mini_operators = require("mini.operators")
local mini_pairs = require("mini.pairs")
local mini_snippets = require("mini.snippets")
local mini_statusline = require("mini.statusline")
local mini_surround = require("mini.surround")

mini_ai.setup({
  custom_textobjects = {
    e = mini_extra.gen_ai_spec.buffer(),
    i = mini_extra.gen_ai_spec.indent(),
    -- Any common matching pairs.
    m = {
      { "%b''", '%b""', "%b``", "%b()", "%b[]", "%b{}", "%b<>" },
      "^.().*().$",
    },
  },
})

mini_bracketed.setup()

mini_completion.setup()

mini_diff.setup({
  view = {
    style = "sign",
  },
})

mini_move.setup()

mini_operators.setup({
  evaluate = {
    prefix = "",
  },
  exchange = {
    prefix = "yx",
  },
  multiply = {
    prefix = "ym",
  },
  replace = {
    prefix = "yp",
  },
  sort = {
    prefix = "gs",
  },
})

vim.keymap.set("n", "yP", "ypg_", { remap = true })
vim.keymap.set("n", "<Leader>yp", '"*yp', { remap = true })
vim.keymap.set("n", "<Leader>yP", '"*ypg_', { remap = true })

mini_pairs.setup()

mini_snippets.setup()

mini_statusline.setup({
  content = {
    active = function()
      local mode, mode_hl = MiniStatusline.section_mode({})

      local buffer_type = vim.bo.buftype
      local file_format = vim.bo.fileformat
      local file_encoding = vim.bo.fileencoding or vim.bo.encoding

      local git_diff = vim.b.minidiff_summary_string or ""
      local git_status = vim.fn.FugitiveStatusline() or ""
      local git_modifier = (git_diff ~= "") and "!" or ""
      local git_branch = string.match(git_status, "Git%((.+)%)") or ""
      local ticket = string.match(git_branch, "sc%-%d+")

      local is_tiny = MiniStatusline.is_truncated(100)
      local is_small = MiniStatusline.is_truncated(120)
      local is_terminal = buffer_type == "terminal"
      local is_special_buffer = buffer_type ~= ""

      local vcs = (ticket or git_branch) .. git_modifier
      local diagnostics = is_tiny and ""
        or MiniStatusline.section_diagnostics({
          icon = "",
          signs = {
            ERROR = "%#DiagnosticError#●%#DraculaFg# ",
            WARN = "%#DiagnosticWarn#●%#DraculaFg# ",
            INFO = "%#DraculaYellow#●%#DraculaFg# ",
            HINT = "%#DiagnosticInfo#●%#DraculaFg# ",
          },
        })
      local file_info = (is_small or is_special_buffer) and ""
        or string.format("%s[%s]", file_encoding, file_format)
      local file_name = is_terminal and "%t"
        or (is_small and "%f%m%r" or "%F%m%r")
      local file_type = vim.bo.filetype
      local location = "%l:%v"

      return MiniStatusline.combine_groups({
        { hl = mode_hl, strings = { mode } },
        { hl = "MiniStatuslineDevinfo", strings = { vcs } },
        "%<", -- Mark general truncate point
        { hl = "MiniStatuslineFilename", strings = { file_name } },
        "%=", -- End left alignment
        { strings = { diagnostics, file_type } },
        { hl = "MiniStatuslineFileinfo", strings = { file_info } },
        { hl = mode_hl, strings = { location } },
      })
    end,
  },
  use_icons = false,
})

mini_surround.setup({
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

mini_keymap.map_multistep(
  "i",
  "<Tab>",
  { "minisnippets_next", "minisnippets_expand", "pmenu_next" }
)
mini_keymap.map_multistep("i", "<S-Tab>", { "minisnippets_prev", "pmenu_prev" })
mini_keymap.map_multistep("i", "<CR>", { "pmenu_accept", "minipairs_cr" })
mini_keymap.map_multistep("i", "<BS>", { "minipairs_bs" })
