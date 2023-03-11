local opt = vim.opt

require("core.ui")
vim.g.did_load_netrw = 0

--some op options
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.updatetime = 50

--line number
opt.relativenumber = true
opt.number = true

--tab indent
opt.tabstop = 4
opt.wrap = false

--search
opt.ignorecase = true
opt.smartcase = true

--appearance
opt.termguicolors = true
opt.signcolumn = "yes"
opt.hlsearch = false

--backsapce
opt.backspace = "indent,eol,start"

--clipboard
opt.clipboard:append("unnamedplus")

--split
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")

--scrolloff
opt.scrolloff = 17

--list
opt.list = true
