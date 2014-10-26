" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

set nocompatible				" be iMproved, required (?)
filetype off					" required (?)
syntax enable					" enable syntax highlighting

" /------ VUNDLE and PLUGINS --------------------------------------------------/
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'      " let Vundle manage Vundle, required

" Keep Plugin commands between vundle#begin/end.
Plugin 'vim-scripts/taglist.vim.git'    " taglist för kod-navigering
Plugin 'scrooloose/nerdtree.git'        " NERDTree
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

" /------ MISC. BASICS --------------------------------------------------------/
set mouse=a			" enable mouse usage (all modes)
set showcmd			" show (partial) command in status line.
set history=1000    " extend command line history
set autowrite		" automatically save before commands like :next and :make
set hidden			" hide buffers when they are abandoned
set nowrap          " no linewrapping

" /------ INDENTATION ---------------------------------------------------------/
set autoindent
set smartindent
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab           " use spaces instead of tabs

" /------ SEARCH --------------------------------------------------------------/
set hlsearch            " highlight search
set ignorecase          " searches are case insensitive..
set smartcase           " .. unless they contain at least one capital letter
set incsearch           " incremental search, show results while typing.

" /------ VISUAL --------------------------------------------------------------/
set cursorline          " highlight current line
set number              " show line numbers
set showmatch           " show matching brackets.
set ruler               " show column and row in footer 

set laststatus=2        " add full file path to your existing statusline
"set statusline+=%F
set statusline=
set statusline+=%<\                       " cut at start
set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
set statusline+=%-40f\                    " path
set statusline+=%=%1*%y%*%*\              " file type
set statusline+=%10((%l,%c)%)\            " line and column
set statusline+=%P                        " percentage of file

" File type syntax highlighting
au BufRead,BufNewFile *.ino set filetype=c                      " arduino
au BufRead,BufNewFile *.md set filetype=markdown                " markdown
au BufRead,BufNewFile *.kicad_mod,*.kicad_pcb set filetype=lisp " kicad
autocmd BufRead *.tab set filetype=tab                          " guitar tabs

" Display tabs and trailing spaces visually
set list listchars=tab:\ \ ,trail:·

" Highlight anthing after 80 chars with red
match ErrorMsg '\%>80v.\+'

" 256 color support
set t_Co=256

" Color scheme
syntax on
colorscheme badwolf

" Source a global configuration file if available
"if filereadable("/etc/vim/vimrc.local")
"  source /etc/vim/vimrc.local
"endif

" /------ KEYBINDINGS ---------------------------------------------------------/
" easier moving of code blocks (Vim as Python IDE - Martin Brochhaus)
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Ctrl-j/k deletes blank line below/above if it is blank, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>
