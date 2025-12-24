local o = vim.opt

o.inccommand = "split"

--appearance
if not pcall(vim.cmd.colorscheme, "fleet") then
	vim.cmd.colorscheme("default")
end
o.termguicolors = true
o.signcolumn = "auto"
o.hlsearch = false
o.incsearch = true

o.foldenable = true
o.foldlevel = 99
o.foldmethod = "expr"
o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
o.foldcolumn = "0"
o.fillchars:append({ fold = " " })

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
-- o.guicursor = "n-v-c-i-sm:block,ci-ve:ver25,r-cr-o:hor20,a:blinkwait40-blinkoff40-blinkon40-Cursor/lCursor"
o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait40-blinkoff40-blinkon40-Cursor/lCursor"
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
