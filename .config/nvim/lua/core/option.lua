local o = vim.opt

o.inccommand = "split"

--appearance
if not pcall(vim.cmd.colorscheme, "fleet") then
	vim.cmd.colorscheme("default")
end
o.hlsearch = false
o.incsearch = true

o.foldenable = true
o.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"

vim.g.did_load_netrw = 0

o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.dev/undodir"
o.viewdir = os.getenv("HOME") .. "/.dev/vim_ses"
o.undofile = true
o.updatetime = 50
o.autochdir = true
o.autoread = true

o.relativenumber = true
o.number = true
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.wrap = false
o.list = false
o.expandtab = true
o.ignorecase = true
o.smartcase = true

o.grepprg = "rg --vimgrep -u -S"

--split
o.splitright = true
o.splitbelow = true
o.scrolloff = 17
o.autoindent = true
o.showmode = false
o.ruler = false
o.conceallevel = 2

-- Cache git branch to avoid running command on every statusline refresh
local git_branch_cache = {}

function _G.git_branch()
	return git_branch_cache[GetProjectRoot()]
end

function _G.update_git_branch()
	local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
	if branch ~= "" then
		git_branch_cache[GetProjectRoot()] = branch
	end
end

-- Update on buffer enter and after shell commands
vim.api.nvim_create_autocmd({ "DirChanged" }, {
	callback = function()
		_G.update_git_branch()
	end,
})

local defline = vim.o.statusline
defline = defline:gsub("%%f", "%%f [%%{v:lua.git_branch()}]")
vim.opt.statusline = string.format(" %s ", defline)
