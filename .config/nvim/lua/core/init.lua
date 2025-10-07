function Import(file, func)
	local ok, res = pcall(require, file)
	if ok then
		return res
	else
		if func then
			func()
		else
			vim.notify("Error: something went wrong in " .. file, vim.log.levels.ERROR)
			local ans = vim.fn.confirm("open config?", "&Yes\n&No")
			if ans == 1 then
				vim.cmd.e("~/.config/nvim/lua/")
			end
		end
	end
end
local function core(path)
	Import("core." .. path, function()
		vim.cmd.e("~/.config/nvim/lua/core/" .. path .. ".lua")
	end)
end

core("lazy")
core("option")
core("usercmd")
core("autocmd")
core("keymaps")
core("lsp")
