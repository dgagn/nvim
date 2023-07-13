local ls = require('luasnip')
local s = ls.s
local fmt = require('luasnip.extras.fmt').fmt
local i = ls.insert_node
local c = ls.choice_node
local t = ls.text_node

return {
  s('for', fmt([[
  for {}, {} in {}({}) do
    {}
  end
    ]], {
      i(1, "k"),
      i(2, "v"),
      c(3, { t("ipairs"), t("pairs") }),
      i(4, "t"),
      i(0)
    })),
  s('fori', fmt([[
  for i = {}, {}, {} do
    {}
  end
    ]], {
      i(1, "1"),
      i(2, "10"),
      i(3, "1"),
      i(0)
    })),
  s('req', fmt("require('{}'){}", {
    i(1),
    i(0)
  })),
  s('require', fmt("require('{}'){}", {
    i(1),
    i(0)
  })),
  s('local', fmt("local {} = {}", {
    i(1),
    i(0)
  })),
}
