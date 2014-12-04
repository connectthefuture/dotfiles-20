" unmap in insert mode" This line should not be removed as it ensures that
" various options are properly set to work with the Vim-related packages
" available in Debian.
runtime! debian.vim

set nocompatible                " be iMproved, required (?)
filetype off                    " required (?)
syntax enable                   " enable syntax highlighting

" /------ VUNDLE and PLUGINS --------------------------------------------------/
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'      " let Vundle manage Vundle, required

" Keep Plugin commands between vundle#begin/end.
Plugin 'vim-scripts/taglist.vim.git'    " taglist för kod-navigering
Plugin 'scrooloose/nerdtree.git'        " NERDTree
" snipMate : TextMate-style snippets for Vim
" http://www.vim.org/scripts/script.php?script_id=2540
" Plugin 'snipMate'
Plugin 'bling/vim-airline'              " vim-airline
Plugin 'kien/ctrlp.vim'                 " Full path fuzzy file/buffer/.. finder

" Color Schemes
Plugin 'sjl/badwolf.git'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " use indentation scripts (required(?))
" To ignore plugin indent changes, instead use: filetype plugin on
" Put your non-Plugin stuff after this line


" /------ MISC. BASICS --------------------------------------------------------/
" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
" set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif
set mouse=a                 " enable mouse usage (all modes)
set showcmd                 " show (partial) command in status line.
set history=1000            " extend command line history
set autowrite               " automatically save before commands like :next:make
set hidden                  " hide buffers when they are abandoned
set nowrap                  " no linewrapping

" /------ INDENTATION ---------------------------------------------------------/
set autoindent              " keep indentation from previous line
set smartindent             " some automation, support for C-type files
set expandtab               " always insert softtabstop amount of chars
set shiftwidth=4
set tabstop=4
set softtabstop=4

" /------ SEARCH --------------------------------------------------------------/
set hlsearch                " highlight search
set ignorecase              " searches are case insensitive..
set smartcase               " .. unless they contain at least one capital letter
set incsearch               " incremental search, show results while typing.

" /------ VISUAL --------------------------------------------------------------/
set cursorline              " highlight current line
set number                  " show line numbers
set showmatch               " show matching brackets.
set ruler                   " show column and row in footer

set list                    " show whitespace
set listchars=tab:▸\ ,eol:¬

set laststatus=2                " add full file path to your existing statusline
"set statusline+=%F
"set statusline=
"set statusline+=%<\                       " cut at start
"set statusline+=%2*[%n%H%M%R%W]%*\        " flags and buf no
"set statusline+=%-40f\                    " path
"set statusline+=%=%1*%y%*%*\              " file type
"set statusline+=%10((%l,%c)%)\            " line and column
"set statusline+=%P                        " percentage of file

" File type syntax highlighting aliases
au BufRead,BufNewFile *.ino set filetype=c                      " arduino
au BufRead,BufNewFile *.md set filetype=markdown                " markdown
au BufRead,BufNewFile *.kicad_mod,*.kicad_pcb set filetype=lisp " kicad
autocmd BufRead *.tab set filetype=tab                          " guitar tabs

set t_Co=256                        " 256 color support
match ErrorMsg '\%>80v.\+'          " Highlight anthing after 80 chars with red

" Color scheme
syntax on
colorscheme badwolf

" Enable powerline fonts
let g:airline_powerline_fonts = 1

" Enable enhanced tabline
let g:airline#extensions#tabline#enabled = 1



" /------ KEYBINDINGS ---------------------------------------------------------/
" easier moving of code blocks (Vim as Python IDE - Martin Brochhaus)
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Ctrl-j/k deletes blank line below/above if it is blank, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Ctrl-n opens/closes NERDtree
"map <C-n> :NERDTreeToggle<CR>

" fuzzy search
map <F2> :CtrlPMixed<CR>

" Unmap the arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" Insert todays date
":nnoremap <F5> "=strftime("%c")<CR>P
":inoremap <F5> <C-R>=strftime("%c")<CR>
:nnoremap <F5> "=strftime("%Y-%m-%d %a %H:%M")<CR>P
:inoremap <F5> <C-R>=strftime("%Y-%m-%d %a %H:%M")<CR>

" Quick pairs
" source: Shawn Biddle Vim Training Class 4 - http://youtu.be/2pqipq-UEwQ
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i
imap <leader>{ {}<ESC>i

" Strip all trailing whitespace in the current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
