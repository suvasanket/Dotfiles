-- vim.api.nvim_create_autocmd("FileType", {
-- 	pattern = "compilation",
-- 	command = "wincmd w",
-- })

ftmap{  "n", "<cmd>NextError<cr>" }
ftmap{ "n", "p", "<cmd>PrevError<cr>" }
ftmap{ "n", "r", "<cmd>Recompile<cr>" }

vim.cmd[[set nonu norelativenumber]]
