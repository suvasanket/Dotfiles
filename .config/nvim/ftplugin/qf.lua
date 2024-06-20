local function use_trouble()
	local status_ok, trouble = pcall(require, "trouble")
	local result = vim.fn.len(vim.fn.getqflist())
	if status_ok then
		if result == 0 then
			vim.defer_fn(function()
				vim.cmd.cclose()
				trouble.close("quickfix")
			end, 0)
		else
			vim.defer_fn(function()
				vim.cmd.cclose()
				trouble.open("quickfix")
				print(result)
			end, 0)
		end
	end
end
use_trouble()
