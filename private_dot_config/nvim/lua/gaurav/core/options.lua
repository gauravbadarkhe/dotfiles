vim.cmd("let g:netrw_liststyle =3")

local opt = vim.opt

opt.mouse = ""

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.incsearch = true
opt.hlsearch = false

opt.scrolloff = 8

opt.updatetime = 50

opt.wrap = false

-- search setting
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if mixed case is in query, seach becomes case-sensitive
opt.cursorline = true

-- colors
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom
