local M = {}

M.icons = {

  Text = " ",
  Method = "󰆧 ",
  Function = "󰊕 ",
  Constructor = " ",
  Field = " ",
  Variable = "󰆧 ",
  Class = "󰌗 ",
  Interface = "󰕘 ",
  Module = " ",
  Property = " ",
  Unit = "",
  Value = "󰎠 ",
  Enum = "󰕘 ",
  Keyword = "󰌋 ",
  Snippet = " ",
  Color = " ",
  File = "󰈙 ",
  Reference = " ",
  Folder = " ",
  EnumMember = " ",
  Constant = "󰏿 ",
  Struct = "󰌗 ",
  Event = " ",
  Operator = "󰆕 ",
  TypeParameter = "󰊄 ",
}

function M.setup()
  local kinds = vim.lsp.protocol.CompletionItemKind
  for i, kind in ipairs(kinds) do
    kinds[i] = M.icons[kind] or kind
  end
end

return M
