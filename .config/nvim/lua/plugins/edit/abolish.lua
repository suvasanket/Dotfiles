return {
	"tpope/vim-abolish",
	config = function ()
		vim.cmd[[
		Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}
		Abolish fu{c,n}tion function
		Abolish im i'm
		Abolish ive i've
		Abolish ABolish Abolish
		]]
	end
}
