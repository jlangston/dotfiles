local vim = vim

local telescope = require'telescope'
local actions = require'telescope.actions'

require"hop".setup {}

-- extensions
telescope.load_extension('octo')

telescope.setup{
  defaults = {
    mappings = {
      i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-x>"] = false,
        ["<c-s>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical
      },
      n = {
        ["jj"] = actions.close,
        ["<c-x>"] = false,
        ["<c-s>"] = actions.select_horizontal,
        ["<c-v>"] = actions.select_vertical
      },
    }
  }
}

local opts = { noremap=true, silent=true }
local keymap_telescope_func = {
  ["<C-p>"] = "require'telescope.builtin'.find_files()",
  ["<Leader>f"] = "require'telescope.builtin'.live_grep()",
  ["<Leader>ch"] = "require'telescope.builtin'.command_history{}",
  ["<Leader>gb"] = "require'telescope.builtin'.git_branches()",
  ["<Leader>bc"] = "require'telescope.builtin'.git_branches()",
  ["t"] = "require'telescope.builtin'.lsp_document_symbols()",
  ["T"] = "require'telescope.builtin'.lsp_workspace_symbols()",
  [";"] = "require'telescope.builtin'.buffers{show_all_buffers = true}",
  -- ["<Leader>gi"] = "require'telescope.builtin'.extensions.issues()",
  -- ["<Leader>gp"] = "require'telescope.builtin'.extensions.pull_request()",
  -- ["<Leader>gst"] = "require'telescope.builtin'.git_status()",
  ["<Leader>gr"] = "require'telescope.builtin'.lsp_references{ shorten_path = true }",
  [","] = "require'hop'.hint_words()"
}

for k, v in pairs(keymap_telescope_func) do
  vim.api.nvim_set_keymap('n', k, string.format("<cmd> lua %s<CR>", v), opts)
end

