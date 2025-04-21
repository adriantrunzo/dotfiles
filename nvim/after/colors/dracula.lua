local palette = vim.g["dracula#palette"]

local background = palette.bg[1]
local comment = palette.comment[1]
local foreground = palette.fg[1]
local green = palette.green[1]
local orange = palette.orange[1]
local purple = palette.purple[1]
local selection = palette.selection[1]
local yellow = palette.yellow[1]

local highlight = vim.api.nvim_set_hl

highlight(0, "MiniDiffSignAdd", { link = "DiffAdd" })
highlight(0, "MiniDiffSignChange", { link = "DiffChange" })
highlight(0, "MiniDiffSignDelete", { link = "DiffDelete" })

highlight(0, "MiniStatuslineDevInfo", { bg = comment, fg = foreground })
highlight(0, "MiniStatuslineFileInfo", { bg = comment, fg = foreground })
highlight(0, "MiniStatuslineFilename", { bg = selection, fg = foreground })
highlight(0, "MiniStatuslineInactive", { bg = selection, fg = foreground })
highlight(0, "MiniStatuslineModeCommand", { bg = purple, fg = background })
highlight(0, "MiniStatuslineModeInsert", { bg = green, fg = background })
highlight(0, "MiniStatuslineModeNormal", { bg = purple, fg = background })
highlight(0, "MiniStatuslineModeOther", { bg = green, fg = background })
highlight(0, "MiniStatuslineModeReplace", { bg = orange, fg = background })
highlight(0, "MiniStatuslineModeVisual", { bg = yellow, fg = background })
