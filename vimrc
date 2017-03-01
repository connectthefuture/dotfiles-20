" (Reload vimrc while editing with :so %)
" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

"  ____________________________________________________________________________
" /______ SETUP VUNDLE ________________________________________________________/
" Setup prereqs, include Vundle in runtime path and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" _______ PLUGINS _____________________________________________________________
call vundle#begin()
Plugin 'gmarik/Vundle.vim'              " Let Vundle manage Vundle, required
"Plugin 'majutsushi/tagbar.git'          " taglist for code navigation
Plugin 'scrooloose/nerdtree.git'        " NERDTree
Plugin 'vim-airline/vim-airline'        " vim-airline
Plugin 'vim-airline/vim-airline-themes' " airline themes moved to this repo
Plugin 'flazz/vim-colorschemes'         " Color theme pack
"Plugin 'ervandew/supertab'
"Plugin 'honza/vim-snippets'             "
"Plugin 'tpope/vim-fugitive'             " fugitive
Plugin 'scrooloose/nerdcommenter'       " Code commenting
Plugin 'tpope/vim-surround'             " Surround with chars or words
"Plugin 'vim-scripts/AutoComplPop.git'
Plugin 'dhruvasagar/vim-table-mode'     " VIM Table Mode
call vundle#end()

filetype plugin indent on               " Use indentation scripts (required(?))
                                        " To ignore plugin indent changes,
                                        " instead use: filetype plugin on

"  ____________________________________________________________________________
" /______ MISC. BASICS ________________________________________________________/
set mouse=v                 " Enable mouse in visual mode only
set showcmd                 " Show (partial) command in status line
set history=1000            " Extend command line history
set autowrite               " Automatically save before commands like :next:make
set autoread                " Automatically read file when changed outside vim
set hidden                  " Hide buffers when they are abandoned
set nowrap                  " No linewrapping
set visualbell              " Don't beep at me.
set ttyfast                 " Assume fast terminal connection
syntax enable               " Enable syntax highlighting
"autocmd BufEnter * cd %:p:h " Automatically change current directory to file dir
set virtualedit=block       " Allow moving to empty space in visual block mode
set wildmenu                " Show possible autocompletions

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" _______ TEMPORARY FILES _____________________________________________________
" Keep temporary files in alternate locations to reduce clutter
" (alternatively disable with: Set nobackup Set noswapfile)
" Trailing // fixes name collisions. Source: http://stackoverflow.com/a/15317146
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

" _______ INDENTATION _________________________________________________________
set autoindent              " Keep indentation from previous line
set smartindent             " Some automation, support for C-type files
set expandtab               " Always insert softtabstop amount of chars
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Overrule the 'ft-tex-plugin' format detection heuristics.
let g:tex_flavor='latex'

" _______ COMPLETION __________________________________________________________
set completeopt=longest,menuone

" _______ SEARCH ______________________________________________________________
set hlsearch                " Highlight search
set ignorecase              " Searches are case insensitive..
set smartcase               " .. unless they contain at least one capital letter
set incsearch               " Incremental search, show results while typing

" _______ VISUAL ______________________________________________________________
set cursorline                  " Highlight current line
set number                      " Show line number at cursor
set relativenumber              " Show relative line numbers
set numberwidth=1               " Keep gutter as small as can be
set showmatch                   " Show matching brackets
set ruler                       " Show column and row in footer
"set list                       " Show whitespace
"set listchars=tab:▸\ ,eol:¬     " Show tabs with ▸, eol with ¬
set laststatus=2                " Add full file path to your existing statusline
set t_Co=256                    " 256 color support
set lazyredraw                  " Don't redraw during macros, etc
set nostartofline               " Don't jump to the start of line when scrolling
set scrolloff=5                 " Show some context when scrolling

" Highlight column 80 using colorcolumn if available
"if exists('+colorcolumn')
  "set colorcolumn=80
"else
  "au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
"endif

" Set colorscheme and hacky fix to bring back transparency.
set background=dark
colorscheme 256-grayvim-transparent

"hi clear CursorLine
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi Folded ctermbg=NONE
hi NonText ctermbg=NONE
hi SpecialKey ctermbg=NONE
hi VertSplit ctermbg=NONE
hi SignColumn ctermbg=NONE
hi Normal guibg=NONE

" _______ SYNTAX ______________________________________________________________
" File type syntax highlighting aliases.
au BufRead,BufNewFile *.ino                   set filetype=c
au BufRead,BufNewFile *.{md,mkd,markdown,txt} set filetype=markdown
au BufRead,BufNewFile *.{kicad_mod,kicad_pcb} set filetype=lisp
au BufRead,BufNewFile *.tab                   set filetype=tab

" Behaviour specific to file type
"   (also separate files in '${dotfilesroot}/vim/ftplugin')
" Enable spellcheck and wrapping for Git commit messages.
autocmd Filetype gitcommit setlocal spell spelllang=en,sv textwidth=72 complete+=k


"  ____________________________________________________________________________
" /______ KEYBINDINGS _________________________________________________________/

" Remap leader to § (key below ESC, above tab)
let mapleader='§'
let leader='§'
set timeout timeoutlen=1500

" Easier moving of code blocks (Vim as Python IDE - Martin Brochhaus)
vnoremap < <gv
vnoremap > >gv

" Unmap keys I repeatedly hit by accident; Q (ex mode) and K (keywordprg).
nnoremap Q <nop>
nnoremap K <nop>

" Ctrl-j moves lines or selection down
" Ctrl-k moves lines or selection up
"nnoremap <C-j> :m .+1<CR>==
"nnoremap <C-k> :m .-2<CR>==
"inoremap <C-j> <Esc>:m .+1<CR>==gi
"inoremap <C-k> <Esc>:m .-2<CR>==gi
"vnoremap <C-j> :m '>+1<CR>gv=gv
"vnoremap <C-k> :m '<-2<CR>gv=gv

" Search and replace word under cursor.
" http://vim.wikia.com/wiki/Search_and_replace_the_word_under_the_cursor
:nnoremap <Leader>r :%s/\<<C-r><C-w>\>//g<Left><Left>

" Ctrl-l and Ctrl-h for navigating open buffers.
noremap <C-l> :bnext<cr>
noremap <C-h> :bprevious<cr>

" F3 toggles paste mode.
set pastetoggle=<F3>

" F6 toggles option to display whitespace.
nnoremap <F6> :set list!<cr>

" F7 toggles relative line numbers.
nnoremap <F7> :set relativenumber!<cr>

" Map keys for nerdtree, ctrlp and tagbar.
map <leader>n :NERDTreeToggle<CR>
map <C-p>     :CtrlPMixed<CR>
"map <C-b>     :CtrlPBuffer<CR>
map <leader>t :TagbarToggle<CR>

" I rarely use the arrow keys at all, not just in Vim.  Unbinding to free them
" up for potential use by things like tmux, the window manager, etc.
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

" Switch windows a tad faster by not having to hit <ctrl> w <direction>.
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

" Insert a timestamp. Useful when taking notes at lectures.
":inoremap <F5> <C-R>=strftime("%F %A")<CR>

" Insert a timestamp as a markdown-style level 2 heading.
:inoremap <F5> <C-R>=strftime("%F %A")<CR><ESC>yypVr-j

" When in insert mode; hit leader before ( to insert text surrounded by ().
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i
imap <leader>{ {}<ESC>i

" Strip all trailing whitespace in current file with <leader> W.
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Switch back and forth between last two open buffers.
nnoremap <leader><leader> <c-^>


"  ____________________________________________________________________________
" /______ PLUGIN SPECIFIC _____________________________________________________/

" Semantic stuff (?)
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" Fixes syntastics interaction with YouCompleteMe (syntastic help section 6.4)
let g:ycm_show_diagnostics_ui = 0

" _____________________________________________________________________________

" Use reStructuredText-compatible tables in vim-table-mode.
let g:table_mode_corner_corner="+"
let g:table_mode_header_fillchar="="

" _____________________________________________________________________________

let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" _____________________________________________________________________________

let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='raven'

" _____________________________________________________________________________

" Disable Syntastic by default and toggle error checking with <meta> S
"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
"nnoremap <leader>S :SyntasticCheck<CR> :SyntasticToggleMode<CR>

" Syntastic related. Basically the recommended defaults. Use ':help syntastic'
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1 " Put detected errors in list
"let g:syntastic_auto_loc_list = 1            " Auto close/open location list
"let g:syntastic_check_on_open = 0            " Do not check when loading buffers
"let g:syntastic_check_on_wq = 0              " Do not check when writing buffers

"  ____________________________________________________________________________

let g:ctrlp_follow_symlinks = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']

