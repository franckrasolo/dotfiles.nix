local function augment_fold_with_line_count(virt_text, start_lnum, end_lnum, width, truncate)
  local new_virt_text = {}
  local suffix = (" 󰁇 %d"):format(end_lnum - start_lnum)
  local suffix_width = vim.fn.strdisplaywidth(suffix)
  local target_width = width - suffix_width
  local current_width = 0

  for _, chunk in ipairs(virt_text) do
    local chunk_text = chunk[1]
    local chunk_width = vim.fn.strdisplaywidth(chunk_text)
    if target_width > current_width + chunk_width then
      table.insert(new_virt_text, chunk)
    else
      chunk_text = truncate(chunk_text, target_width - current_width)
      local hl_group = chunk[2]
      table.insert(new_virt_text, { chunk_text, hl_group })
      chunk_width = vim.fn.strdisplaywidth(chunk_text)
      -- pad the string returned by truncate() if it is shorter than the 2nd argument
      if current_width + chunk_width < target_width then
        suffix = suffix .. (" "):rep(target_width - current_width - chunk_width)
      end
      break
    end
    current_width = current_width + chunk_width
  end
  table.insert(new_virt_text, { suffix, "Folded" })
  return new_virt_text
end

return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "BufReadPost",
  opts = function()
    vim.o.foldcolumn = "1"
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
    vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

    vim.api.nvim_set_hl(0, "Folded", { bg = "#111523", fg = "#3A4869" })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    }

    for _, ls in ipairs(require("lspconfig").util.available_servers()) do
      require("lspconfig")[ls].setup {
        capabilities = capabilities,
      }
    end

    return {
      close_fold_kinds_for_ft = {
        default = { "imports", "comment", "function" },
        json = { "array" },
      },

      fold_virt_text_handler = augment_fold_with_line_count,

      preview = {
        mappings = {
          jumpTop = "[",
          jumpBot = "]",
          scrollB = "<c-b>",
          scrollF = "<c-f>",
          scrollU = "<c-u>",
          scrollD = "<c-d>",
        },
      },

      provider_selector = function(_, filetype, buftype)
        local filetypes_with_lsp = { "json", "kcl", "kotlin", "mojo", "python", "rust", "yaml" }
        local filetype_providers = { git = "indent", NeogitStatus = "" }

        return (filetypes_with_lsp[filetype] and "lsp")
          or filetype_providers[filetype]
          or ((filetype == "" or buftype == "nofile") and "indent")
          or { "treesitter", "indent" }
      end,
    }
  end,
  keys = function()
    local ufo = require("ufo")

    local function preview_fold()
      local win_id = ufo.peekFoldedLinesUnderCursor()
      if not win_id then
        vim.lsp.buf.hover()
      end
    end

    return {
      { "zK", desc = "UFO: Preview fold", preview_fold },
      { "zm", desc = "UFO: Fold more", ufo.closeFoldsWith },
      { "zr", desc = "UFO: Fold less", ufo.openFoldsExceptKinds },
      { "zM", desc = "UFO: Close all folds", ufo.closeAllFolds },
      { "zR", desc = "UFO Open all folds", ufo.openAllFolds },
      { "zv", desc = "UFO: View cursor line", "<cmd>lua require('ufo').closeAllFolds()<cr>zozO", { noremap = true } },
    }
  end,
}
