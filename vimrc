" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

set nocompatible				" be iMproved, required
filetype off					" required
syntax enable					"

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.


" taglist för kod-navigering
Plugin 'vim-scripts/taglist.vim.git'

" NERDTree
Plugin 'scrooloose/nerdtree.git'
" NERDTree ctrl+n keybind
map <C-n> :NERDTreeToggle<CR>

" snipMate : TextMate-style snippets for Vim 
" http://www.vim.org/scripts/script.php?script_id=2540
Plugin 'snipMate'

" vim indent guides
" A Vim plugin for visually displaying indent levels in code
"Plugin 'nathanaelkane/vim-indent-guides'
"au VimEnter * IndentGuidesEnable

" Color Schemes
Plugin 'sjl/badwolf.git'
Plugin 'vim-scripts/BusyBee.git'
Plugin 'morhetz/gruvbox.git'
Plugin 'w0ng/vim-hybrid.git'
Plugin 'nanotech/jellybeans.vim.git'
Plugin 'djjcast/mirodark.git'
Plugin 'tomasr/molokai.git'
Plugin 'sickill/vim-monokai.git'
Plugin 'jpo/vim-railscasts-theme.git'
Plugin 'vim-scripts/twilight.git'
Plugin 'jnurmine/Zenburn.git'

" Color Scheme Scroller
" After a Vim restart, type :SCROLL and use your arrow keys to preview themes.
Plugin 'https://github.com/vim-scripts/ScrollColors'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
"if has("syntax")
"  syntax on
"endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" BASIC STUFF
set showcmd			" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Searches are case insensitive..
set smartcase		" .. unless they contain at least one capital letter
set hlsearch		" Highlight search
set incsearch		" Incremental search, show results while typing.
set cursorline      " Highlight current line
set autowrite		" Automatically save before commands like :next and :make
set hidden			" Hide buffers when they are abandoned
set mouse=a			" Enable mouse usage (all modes)
set number          " Show line numbers
set nowrap          " No linewrapping
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab       " Use spaces instead of tabs
set ruler           " Show column and row in footer 

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" easier moving of code blocks (Vim as Python IDE - Martin Brochhaus)
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" File type syntax highlighting
au BufRead,BufNewFile *.ino set filetype=c
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.kicad_mod,*.kicad_pcb set filetype=lisp
autocmd BufRead *.tab set filetype=tab

" Add full file path to your existing statusline
set laststatus=2
"set statusline+=%F
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file


" Highlight anthing after 80 chars with red
match ErrorMsg '\%>80v.\+'

" 256 color support
set t_Co=256

" Color scheme
syntax on
colorscheme badwolf
