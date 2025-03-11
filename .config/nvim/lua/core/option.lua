local o = vim.opt

--appearance
if not pcall(vim.cmd.colorscheme, "fleet") then
	vim.cmd.colorscheme("default")
end
o.termguicolors = true
o.signcolumn = "auto"
o.hlsearch = true

-- o.foldcolumn = "0" -- '0' is not bad
o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
o.foldlevelstart = 99
o.foldenable = true
o.foldmethod = "indent"

--netrw
vim.g.did_load_netrw = 0

--some op options
o.swapfile = false
o.backup = false
o.undodir = os.getenv("HOME") .. "/.dev/undodir"
o.viewdir = os.getenv("HOME") .. "/.dev/vim_ses"
o.undofile = true
o.updatetime = 50
o.autochdir = true

--line and cursor
o.relativenumber = true
o.number = true
-- o.guicursor = "n-v-c-i-sm:block,ci-ve:ver25,r-cr-o:hor20,a:blinkwait40-blinkoff40-blinkon40-Cursor/lCursor"
o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait40-blinkoff40-blinkon40-Cursor/lCursor"

--tab indent
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = 4
o.wrap = false
o.list = false
o.expandtab = true

--search and commandline
o.ignorecase = true
o.smartcase = true
o.wildmenu = true

--backsapce
o.backspace = "indent,eol,start"

--clipboard
-- o.clipboard:append("unnamedplus")

--split
o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"

o.iskeyword:append("-")

--scrolloff
o.scrolloff = 17

--indent
o.autoindent = true
o.smartindent = false
o.showmode = false

--status line
o.laststatus = 2
o.ruler = false

--conceal
o.conceallevel = 2
-- o.concealcursor = "n"

o.hidden = true

--tabline
o.showtabline = 1

o.sessionoptions = "buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"

-- lsp
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

-- Fix common typos
vim.cmd([[
cnoreabbrev W! w!
cnoreabbrev W1 w!
cnoreabbrev w1 w!
cnoreabbrev Q! q!
cnoreabbrev Q1 q!
cnoreabbrev q1 q!
cnoreabbrev Qa! qa!
cnoreabbrev Qall! qall!
cnoreabbrev Wa wa
cnoreabbrev Wq wq
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev wq1 wq!
cnoreabbrev Wq1 wq!
cnoreabbrev wQ1 wq!
cnoreabbrev WQ1 wq!
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qa qa
cnoreabbrev GW Gw
cnoreabbrev Qall qall
cnoreabbrev clearqflist Clearqflist
cnoreabbrev clearqflist Clearqflist
cnoreabbrev T Term
cnoreabbrev T! Term!
cnoreabbrev T1 Term!
cnoreabbrev man Man
]])
