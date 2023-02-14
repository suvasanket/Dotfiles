local opt = vim.opt

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
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.smartindent = true

--search
opt.ignorecase = true
opt.smartcase = true

--cursor
-- opt.cursorline = true
-- opt.cursorcolumn = true

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

--wild menu
opt.wildmenu = true

--scrolloff
opt.scrolloff = 17

--list
opt.list = true

--auto write
opt.autowrite = true

--statusline
opt.laststatus = 3

--tabline
opt.showtabline = 2

--yank
vim.g.highlightedyank_highlight_duration = 50
