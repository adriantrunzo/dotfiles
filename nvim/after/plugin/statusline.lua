local statusline = require("mini.statusline")

local function get_statusline_git_string()
  if not MiniStatusline.is_truncated(40) then
    local git_status = vim.fn.FugitiveStatusline()

    if git_status ~= "" then
      local git_diff = vim.b.minidiff_summary_string
      local git_modifier = (git_diff ~= nil and git_diff ~= "") and "!" or ""
      local git_branch = string.match(git_status, "Git%((.+)%)")

      if git_branch ~= nil then
        local ticket = string.match(git_branch, "sc%-%d+")
        return (ticket ~= nil and ticket or git_branch) .. git_modifier
      end
    end
  end

  return ''
end

local function get_statusline_filetype_string()
  return vim.bo.filetype
end

local function get_statusline_fileinfo_string(args)
  local is_special_buffer = vim.bo.buftype ~= ""
  local is_truncated = MiniStatusline.is_truncated(args.trunc_width)

  if is_truncated or is_special_buffer then
    return ""
  end

  local format = vim.bo.fileformat
  local encoding = vim.bo.fileencoding or vim.bo.encoding

  return string.format('%s[%s]', encoding, format)
end

local function get_statusline_location_string(args)
  local is_truncated = MiniStatusline.is_truncated(args.trunc_width)
  return is_truncated and "ln:%l cn:%v" or "ln:%l/%L cn:%v"
end

local function get_active_statusline_string()
  local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
  local git = get_statusline_git_string()
  local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
  local lsp = MiniStatusline.section_lsp({ trunc_width = 75 })
  local filename = MiniStatusline.section_filename({ trunc_width = 140 })
  local filetype = get_statusline_filetype_string()
  local fileinfo = get_statusline_fileinfo_string({ trunc_width = 120 })
  local location = get_statusline_location_string({ trunc_width = 75 })

  return MiniStatusline.combine_groups({
    { hl = mode_hl,                  strings = { mode } },
    { hl = 'MiniStatuslineDevinfo',  strings = { git, diagnostics, lsp } },
    '%<', -- Mark general truncate point
    { hl = 'MiniStatuslineFilename', strings = { filename } },
    '%=', -- End left alignment
    { hl = "MiniStatuslineFilename", strings = { filetype } },
    { hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
    { hl = mode_hl,                  strings = { location } },
  })
end

statusline.setup({
  content = {
    active = get_active_statusline_string
  },
})
