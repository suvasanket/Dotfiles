local opt = vim.opt
local cmd = vim.cmd

--appearance
vim.cmd.colorscheme("onedark")
opt.termguicolors = true
opt.signcolumn = "auto"
opt.fillchars = {
	fold = " ",
	-- eob = " ",
}
opt.hlsearch = true

opt.foldcolumn = "0" -- '0' is not bad
opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
opt.foldlevelstart = 99
opt.foldenable = true

--netrw
vim.g.did_load_netrw = 0

--some op options
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.dev/undodir"
opt.viewdir = os.getenv("HOME") .. "/.dev/vim_ses"
opt.undofile = true
opt.updatetime = 50
opt.autochdir = true

--line and cursor
opt.relativenumber = true
opt.number = true
opt.cursorline = true
-- o.guicursor = "n-v-c-i-sm:block,ci-ve:ver25,r-cr-o:hor20"
-- o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait40-blinkoff40-blinkon40-Cursor/lCursor"

--tab indent
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.wrap = false
opt.list = false
opt.expandtab = true

--search
opt.ignorecase = true
opt.smartcase = true

--backsapce
opt.backspace = "indent,eol,start"

--clipboard
-- o.clipboard:append("unnamedplus")

--split
opt.splitright = true
opt.splitbelow = true
opt.splitkeep = "screen"

opt.iskeyword:append("-")

--scrolloff
opt.scrolloff = 17

--indent
opt.autoindent = true
opt.smartindent = false
opt.showmode = false

--status line
opt.laststatus = 0
opt.ruler = false

--conceal
opt.conceallevel = 2
-- o.concealcursor = "n"

opt.hidden = true

--tabline
opt.showtabline = 1

opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.g.pasta_disabled_filetypes = { "fugitive", "compilation" }

-- Fix common typos
cmd([[
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
]])
