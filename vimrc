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
Plugin 'majutsushi/tagbar.git'          " taglist for code navigation
Plugin 'scrooloose/nerdtree.git'        " NERDTree
Plugin 'bling/vim-airline'              " vim-airline
Plugin 'kien/ctrlp.vim'                 " Full path fuzzy file/buffer/.. finder
Plugin 'sjl/badwolf.git'                " Color Scheme
"Plugin 'Valloric/YouCompleteMe.git'     " YouCompleteMe
Plugin 'SirVer/ultisnips'               " ultisnips
Plugin 'ervandew/supertab'
Plugin 'honza/vim-snippets'             "
Plugin 'tpope/vim-fugitive'             " fugitive
Plugin 'junegunn/goyo.vim'              " Distraction free mode
Plugin 'scrooloose/nerdcommenter'       " Code commenting
Plugin 'godlygeek/tabular'              " For making things neater
Plugin 'tpope/vim-surround'             " Surround with chars or words
call vundle#end()

"  ____________________________________________________________________________
" /______ PLUGIN SPECIFIC _____________________________________________________/
filetype plugin indent on               " Use indentation scripts (required(?))
                                        " To ignore plugin indent changes,
                                        " instead use: filetype plugin on

let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py" " Semantic stuffs
" Fixes syntastics interaction with YouCompleteMe (syntastic help section 6.4)
let g:ycm_show_diagnostics_ui = 0

"  ____________________________________________________________________________
" /______ MISC. BASICS ________________________________________________________/
set mouse=v                 " Enable mouse in visual mode only
set showcmd                 " Show (partial) command in status line
set history=1000            " Extend command line history
set autowrite               " Automatically save before commands like :next:make
set autoread                " Automatically read file when changed outside vim
set hidden                  " Hide buffers when they are abandoned
set nowrap                  " No linewrapping
set vb                      " Visual bell I.E. no beeping
set keywordprg=trans\ :sv   " Translate with google translate via translateshell
                            " (Shift-K to view translation of word under cursor)
set ttyfast                 " Assume fast terminal connection
syntax enable               " Enable syntax highlighting
autocmd BufEnter * cd %:p:h " Automatically change current directory to file dir

"** Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"  ____________________________________________________________________________
" /______ TEMPORARY FILES _____________________________________________________/
" Keep temporary files in alternate locations to reduce clutter
" (alternatively disable with: Set nobackup Set noswapfile)
" Trailing // fixes name collisions. Source: http://stackoverflow.com/a/15317146
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

"  ____________________________________________________________________________
" /______ INDENTATION _________________________________________________________/
set autoindent              " Keep indentation from previous line
set smartindent             " Some automation, support for C-type files
set expandtab               " Always insert softtabstop amount of chars
set shiftwidth=4
set tabstop=4
set softtabstop=4

"  ____________________________________________________________________________
" /______ SEARCH ______________________________________________________________/
set hlsearch                " Highlight search
set ignorecase              " Searches are case insensitive..
set smartcase               " .. unless they contain at least one capital letter
set incsearch               " Incremental search, show results while typing

"  ____________________________________________________________________________
" /______ VISUAL ______________________________________________________________/
set cursorline                  " Highlight current line
set number                      " Show line numbers
set showmatch                   " Show matching brackets
set ruler                       " Show column and row in footer
set list                        " Show whitespace
set listchars=tab:▸\ ,eol:¬     " Show tabs with ▸, eol with ¬
set laststatus=2                " Add full file path to your existing statusline
set t_Co=256                    " 256 color support

"** Highlight column 80 using colorcolumn if available
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

"** Set colorscheme and hacky fix to bring back transparency
colorscheme badwolf
"hi clear CursorLine
hi Normal ctermbg=NONE
hi LineNr ctermbg=NONE
hi Folded ctermbg=NONE
hi NonText ctermbg=NONE
hi SpecialKey ctermbg=NONE
hi VertSplit ctermbg=NONE
hi SignColumn ctermbg=NONE
hi Normal guibg=NONE

"** File type syntax highlighting aliases
au BufRead,BufNewFile *.ino set filetype=c                      " arduino
au BufRead,BufNewFile *.md set filetype=markdown                " markdown
au BufRead,BufNewFile *.kicad_mod,*.kicad_pcb set filetype=lisp " kicad
autocmd BufRead *.tab set filetype=tab                          " guitar tabs

"** Enable powerline fonts and enhanced tabline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

"  ____________________________________________________________________________
" /______ KEYBINDINGS _________________________________________________________/
"** Remap leader to § (key below ESC, above tab)
let mapleader='§'
let leader='§'
set timeout timeoutlen=1500

"** Easier moving of code blocks (Vim as Python IDE - Martin Brochhaus)
vnoremap < <gv
vnoremap > >gv

"** Ctrl-j moves lines or selection down
"   Ctrl-k moves lines or selection up
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

"** Ctrl-l and Ctrl-h for navigating open buffers
noremap <C-l> :bnext<cr>
noremap <C-h> :bprevious<cr>

"** F3 toggles paste mode
nnoremap <F3> :set paste!<cr>

"** F6 toggles option to display whitespace
nnoremap <F6> :set list!<cr>

"** F7 toggles relative line numbers
nnoremap <F7> :set relativenumber!<cr>

"** Map keys for nerdtree, ctrlp and tagbar
map <leader>n :NERDTreeToggle<CR>
map <C-p>     :CtrlPMixed<CR>
map <C-b>     :CtrlPBuffer<CR>
map <leader>t :TagbarToggle<CR>

"** Unmap the arrow keys. Because they should not be used, ever.
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

"** Switch windows a tad faster by not having to hit <ctrl> w <direction>
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>h <C-w>h
nnoremap <leader>l <C-w>l

"** Shortcut for inserting a timestamp. Useful when taking notes at lectures
":inoremap <F5> <C-R>=strftime("%F %A")<CR>
:inoremap <F5> <C-R>=strftime("%F %A")<CR><ESC>yypVr-j

"** When in insert mode; hit leader before ( to insert text surrounded by ()
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i
imap <leader>{ {}<ESC>i

"** Strip all trailing whitespace in current file with leader-W
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

"** If you want :UltiSnipsEdit to split your window
let g:UltiSnipsEditSplit="vertical"

" Disable <tab> and use <ctrl-N< and <ctrl-P> instead
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

let g:ulti_expand_or_jump_res = 0 "default value, just set once
function! Ulti_ExpandOrJump_and_getRes()
    call UltiSnips#ExpandSnippetOrJump()
    return g:ulti_expand_or_jump_res
endfunction

inoremap <CR> <C-R>=(Ulti_ExpandOrJump_and_getRes() > 0)?"":"\n"<CR>


"** Disable Syntastic by default and toggle error checking with <meta> S
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
nnoremap <leader>S :SyntasticCheck<CR> :SyntasticToggleMode<CR>





"** View text file in two columns
"   Activate with <leader>vs Deactivate with ctrl-W then o
:noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

"** Goyo - Distraction-free writing in Vim
""  Toggle full-screen, less cluttered mode
nnoremap <F10> :Goyo<cr>


"** Syntastic related. Basically the recommended defaults. Use ':help syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1 " put detected errors in list
let g:syntastic_auto_loc_list = 1            " auto close/open location list
let g:syntastic_check_on_open = 0            " do not check when loading buffers
let g:syntastic_check_on_wq = 0              " do not check when writing buffers
