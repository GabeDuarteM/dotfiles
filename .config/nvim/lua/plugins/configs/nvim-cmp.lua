local present, cmp = pcall(require, "cmp")

if not present then
  return
end

-- nvim-cmp setup
local function border(hl_name)
  return {
    { "╭", hl_name },
    { "─", hl_name },
    { "╮", hl_name },
    { "│", hl_name },
    { "╯", hl_name },
    { "─", hl_name },
    { "╰", hl_name },
    { "│", hl_name },
  }
end

local icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Table = " ",
  Object = "",
  Tag = " ",
  Array = " ",
  Boolean = "蘒",
  Number = "",
  String = "",
  Calendar = " ",
  Watch = "",
}
local luasnip = require 'luasnip'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'cmp_tabnine' },
    { name = "path" },
  },
  window = {
    completion = {
      border = border "CmpBorder",
    },
    documentation = {
      border = border "CmpDocBorder",
    },
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

      return vim_item
    end,
  },
}

-- local has_words_before = function()
--   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
--   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
-- end
--
-- local feedkey = function(key, mode)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
-- end
--
-- vim.o.completeopt = "menuone,noselect"
--
-- vim.cmd([[
--   highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6
--   highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6
--   highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0
--   highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0
--   highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE
--   highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4
-- ]])
--
--
--
-- local cmp_window = require "cmp.utils.window"
--
-- cmp_window.info_ = cmp_window.info
-- cmp_window.info = function(self)
--   local info = self:info_()
--   info.scrollable = false
--   return info
-- end
--

-- local options = {
--   window = {
--     completion = {
--       border = border "CmpBorder",
--     },
--     documentation = {
--       border = border "CmpDocBorder",
--     },
--   },
-- --   snippet = {
-- --     expand = function(args)
-- --       vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
-- --     end,
-- --   },
--   formatting = {
--     format = function(_, vim_item)
--       vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
--
--       return vim_item
--     end,
--   },
--   mapping = {
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm {
--       behavior = cmp.ConfirmBehavior.Replace,
--       select = true,
--     },
--     ["<Tab>"] = cmp.mapping(function(fallback)
--       if cmp.visible() then
--         cmp.select_next_item()
--       elseif vim.fn["vsnip#available"](1) == 1 then
--         feedkey("<Plug>(vsnip-expand-or-jump)", "")
--       elseif has_words_before() then
--         cmp.complete()
--       else
--         fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
--       end
--     end, { "i", "s" }),
--     ["<S-Tab>"] = cmp.mapping(function()
--       if cmp.visible() then
--         cmp.select_prev_item()
--       elseif vim.fn["vsnip#jumpable"](-1) == 1 then
--         feedkey("<Plug>(vsnip-jump-prev)", "")
--       end
--     end, { "i", "s" }),
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'vsnip' }, -- For vsnip users.
--     { name = 'buffer' },
--     { name = 'cmp_tabnine' },
--     { name = "nvim_lua" },
--     { name = "path" },
--   })
-- }
--
-- cmp.setup(options)
