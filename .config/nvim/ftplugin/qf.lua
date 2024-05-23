local function use_trouble()
	local status_ok, trouble = pcall(require, "trouble")
	local result = vim.api.nvim_exec('echo len(getqflist())', true)
	if status_ok then
		if result == '0' then
			vim.cmd"TroubleClose"
			print("Quickfix is empty")
		else
			if vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0 then
				vim.defer_fn(function()
					vim.cmd.lclose()
					trouble.open("loclist")
				end, 0)
			else
				vim.defer_fn(function()
					vim.cmd.cclose()
					trouble.open("quickfix")
				end, 0)
			end
		end
	end
end
use_trouble()
