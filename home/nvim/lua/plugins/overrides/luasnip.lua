return {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  config = function()
    -- additional snippets from friendly-snippets
    local luasnip = require("luasnip")
    luasnip.filetype_extend("kotlin", { "kdoc" })
    luasnip.filetype_extend("lua", { "luadoc" })
    luasnip.filetype_extend("python", { "comprehension", "pydoc" })
    luasnip.filetype_extend("rust", { "rustdoc" })
    luasnip.filetype_extend("sh", { "shelldoc" })
    luasnip.filetype_extend("typescript", { "tsdoc" })
  end
}
