" unmap in insert mode" This line should not be removed as it ensures that
" various options are properly set to work with the Vim-related packages
" available in Debian.
runtime! debian.vim


" /------ SETUP VUNDLE --------------------------------------------------------/
" setup prereqs, include Vundle in runtime path and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" /------ <PLUGINS> -----------------------------------------------------------/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'              " let Vundle manage Vundle, required
Plugin 'vim-scripts/taglist.vim.git'    " taglist för kod-navigering
Plugin 'scrooloose/nerdtree.git'        " NERDTree
Plugin 'snipMate'
Plugin 'bling/vim-airline'              " vim-airline
Plugin 'kien/ctrlp.vim'                 " Full path fuzzy file/buffer/.. finder
Plugin 'sjl/badwolf.git'                " Color Scheme
Plugin 'Valloric/YouCompleteMe.git'     " YouCompleteMe
call vundle#end()
" /------ </PLUGINS> ----------------------------------------------------------/

filetype plugin indent on               " use indentation scripts (required(?))
                                        " To ignore plugin indent changes,
                                        " instead use: filetype plugin on

" /------ MISC. BASICS --------------------------------------------------------/
syntax enable                           " enable syntax highlighting

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif
"
set mouse=a                 " enable mouse usage (all modes)
set showcmd                 " show (partial) command in status line.
set history=1000            " extend command line history
set autowrite               " automatically save before commands like :next:make
set hidden                  " hide buffers when they are abandoned
set nowrap                  " no linewrapping
set vb                      " visual bell I.E. no beeping

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
set cursorline                  " highlight current line
set number                      " show line numbers
set showmatch                   " show matching brackets.
set ruler                       " show column and row in footer
set list                        " show whitespace
set listchars=tab:▸\ ,eol:¬     " show tabs with ▸, eol with ¬
set laststatus=2                " add full file path to your existing statusline
set t_Co=256                    " 256 color support
match ErrorMsg '\%>80v.\+'      " highlight anthing after 80 chars with red

colorscheme badwolf             " color scheme
hi Normal ctermbg=NONE          " bring back transparency
hi Normal guibg=NONE            " ..

" File type syntax highlighting aliases
au BufRead,BufNewFile *.ino set filetype=c                      " arduino
au BufRead,BufNewFile *.md set filetype=markdown                " markdown
au BufRead,BufNewFile *.kicad_mod,*.kicad_pcb set filetype=lisp " kicad
autocmd BufRead *.tab set filetype=tab                          " guitar tabs

let g:airline_powerline_fonts = 1                   " Enable powerline fonts
let g:airline#extensions#tabline#enabled = 1        " .. and enhanced tabline


" /------ KEYBINDINGS ---------------------------------------------------------/
let mapleader='§'                   " remap leader to § (key below ESC, above tab)
let leader='§'

" easier moving of code blocks (Vim as Python IDE - Martin Brochhaus)
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" Ctrl-j/k deletes blank line below/above if it is blank, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

" Ctrl-n opens/closes NERDtree
map <leader>n :NERDTreeToggle<CR>

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

" Switch buffers
noremap <C-l> :bnext<cr>
noremap <C-h> :bprevious<cr>

" F3 toggles paste mode
nnoremap <F3> :set paste!<cr>
