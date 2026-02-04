local git_trailers = {
  -- location = (vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config") .. "/git/trailers",
  location = vim.fn.getcwd() .. "/.config/git-trailers",

  assisted_by = {
    desc = "used for disclosing the use of an AI model, tool, or service when significant parts "
      .. "of the contribution are AI-generated/assisted and incorporated without changes",
    file = "assistants.txt",
    type = "Assistant(s)",
    key = "Assisted-by",
    keybinding = "<c-a>",
    log_format = "%(trailers:key=Assisted-by,valueonly)",
  },
  co_authored_by = {
    desc = "used for indicating that people collaborated synchronously in real-time on a change",
    file = "co-authors.txt",
    type = "Co-Author(s)",
    key = "Co-authored-by",
    keybinding = "<c-u>",
    log_format = "%aN <%aE>%n%(trailers:key=Co-authored-by,valueonly)",
  },
  co_developed_by = {
    desc = "used for indicating that people collaborated synchronously in real-time on a change",
    file = "co-authors.txt",
    type = "Co-Developer(s)",
    key = "Co-developed-by",
    keybinding = "<c-d>",
    log_format = "%aN <%aE>%n%(trailers:key=Co-developed-by,valueonly)",
  },
  mentored_by = {
    desc = "used for crediting someone who helped develop a change as part of a mentorship program",
    file = "mentors.txt",
    type = "Mentor(s)",
    key = "Mentored-by",
    keybinding = "<c-.>",
    log_format = "%aN <%aE>%n%(trailers:key=Mentored-by,valueonly)",
  },
  reported_by = {
    desc = "used for crediting someone who reported an issue or idea associated with a change",
    file = "reporters.txt",
    type = "Reporter(s)",
    key = "Reported-by",
    keybinding = "<c-r>",
    log_format = "%(trailers:key=Reported-by,valueonly)",
  },
  signed_off_by = {
    desc = "used for adding signature and acknowledgment of licensing terms when contributing changes",
    file = "co-authors.txt",
    type = "Signatory / Signatories",
    key = "Signed-off-by",
    keybinding = "<c-s>",
    log_format = "%aN <%aE>%n%(trailers:key=Signed-off-by,valueonly)",
  },
  suggested_by = {
    desc = "used for crediting someone who suggested the idea for a change",
    file = "suggesters.txt",
    type = "Suggester(s)",
    key = "Suggested-by",
    keybinding = "<c-g>",
    log_format = "%(trailers:key=Suggested-by,valueonly)",
  },
}

local function load_entries_for(git_trailer)
  local path = git_trailers.location .. "/" .. (git_trailer.file or "")
  local stat = vim.uv.fs_stat(path)
  if stat ~= nil and stat.type == "file" then
    return vim.fn.readfile(path)
  else
    return {}
  end
end

local function generate_users(git_trailer)
  local git_log_command = "git -c log.showSignature=false log"
  local log_format = "--format='" .. git_trailer.log_format .. "'"
  local show_unique_results = "sort -u | sed '/^[[:space:]]*$/d'"
  local list_unique_users = git_log_command .. " " .. log_format .. " | " .. show_unique_results

  local users = vim.fn.extend(vim.fn.systemlist(list_unique_users), load_entries_for(git_trailer))

  local unique_users = {}
  local seen = {}
  for _, user in ipairs(users) do
    if not seen[user] then
      seen[user] = true
      unique_users[#unique_users + 1] = user
    end
  end
  return unique_users
end

local function multi_select(users, git_trailer, snacks)
  local items = {}
  for _, user in ipairs(users) do
    items[#items + 1] = { text = user }
  end

  -- find where comments start (usually first line starting with '#')
  local target_buf = vim.fn.bufnr("COMMIT_EDITMSG")
  local buf_lines = vim.api.nvim_buf_get_lines(target_buf, 0, -1, false)
  local insert_at = #buf_lines -- default to end if no comments found
  for i, line in ipairs(buf_lines) do
    if line:match("^#") then
      insert_at = i - 1
      break
    end
  end

  snacks.picker.pick {
    items = items,
    format = "text",
    layout = { preset = "select" },
    title = "Select " .. git_trailer.type,

    confirm = function(picker, _)
      local selected = picker:selected { fallback = true }
      picker:close()

      if #selected > 0 then
        local selected_trailers = { "" }
        for _, selected_item in ipairs(selected) do
          local trailer_text = git_trailer.key .. ": " .. selected_item.text
          table.insert(selected_trailers, trailer_text)
        end
        if target_buf ~= -1 then
          vim.api.nvim_buf_set_lines(target_buf, insert_at, insert_at, false, selected_trailers)
        else
          vim.notify("Neogit commit editor not found!", vim.log.levels.WARN)
        end
      end

      -- return cursor to the end of the first line in the buffer
      local target_win = vim.fn.bufwinid(target_buf)
      if target_win ~= -1 then
        vim.api.nvim_set_current_win(target_win)

        local line, col = unpack(vim.api.nvim_win_get_cursor(target_win))
        vim.api.nvim_win_set_cursor(target_win, { line, col + 1 })
      end
    end,
  }
end

local function create_git_commit_trailer_autocmd_for(git_trailer)
  local function select_users()
    local users = generate_users(git_trailer)
    if #users == 0 then return end

    local ok, snacks = pcall(require, "snacks")
    if ok and snacks.picker then
      multi_select(users, git_trailer, snacks)
    end
  end

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "COMMIT_EDITMSG",
    callback = function()
      local opts = { buffer = true, desc = "Add " .. git_trailer.type }
      vim.keymap.set({ "i", "n" }, git_trailer.keybinding, select_users, opts)
    end,
  })
end

return {
  create_git_commit_trailer_autocmd_for(git_trailers.assisted_by),
  create_git_commit_trailer_autocmd_for(git_trailers.co_authored_by),
  create_git_commit_trailer_autocmd_for(git_trailers.co_developed_by),
  create_git_commit_trailer_autocmd_for(git_trailers.mentored_by),
  create_git_commit_trailer_autocmd_for(git_trailers.reported_by),
  create_git_commit_trailer_autocmd_for(git_trailers.signed_off_by),
  create_git_commit_trailer_autocmd_for(git_trailers.suggested_by),
}
