local nvim_lsp = require'lspconfig'
local vim = vim


---- icons
local w_sign = ""
local e_sign = ""
local h_sign = "ﯦ"

---- hilight
vim.fn.sign_define("LspDiagnosticsSignError", {text = e_sign, texthl = "LspDiagnosticsSignError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = w_sign, texthl = "LspDiagnosticsSignWarning"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = h_sign, texthl = "LspDiagnosticsSignHint"})

vim.cmd [[highlight! link LspDiagnosticsDefaultError Red]]
vim.cmd [[highlight! link LspDiagnosticsDefaultWarning Yellow]]
vim.cmd [[highlight! link LspDiagnosticsDefaultHint Green]]
vim.cmd [[highlight! link LspDiagnosticsDefaultInfomation Grey]]

---- saga
local saga = require 'lspsaga'
local saga_opts = {
  error_sign = e_sign,
  warn_sign = w_sign,
  hint_sign = h_sign,
  code_action_icon = ' ',
  finder_definition_icon = '  ',
  finder_reference_icon = '  ',
  definition_preview_icon = '  ',
  border_style = 1
}

saga.init_lsp_saga(saga_opts)

-- dignostic
vim.lsp.diagnostic.set_signs()
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    underline = false,
    -- This is similar to:
    -- let g:diagnostic_show_sign = 1
    -- To configure sign display,
    --  see: ":help vim.lsp.diagnostic.set_signs()"
    signs = true,

    -- This is similar to:
    -- "let g:diagnostic_insert_delay = 1"
    update_in_insert = false,
  }
)

-- completion
vim.o.completeopt = "menu,menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = false;
    treesitter = true;
    tabnine = true;
  };
}

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'lspconfig'.rust_analyzer.setup {
  capabilities = capabilities,
}

-- keymap
local keymap_lsp_func = {
  gd = "vim.lsp.buf.definition()",
  -- gD = "require'lspsaga.provider'.preview_definiton()",
  -- gd = "require'lspsaga.provider'.lsp_finder()",
  gi = "vim.lsp.buf.implementation()",
  K = "require'lspsaga.hover'.render_hover_doc()",
  gt = "vim.lsp.buf.references()",
  gr = "require('lspsaga.rename').rename()",
  gD = "require'lspsaga.provider'.lsp_finder()",
  ca = "require'lspsaga.codeaction'.code_action()",
  ["[e"] = "require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()",
  ["]e"] = "require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()",
  et = "require'lspsaga.floaterm'.open_float_terminal()",
  qt = "require'lspsaga.floaterm'.close_float_terminal()",
  ti = "require'lspsaga.floaterm'.open_float_terminal('gitui')"
}

local opts = { noremap=true, silent=true }
for k, v in pairs(keymap_lsp_func) do
  vim.api.nvim_set_keymap('n', k, string.format("<cmd>lua %s<CR>", v), opts)
end

local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = vim.fn.stdpath('cache')..'/lspconfig/sumneko_lua/lua-language-server'
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

nvim_lsp.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
}

--Python Config
-- nvim_lsp.pyls.setup{
--   on_attach=on_attach;
--   settings = {
--     pyls = {
--       plugins = {
--         pycodestyle = {
--           enabled = false;
--         };
--         pyls_mypy = {
--           enabled = false;
--         };
--       }
--     }
--   }
-- }
--

--C++ config
-- nvim_lsp.clangd.setup{on_attach=on_attach}

--VimLang config
nvim_lsp.vimls.setup{}

--Lua config
-- nvim_lsp.sumneko_lua.setup{}

--Javascript/Typescript
nvim_lsp.tsserver.setup{}

-- Ruby
nvim_lsp.solargraph.setup{}

--Html
nvim_lsp.html.setup{}

--Rust
nvim_lsp.rust_analyzer.setup{
  cmd = {"rust-analyzer"}
}

--go
nvim_lsp.gopls.setup{}

-- Terraform
nvim_lsp.terraformls.setup{}

-- Docker
nvim_lsp.dockerls.setup{}

--typescript
nvim_lsp.tsserver.setup{}

--yaml
nvim_lsp.yamlls.setup{
  cmd = {"yaml-language-server", "--stdio"},
  settings = {
    yaml = {
      schemaStore = {
        enable = true
      },
      schemas = {
        kubernetes = "/*.yaml";
      }
    }
  }
}
