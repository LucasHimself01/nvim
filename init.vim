" Plugins
call plug#begin("~/.vim/plugged")
	Plug 'PHSix/faster.nvim',
	" Lua line
	Plug 'hoob3rt/lualine.nvim'
	" FILE EXPLORER
	Plug 'scrooloose/nerdtree'
	"Completion (my qoc)
	Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
	" 9000+ Snippets
	Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
	"qoc 3rd party
	Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
	"LSP
	Plug 'neovim/nvim-lspconfig'
	Plug 'williamboman/nvim-lsp-installer'
	Plug 'jose-elias-alvarez/null-ls.nvim'
	Plug 'jose-elias-alvarez/nvim-lsp-ts-utils'
	" LSP UI
	Plug 'glepnir/lspsaga.nvim'
	" Vim which
	Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
	" Starting page
	Plug 'mhinz/vim-startify'
	" Language parsing library Tree sitter
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	" Git branch getter
	Plug 'itchyny/vim-gitbranch'
	" Telescope
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim'
	" GIT WRAPPER
	Plug 'tpope/vim-fugitive'
	" GITHUB INTEGRATION
	Plug 'tpope/vim-rhubarb'
	" Auto close {} [] ()
	Plug 'cohama/lexima.vim'
	" ICONS
	Plug 'ryanoasis/vim-devicons'
	Plug 'kyazdani42/nvim-web-devicons'
	" COLOR THEMES
	Plug 'dracula/vim'
call plug#end()

"Config Section
"lua require("coq")
lua require("keymaps")
lua require("lsp-config")
lua require("lualine")
"lua require("telescope")
lua require("theme")

if (has("termguicolors"))
	set termguicolors
endif

syntax enable
colorscheme dracula

let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" Toggle NERDTree
nnoremap <silent> <C-n> :NERDTreeToggle<CR>

" Hover doc
nnoremap <silent>K :Lspsaga hover_doc<CR>

" Signature help
inoremap <silent> <C-k> <Cmd>Lspsaga signature_help<CR>

" Async LSP Finder
nnoremap <silent> gh <Cmd>Lspsaga lsp_finder<CR>

" Telescope
nnoremap <silent> ;f <cmd>Telescope find_files<cr>
nnoremap <silent> ;r <cmd>Telescope live_grep<cr>
nnoremap <silent> \\ <cmd>Telescope buffers<cr>
nnoremap <silent> ;; <cmd>Telescope help_tags<cr>

" Enable mouse selections
set mouse=a
set cursorline

" local actions = require('telescope.actions')
" require('telescope').setup{
"  defaults = {
"    mappings = {
"      n = {
"        ["q"] = actions.close
"      },
"    },
"  }
"}

" my coq stuff
"set g:coq_settings = { 
"	auto_start: true | 'shut-up'
"}

function! GetUniqueSessionName()
  let path = fnamemodify(getcwd(), ':~:t')
  let path = empty(path) ? 'no-project' : path
  let branch = gitbranch#name()
  let branch = empty(branch) ? '' : '-' . branch
  return substitute(path . branch, '/', '-', 'g')
endfunction

autocmd User        StartifyReady silent execute 'SLoad '  . GetUniqueSessionName()
autocmd VimLeavePre *             silent execute 'SSave! ' . GetUniqueSessionName()

