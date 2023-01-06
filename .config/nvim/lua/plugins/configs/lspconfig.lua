local nvim_lsp = require('lspconfig')

local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local map = function(mode, keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
  end

  local vmap = function(keys, func, desc)
    map('v', keys, func, desc)
  end

  local nmap = function(keys, func, desc)
    map('n', keys, func, desc)
  end

  -- local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  -- local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- -- Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  vmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('[d', vim.diagnostic.goto_prev, 'Previous [D]iagnostic')
  nmap(']d', vim.diagnostic.goto_next, 'Next [D]iagnostic')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
  nmap('<space>F', function() vim.lsp.buf.format { async = true } end, '[F]ormat')
  vmap('<space>F', function() vim.lsp.buf.format { async = true } end, '[F]ormat')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
  -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap('n', '<space>K', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- buf_set_keymap('v', '<leader>ca', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  -- buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  -- vim.keymap.set('n', '<space>F', function() vim.lsp.buf.format { async = true } end, opts)
  -- buf_set_keymap('v', '<space>F', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)

  -- null-ls stuff
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.lsp.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.lsp.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.lsp.diagnostic.show_line_diagnostics()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")
  -- buf_map(bufnr, "n", "gd", ":LspDef<CR>")
  -- buf_map(bufnr, "n", "gr", ":LspRename<CR>")
  -- buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
  -- buf_map(bufnr, "n", "K", ":LspHover<CR>")
  -- buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
  -- buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
  -- buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
  -- buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
  -- buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")

  local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
-- local servers = { 'tsserver', 'tailwindcss', 'gopls', 'rust_analyzer', 'astro' }
local servers = {
  tailwindcss = {},
  astro = {},
  gopls = {},
  rust_analyzer = {},
  tsserver = {},

  sumneko_lua = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

local servers_custom_onattach = {
  tsserver = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    local ts_utils = require("nvim-lsp-ts-utils")
    ts_utils.setup({
      eslint_bin = "eslint_d",
      eslint_enable_diagnostics = true,
      eslint_enable_code_actions = true,
      enable_formatting = true,
      formatter = "prettier",
    })
    ts_utils.setup_client(client)
    buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
    buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
    buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")
    on_attach(client, bufnr)
  end
}

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    nvim_lsp[server_name].setup {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        if servers_custom_onattach[server_name] then
          servers_custom_onattach[server_name](client, bufnr)
        else
          on_attach(client, bufnr)
        end
      end,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

-- -- Use a loop to conveniently call 'setup' on multiple servers and
-- -- map buffer local keybindings when the language server attaches
-- local servers = { 'tsserver', 'tailwindcss', 'gopls', 'rust_analyzer', 'astro' }
-- -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- for _, lsp in ipairs(servers) do
--   nvim_lsp[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     flags = {
--       debounce_text_changes = 150,
--     }
--   }
-- end
--
local null_ls = require("null-ls")

null_ls.setup({
  on_attach = on_attach,
  sources = {
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.formatting.prettierd.with({
      -- only_local = "node_modules/.bin",
      condition = function(utils)
        return utils.root_has_file({ ".prettierrc", ".prettierrc.json", ".prettierrc.yml", ".prettierrc.yaml",
          ".prettierrc.js", ".prettierrc.cjs", "prettier.config.js", "prettier.config.cjs", ".prettierrc.toml" })
      end,
      env = {
        PRETTIERD_LOCAL_PRETTIER_ONLY = "true",
      },
    }),
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs", ".eslintrc.yaml", ".eslintrc.yml", ".eslintrc.json",
          ".eslintrc", ".eslintignore" })
      end,
    }),
    null_ls.builtins.code_actions.refactoring,
  }
})

-- Automatically update diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, prefix = "●" },
  severity_sort = true,
})

local function lspSymbol(name, icon)
  local hl = "DiagnosticSign" .. name
  vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
  },
  signs = true,
  underline = true,
  update_in_insert = false,
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = "single",
})
