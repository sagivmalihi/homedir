vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', '<C-]>', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Initialize Mason without using mason-lspconfig
require('mason').setup({})

-- Configure LSP servers directly
local lspconfig = require('lspconfig')

-- Setup for language servers
lspconfig.eslint.setup({
  capabilities = lsp_capabilities,
})

lspconfig.dockerls.setup({
  capabilities = lsp_capabilities,
})

lspconfig.cssls.setup({
  capabilities = lsp_capabilities,
})

lspconfig.jsonls.setup({
  capabilities = lsp_capabilities,
})

-- Special configuration for lua_ls
lspconfig.lua_ls.setup({
  capabilities = lsp_capabilities,
  root_dir = function()
    return vim.fn.getcwd()
  end,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT'
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
        checkThirdParty = false,
        maxPreload = 2000,
        preloadFileSize = 1000
      },
      telemetry = {
        enable = false
      }
    }
  }
})

-- Special configuration for ruff
lspconfig.ruff.setup({
  capabilities = lsp_capabilities,
  settings = {
    args = {},
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),  -- Accept completion with Enter
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
})

local function filter_tsserver_diagnostics(_, result, ctx, config)
  if result.diagnostics == nil then
    return
  end
  -- ignore some tsserver diagnostics
  local idx = 1
  while idx <= #result.diagnostics do
    local entry = result.diagnostics[idx]
    -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
    if entry.code == 80001 then
      -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
      table.remove(result.diagnostics, idx)
    else
      idx = idx + 1
    end
  end
  vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = filter_tsserver_diagnostics
