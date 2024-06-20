vim.cmd.compiler("gcc")
vim.o.makeprg = "gcc -o %:t:r.o $* && ./%:t:r.o && rm %:t:r.o"

ftmap({ "<leader>xx", "<cmd>MakeC<cr>" })
ftmap({ "<leader>x", "<cmd>Run ./a.out rm a.out<cr>" })
