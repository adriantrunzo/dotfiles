local statusline = require("mini.statusline")

statusline.setup({
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
