local nvim_lsp = require'lspconfig'

On_attach = function(_, bufnr)
  require'completion'.on_attach()

  -- Mappings.
  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<c-k>', '<Cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','gd','<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','K','<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','gr','<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>gr','<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><c-[>', '<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader><c-]>', '<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>', opts)
end

vim.lsp.callbacks['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
vim.lsp.callbacks['textDocument/references'] = require'lsputil.locations'.references_handler
vim.lsp.callbacks['textDocument/definition'] = require'lsputil.locations'.definition_handler
vim.lsp.callbacks['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
vim.lsp.callbacks['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
vim.lsp.callbacks['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
vim.lsp.callbacks['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
vim.lsp.callbacks['workspace/symbol'] = require'lsputil.symbols'.workspace_handler


-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--   vim.lsp.diagnostic.on_publish_diagnostics, {
--     -- This will disable virtual text, like doing:
--     -- let g:diagnostic_enable_virtual_text = 0
--     virtual_text = false,
--     -- This is similar to:
--     -- let g:diagnostic_show_sign = 1
--     -- To configure sign display,
--     --  see: ":help vim.lsp.diagnostic.set_signs()"
--     signs = true,
--     -- This is similar to:
--     -- "let g:diagnostic_insert_delay = 1"
--     update_in_insert = false,
--   }
-- )

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
nvim_lsp.solargraph.setup{on_attach=On_attach}

--C++ config
-- nvim_lsp.clangd.setup{on_attach=on_attach}

--VimLang config
nvim_lsp.vimls.setup{on_attach=On_attach}

--Lua config
nvim_lsp.sumneko_lua.setup{on_attach=On_attach}

--Javascript/Typescript
nvim_lsp.tsserver.setup{on_attach=On_attach}

--Html
nvim_lsp.html.setup{on_attach=On_attach}

--Rust
nvim_lsp.rust_analyzer.setup{on_attach=On_attach}

--go
nvim_lsp.gopls.setup{on_attach=On_attach}

-- Terraform
nvim_lsp.terraformls.setup{on_attach=On_attach}

-- Docker
nvim_lsp.dockerls.setup{on_attach=On_attach}
