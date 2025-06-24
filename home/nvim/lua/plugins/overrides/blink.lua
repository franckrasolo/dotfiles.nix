return {
  "saghen/blink.cmp",
  dependencies = {
    "mikavilpas/blink-ripgrep.nvim",
    "archie-judd/blink-cmp-words",
    -- optional dependency used for toggling features on/off
    "folke/snacks.nvim",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
        "ripgrep",
        "thesaurus",
      },
      per_filetype = {
        http = {
          "http",
          "snippets",
          "buffer",
          "ripgrep",
        },
        markdown = {
          "snippets",
          "buffer",
          "ripgrep",
          "obsidian",
          "obsidian_new",
          "obsidian_tags",
          "thesaurus",
          "dictionary",
        },
        text = {
          "buffer",
          "ripgrep",
          "thesaurus",
          "dictionary",
        },
        lua = {
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
          "ripgrep",
        },
        python = {
          "lazydev",
          "lsp",
          "path",
          "snippets",
          "buffer",
          "ripgrep",
          "thesaurus",
          "dictionary",
        },
      },
      providers = {
        lsp = {
          name = "LSP",
          module = "blink.cmp.sources.lsp",
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100, -- show at a higher priority than lsp
        },
        ripgrep = {
          module = "blink-ripgrep",
          name = "ripgrep",
          max_items = 3,
          score_offset = -5,
          ---@module "blink-ripgrep"
          ---@type blink-ripgrep.Options
          opts = {
            prefix_min_len = 3,
            context_size = 5,
            max_filesize = "1M",
            project_root_marker = { ".git", "devenv.nix", "pyproject.toml", "package.json" },
            project_root_fallback = true,
            search_casing = "--ignore-case",
            additional_rg_options = {},
            fallback_to_regex_highlighting = true,
            additional_paths = {},
            ignore_paths = {},
          },
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              -- example: append a description to easily distinguish rg results
              item.labelDetails = {
                description = "(rg)",
              }
            end
            return items
          end,
        },
        http = {
          name = "http",
          module = "blink.compat.source",
        },
        obsidian = {
          name = "obsidian",
          module = "blink.compat.source",
        },
        obsidian_new = {
          name = "obsidian_new",
          module = "blink.compat.source",
        },
        obsidian_tags = {
          name = "obsidian_tags",
          module = "blink.compat.source",
        },
        thesaurus = {
          name = "thesaurus",
          module = "blink-cmp-words.thesaurus",
          opts = {
            -- A score offset applied to returned items.
            -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
            score_offset = 0,

            -- Default pointers define the lexical relations listed under each definition,
            -- see Pointer Symbols below.
            -- Default is as below ("antonyms", "similar to" and "also see").
            pointer_symbols = { "!", "&", "^" },
          },
        },
        dictionary = {
          name = "dictionary",
          module = "blink-cmp-words.dictionary",
          opts = {
            -- The number of characters required to trigger completion.
            -- Set this higher if completion is slow, 3 is default.
            dictionary_search_threshold = 4,

            -- See above
            score_offset = 0,

            -- See above
            pointer_symbols = { "!", "&", "^" },
          },
        },
      },
      keymap = {
        preset = "none",
        ["<C-space>"] = {
          "show",
          "show_documentation",
          "hide_documentation",
        },
        ["<C-s>"] = {
          "show_signature",
          "hide_signature",
        },
        ["<C-y>"] = { "select_and_accept" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-b>"] = {},
        ["<C-f>"] = {},
        ["<C-k>"] = {}, -- Obscures expand luasnip
        ["<c-g>"] = {
          function() require("blink-cmp").show { providers = { "ripgrep" } } end,
        },
      },
      appearance = {
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
        -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
      },
      completion = {
        accept = {
          auto_brackets = {
            enabled = true,
          },
        },
        menu = {
          draw = {
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
            treesitter = { "lsp" },
          },
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
          window = {
            border = "single",
          },
        },
        ghost_text = {
          enabled = vim.g.ai_cmp,
        },
      },
      fuzzy = {
        sorts = {
          "exact",
          "score",
          "sort_text",
        },
      },
      signature = {
        enabled = true,
        window = {
          treesitter_highlighting = true,
          show_documentation = true,
        },
      },
      snippets = {
        expand = function(snippet, _) return LazyVim.cmp.expand(snippet) end,
        preset = "luasnip",
      },
    },
  },
}
