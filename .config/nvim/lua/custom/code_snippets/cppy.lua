local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("python", {
  s("cppy", fmt([[
import sys
input = sys.stdin.read
from functools import lru_cache

def i_love_emilia():
{}{}

if __name__ == "__main__":
    t = int(input())
    for _ in range(t):
        i_love_emilia()
]], {
    t("    "),
    i(1, "# Who is rem?"),
  })
  ),
})
