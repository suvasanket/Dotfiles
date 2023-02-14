vim.g.mapleader = " "
local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
--general
map("n", "<C-\\>", ":bd!<cr>")
map("t", "<C-\\>", "<C-\\><C-n>:bd!<cr>")
map("n", "<F2>", ":source %<cr> <cmd>echo 'File sourced!!!'<cr>")
map("n", "<leader>nh", ":nohl<CR>")
map("n", "<leader>q", ":q!<cr>")
map("n", "<leader>s", ":w%<cr>")
map("n", "<leader>w", ":w!<cr>", { silent = false })
map("n", "dl", "0D")
map("v", "<C-c>", "<ESC>")
map("n", "<F1>", "<cmd>w%<cr>")
map("n", "<F3>", "<cmd>ToggleLine<cr>")
map("n", "<leader>a", "<cmd>Startify<cr>")
map("n", "<leader>l", "<cmd>Lazy<cr>")
map("n", "<leader>t", "<cmd>Lspsaga term_toggle<cr>")

--splits
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<leader>\\", "<C-w>s")
map("n", "<leader>|", "<C-w>v")
map("n", "<leader>ss", "<C-w>m")
map("n", "<leader>sq", ":close<CR>")
map("n", "<leader><Right>", ":vertical resize +5<cr>")
map("n", "<leader><Left>", ":vertical resize -5<cr>")
map("n", "<leader><Up>", ":horizontal resize +5<cr>")
map("n", "<leader><Down>", ":horizontal resize -5<cr>")

--buffer & tab
map("n", "<tab>h", ":tabprevious<cr>")
map("n", "<tab>l", ":tabnext<cr>")
map("n", "<tab>q", ":tabclose<cr>")
map("n", "<C-]>", ":bnext<CR>")
map("n", "<C-[>", ":bprevious<CR>")

--advanced keymaps
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<C-u>", "<C-u>zz")
map("n", "<C-d>", "<C-d>zz")
map("v", "<leader>p", '"_dp')
map("n", "<C-p>", ":Vaffle%<CR>")

-------------------------------------------------------plugin keymaps----------------------------------------------------------

--tele
map("n", "<C-f>", "<cmd>FZF $HOME<cr>")
map("n", "<leader>mp", "<cmd>Telescope keymaps<cr>")
map("n", "<leader>ch", "<cmd>Telescope command_history<cr>")
map("n", "<leader>ht", "<cmd>Telescope help_tags<cr>")
map("n", "\\", "<cmd>Telescope jumplist<cr> <esc>")
map("n", "s", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
map("n", "gi", "<cmd>Telescope lsp_implementations<cr>")
map("n", "gr", "<cmd>Telescope lsp_references<cr>")
map("n", "<leader>f", "<cmd>Telescope lsp_document_symbols<cr>")

--runner
map("n", "<leader>o", ":RunCode<CR>", { noremap = true, silent = false })
map("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
map("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })
map("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
map("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })

--undotree
map("n", "<leader>u", ":UndotreeToggle<cr> :UndotreeFocus<cr>")

--live server
map("n", "<leader>ls", ":LiveServer start<cr>")
map("n", "<leader>le", ":LiveServer stop<cr>")

--git
map("n", "<leader>gs", ":Gwrite<cr>")
map("n", "<leader>gu", ":Gread<cr>")
map("n", "<leader>gp", ":Git<cr>")
map("n", "<leader>g0", ":Gitsigns reset_buffer_index<cr>")
map("n", "<leader>gd", ":Gvdiffsplit<cr>")
