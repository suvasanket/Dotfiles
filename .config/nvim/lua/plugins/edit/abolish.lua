return {
	"tpope/vim-abolish",
	event = "InsertEnter",
	config = function()
		local abolish = {
			"{despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}",
			"i{m,ve} i'{}",
			"ABolish Abolish",
			"pirnt print",
			"{fucn,func}t{io,oi}n {func}t{io}n",
			"helo hello",
			"lcoal local",
			"enw new",
			"lenght length",
			"St{ri,ir}{gn,ng} St{ri}{ng}",
		}
		for _, cmd in ipairs(abolish) do
			vim.cmd("Abolish " .. cmd)
		end
	end,
}
