" unmap in insert mode" This line should not be removed as it ensures that
" various options are properly set to work with the Vim-related packages
" available in Debian.
runtime! debian.vim


" /______ SETUP VUNDLE ________________________________________________________/
" setup prereqs, include Vundle in runtime path and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" /______ <PLUGINS> ___________________________________________________________/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'              " let Vundle manage Vundle, required
Plugin 'majutsushi/tagbar.git'          " taglist for code navigation
Plugin 'scrooloose/nerdtree.git'        " NERDTree
Plugin 'bling/vim-airline'              " vim-airline
Plugin 'kien/ctrlp.vim'                 " Full path fuzzy file/buffer/.. finder
Plugin 'sjl/badwolf.git'                " Color Scheme
Plugin 'Valloric/YouCompleteMe.git'     " YouCompleteMe
Plugin 'SirVer/ultisnips'               " ultisnips
Plugin 'honza/vim-snippets'             "
Plugin 'tpope/vim-fugitive'             " fugitive
Plugin 'junegunn/goyo.vim'              " distraction free mode
Plugin 'scrooloose/nerdcommenter'       " code commenting

call vundle#end()
" /______ </PLUGINS> __________________________________________________________/

filetype plugin indent on               " use indentation scripts (required(?))
                                        " To ignore plugin indent changes,
                                        " instead use: filetype plugin on

" /______ PLUGIN SPECIFIC _____________________________________________________/
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py" " semantic stuffs

" /______ MISC. BASICS ________________________________________________________/
set mouse=a                 " enable mouse usage (all modes)
set showcmd                 " show (partial) command in status line.
set history=1000            " extend command line history
set autowrite               " automatically save before commands like :next:make
set autoread                " automatically read file when changed outside vim
set hidden                  " hide buffers when they are abandoned
set nowrap                  " no linewrapping
set vb                      " visual bell I.E. no beeping
set keywordprg=trans\ :sv   " translate with google translate via translateshell
                            " (Shift-K to view translation of word under cursor)
syntax enable               " enable syntax highlighting
autocmd BufEnter * cd %:p:h " automatically change current directory to file dir

" Jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" /______ TEMPORARY FILES _____________________________________________________/
set undodir=~/.vim/.undo//          " alternatively, disable with:
set backupdir=~/.vim/.backup//      " set nobackup
set directory=~/.vim/.swp//         " set noswapfile

" /______ INDENTATION _________________________________________________________/
set autoindent              " keep indentation from previous line
set smartindent             " some automation, support for C-type files
set expandtab               " always insert softtabstop amount of chars
set shiftwidth=4
set tabstop=4
set softtabstop=4

" /______ SEARCH ______________________________________________________________/
set hlsearch                " highlight search
set ignorecase              " searches are case insensitive..
set smartcase               " .. unless they contain at least one capital letter
set incsearch               " incremental search, show results while typing.

" /______ VISUAL ______________________________________________________________/
set cursorline                  " highlight current line
set number                      " show line numbers
set showmatch                   " show matching brackets.
set ruler                       " show column and row in footer
set list                        " show whitespace
set listchars=tab:▸\ ,eol:¬     " show tabs with ▸, eol with ¬
set laststatus=2                " add full file path to your existing statusline
set t_Co=256                    " 256 color support

" highlight column 80 using colorcolumn if available
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

" Set colorscheme and bring back transparency
colorscheme badwolf
hi Normal ctermbg=NONE
hi Normal guibg=NONE

" File type syntax highlighting aliases
au BufRead,BufNewFile *.ino set filetype=c                      " arduino
au BufRead,BufNewFile *.md set filetype=markdown                " markdown
au BufRead,BufNewFile *.kicad_mod,*.kicad_pcb set filetype=lisp " kicad
autocmd BufRead *.tab set filetype=tab                          " guitar tabs

" Enable powerline fonts and enhanced tabline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" /______ KEYBINDINGS _________________________________________________________/
let mapleader='§'               " remap leader to § (key below ESC, above tab)
let leader='§'

" Easier moving of code blocks (Vim as Python IDE - Martin Brochhaus)
vnoremap < <gv
vnoremap > >gv

" Ctrl-j/k deletes blank line below/above if it is blank, and Alt-j/k inserts.
nnoremap <silent><C-j> m`:silent +g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><C-k> m`:silent -g/\m^\s*$/d<CR>``:noh<CR>
nnoremap <silent><A-j> :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <silent><A-k> :set paste<CR>m`O<Esc>``:set nopaste<CR>

noremap <C-l> :bnext<cr>
noremap <C-h> :bprevious<cr>
nnoremap <F3> :set paste!<cr>
map <leader>n :NERDTreeToggle<CR>
map <C-p>     :CtrlPMixed<CR>
map <leader>t :TagbarToggle<CR>

" unmap the arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

:nnoremap <F5> "=strftime("%Y-%m-%d %A %H:%M")<CR>
:inoremap <F5> <C-R>=strftime("%Y-%m-%d %A %H:%M")<CR>

imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i
imap <leader>{ {}<ESC>i

" Strip all trailing whitespace in current file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Tab for snippets, Ctrl-n and Ctrl-p for next/previous YCM.
"let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
"let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']
"let g:UltiSnipsExpandTrigger="<Tab>"
"let g:UltiSnipsJumpForwardTrigger="<Tab>"
"let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

" View text file in two columns. Activate with <leader>vs Deactivate with ctrl-W then o
:noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>
