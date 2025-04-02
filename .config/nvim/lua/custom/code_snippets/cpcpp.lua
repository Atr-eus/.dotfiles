local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("cpp", {
  s("cpcpp", fmt([[
#include <iostream>
using namespace std;
typedef long long ll;

void an() {{
{}{}
}}

int main() {{
  ios_base::sync_with_stdio(0);
  cin.tie(0);
  cout.tie(0);

  int t;
  cin >> t;
  while (t--) {{
    an();
  }}
}}
]], {
    t("  "),
    i(1, "// Who is rem?"),
  })
  ),
})
