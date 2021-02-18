local api = vim.api
local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local conf = require('telescope.config').values
local Job = require("plenary/job")

local M = {}

local note_dir = "/home/jefflangston/Dropbox/notes"

function M.feedkeys(string, mode)
  api.nvim_feedkeys(api.nvim_replace_termcodes(string, true, true, true), mode, true)
end

function M.feedraw(s)
  api.nvim_feedkeys(s, 'n', false)
end

function M.start_insert_header()
  M.feedkeys("Go<CR>#<space>", 'n')
end

function M.find_zettels(opts)
  opts = opts or {}
  -- local picker_opts = {
  --   prompt_title = 'Find notes',
  --   finder = finders.new_table {
  --     results = json.result,
  --     entry_maker = M.gen_from_zettels,
  --   },
  --   previewer = previewers.vim_buffer_cat.new(opts),
  --   sorter = conf.generic_sorter(opts),
  -- }
  --
  -- if opts.insert then
  --   picker_opts.attach_mappings = function()
  --     actions.goto_file_selection_edit:replace(neuron_actions.insert_maker("id"))
  --     return true
  --   end
  -- else
  --   picker_opts.attach_mappings = function()
  --     actions.goto_file_selection_edit:replace(neuron_actions.edit_or_insert)
  --     return true
  --   end
  -- end
  --
  -- pickers.new(opts, picker_opts):find()
  opts.search_dirs = {note_dir}
  builtin.live_grep(opts)
end

function M.gen_from_zettels(entry)
  local value = string.format("%s/%s", note_dir, entry.zettelPath)
  local display = entry.zettelTitle
  return {
    display = display,
    value = value,
    ordinal = display,
    id = entry.zettelID,
  }
end


function M.insert_maker(key)
  return function(prompt_bufnr)
    actions.close(prompt_bufnr)

    local entry = actions.get_selected_entry()
    api.nvim_put({entry[key]}, "c", true, true)
  end
end

function M.edit_or_insert(prompt_bufnr)
  actions.close(prompt_bufnr)

  local entry = actions.get_selected_entry()
  if entry ~= nil then
    vim.cmd("edit " .. entry.value)
  else
    local current_line = actions.get_current_line() -- todo, need pr telescope for this
    M.new_and_callback(note_dir, function(data)
      vim.cmd("edit " .. data)
      M.start_insert_header()
      M.feedraw(current_line)
      M.feedkeys("<CR><CR>", "n")
    end)
  end
end

function M.new_and_callback(callback)
  Job:new {
    command = "touch",
    args = {"note.md"},
    cwd = note_dir,
    on_stderr = M.on_stderr_factory(""),
    on_stdout = vim.schedule_wrap(function(error, data)
      assert(not error, error)

      callback(data)
    end),
    on_exit = M.on_exit_factory("touch"),
  }:start()
end

function M.on_stderr_factory(name)
  return vim.schedule_wrap(function(error, data)
    assert(not error, error)
    vim.cmd(string.format("echoerr 'An error occured from running %s: %s'", name, data))
  end)
end

function M.on_exit_factory(name)
  return vim.schedule_wrap(function(self, code, _signal)
    if code ~= 0 then
      error(string.format("The job %s exited with a non-zero code: %s", name, code))
    end
  end)
end

return M
