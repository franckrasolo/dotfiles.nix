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

    require("luasnip.loaders.from_lua").lazy_load {
      paths = { "./lua/snippets" },
      fs_event_providers = { libuv = true },
    }

    local function map(key, fn)
      vim.keymap.set({ "i", "s" }, key, fn, { silent = true })
    end

    map("<c-j>", function() if luasnip.expand_or_jumpable() then luasnip.expand_or_jump() end end)
    map("<c-k>", function() if luasnip.jumpable(-1) then luasnip.jump(-1) end end)
    map("<c-l>", function() if luasnip.choice_active() then luasnip.change_choice(1) end end)
  end,
  opts = {
    -- disable history
    keep_roots = false,
    link_roots = false,
    link_children = false,
    exit_roots = true,

    -- enable live buffer updates as you type
    update_events = { "TextChanged", "TextChangedI" },

    ext_opts = {
      [require("luasnip.util.types").choiceNode] = {
        active = {
          virt_text = { { " « Choice", "Comment" } },
        },
      },
    },
  },
}
