local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("return", {
        t("return"),
        t({ "{", "\t" }),
        i(1),
        t({ "\t", "}" }),
    }
    ),

    s("func", {
        t({ "function()", "\t" }),
        i(1),
        t({ "\t", "end" }),
    }
    ),
}
