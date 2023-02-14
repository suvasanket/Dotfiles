local ls = require("luasnip") --{{{
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("Lua Snippets", { clear = true })
local file_pattern = "*.lua"

local main = s(
	"psvm",
	fmt(
		[[
public static void main(String []args){{
    {}
}}
]],
		{
			i(1, ""),
		}
	)
)

local cs = s(
	{ trig = "for([%w_]+)", regTrig = true, hidden = true },
	fmt(
		[[
for(int {}=0;{}<{};{}++){{
    {}
}}
{}
]],
		{
			d(1, function(_, snip)
				return sn(1, i(1, snip.captures[1]))
			end),
			rep(1),
			c(2, { i(1, "num"), sn(1, { i(1, "arr"), t(".length") }) }),
			rep(1),
			i(3, ""),
			i(4),
		}
	)
)

table.insert(snippets, main)
table.insert(snippets, cs)

return snippets, autosnippets
