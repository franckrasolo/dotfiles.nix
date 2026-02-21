local textwidth = 120
local indentSize = 2

vim.opt_local.tabstop = indentSize
vim.opt_local.softtabstop = indentSize
vim.opt_local.shiftwidth = indentSize

vim.opt_local.autoindent = true
vim.opt_local.expandtab = true

vim.opt_local.textwidth = textwidth
vim.opt_local.colorcolumn = tostring(textwidth + 1)

-- disable `smartindent` as it conflicts with Treesitter, causing unpredictable
-- jumps or preventing `formatoptions`` from triggering correctly
vim.opt_local.smartindent = false

-- use treesitter-based indentation
vim.opt_local.indentexpr = "vim:lua.require('nvim-treesitter').indentexpr()"

-- enable list continuation (the "Smart Enter")
-- treat '-' as a list leader for internal formatting
--  'r' continues the list marker after hitting Enter in Insert mode
--  'o' continues the list marker after hitting 'o' or 'O' in Normal mode
--  'n' is also helpful here for recognising (numbered/bulleted) lists
vim.opt_local.formatoptions:append("ron")

-- regex describing exactly what a list item looks like
vim.opt_local.formatlistpat = [[^\s*-\s+]]

-- trigger re-indentation when typing ':' or '- '
-- vim.opt_local.indentkeys:append({ "0:", "- " })

-- trigger re-indentation immediately after typing '-'
vim.opt_local.indentkeys:append("0-")

-- define what a "list item" looks like for Neovim's formatting engine
--  'n' treats it as a nested list
--  'b' requires a space after the '-'
vim.opt_local.comments = "b:-"
