" Folding cheet sheet
" zR open all folds
" zM close all folds
" za toggle fold at cursor position
" zj move down to start of next fold
" zk move up to end of previous fold
" Manage plugins. {{{1

" Pathogen - plugin management 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible

colorscheme slate
"set background=dark
"colorscheme solarized

set showcmd
set showmode
syntax on
set background=dark
set hlsearch
set history=1000
set nobackup
set hidden
set exrc     " enable per-directory .vimrc files
set secure   " disable unsafe commands in local .vimrc files

" ctags - search for the tagfile up the directories until one is found
set tags=tags;/



" remember all of these between sessions, but only 10 search terms; also
" remember info for 10 files, but never any on removable disks, don't remember
" marks in files, don't rehighlight old search patterns, and only save up to
" 100 lines of registers; including @10 in there should restrict input buffer
" but it causes an error for me:
set viminfo=/10,'10,r/mnt/zip,r/mnt/floppy,f0,h,\"100

" have command-line completion <Tab> (for filenames, help topics, option names)
" first list the available options and complete the longest common part, then
" have further <Tab>s cycle through the possibilities:
set wildmode=list:longest,full

set nomodeline
"set nowrap


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \ exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent " always set autoindenting on

endif " has("autocmd")



" use indents of 2 spaces, and have them copied down lines:
set shiftwidth=4
set shiftround
set expandtab
"set autoindent
set smartindent
set tabstop=4
set number

" Better Command completion
set wildmenu
set wildmode=list:longest

" Intuitive backspacing in insert mode
set backspace=indent,eol,start

" normally don't automatically format `text' as it is typed, IE only do this
" with comments, at 79 characters:
set formatoptions-=t
"set textwidth=79

" for CSS, also have things in braces indented:
autocmd FileType css set smartindent

" for HTML, generally format text, but if a long line has been created leave it
" alone when editing:
autocmd FileType html set formatoptions+=tl

" for both CSS and HTML, use genuine tab characters for indentation, to make
" files a few bytes smaller:
autocmd FileType html,css set noexpandtab tabstop=2

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

set ruler
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
let php_folding=0
set scrolloff=5
set expandtab
"set nowrap
set preserveindent

" Smarty syntax
"au BufRead,BufNewFile *.tpl set filetype=smarty 
"au Filetype smarty exec('set dictionary=/home/risko/.vim/syntax/smarty.vim')
"au Filetype smarty set complete+=k


" Taglist - jump on toggle
let Tlist_GainFocus_On_ToggleOpen = 1


let g:proj_flags="imstvcg"

set lines=50 columns=100


" Enable Zen coding bliss
autocmd FileType html source ~/.vim/scripts/sparkup.vim
autocmd BufRead *.tpl source ~/.vim/scripts/sparkup.vim
autocmd BufRead *.php source ~/.vim/scripts/sparkup.vim
autocmd BufRead *.phtml source ~/.vim/scripts/sparkup.vim
autocmd BufRead *.ctp source ~/.vim/scripts/sparkup.vim

"fun ActivateAddons()
"  set runtimepath+=~/vim-addons/vim-addon-manager
"  try
"    call scriptmanager#Activate([])
"  catch /.*/
"    echoe v:exception
"  endtry
"endf
"call ActivateAddons()
" experimental: run after gui has been started
" report breakage in this case, please
" au GUIEnter * call Activate()

" window position
winpos 0 0

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

" Auto removal of trailing white spaces in PHP
" autocmd BufEnter *.php :%s/\s\+$//e

" Folding
"augroup vimrc
"  au BufReadPre * setlocal foldmethod=indent
"  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
"augroup END

"folding settings
"set foldmethod=indent   "fold based on indent
"set foldnestmax=10      "deepest fold is 10 levels
"set nofoldenable        "dont fold by default
"set foldlevel=1         "this is just what i use

" SuperTab plugin settings
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

:set diffopt=filler
:set diffopt+=iwhite
":set diffopt+=horizontal

" minbufexpl settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 


" TaskList settings
let g:tlTokenList = ["FIXME", "TODO", "XXX", "@todo"]



let mapleader = ","

"***************************
"
" Shortcut mappings
"
"***************************

"noremap <C-T> <Esc>:tabnew<CR>
inoremap <C-space> <C-X><C-O>

" Moving lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv


" close current buffer
noremap <leader>bc <Esc>:bdelete<CR>

" NERTree toggle
map <F11> <Esc>:NERDTreeToggle<CR>

" Taglist
map <F9> <Esc>:TlistToggle<CR>

" Show registers
nnoremap <silent> <F4> :YRShow<CR> 

" Gundo - currently n/a
"nnoremap <F5> :GundoToggle<CR>

" Snipmate mappings
" defined in after/plugin/snipMate.vim
" <tab> is remapped to <c-x>


" Zencoding settings
let g:user_zen_leader_key = '<c-space>'

" Supertab mappings
" default

" PhpDocumentor
inoremap <F3> <ESC>:call PhpDocSingle()<CR>i
nnoremap <F3> :call PhpDocSingle()<CR>
vnoremap <F3> :call PhpDocRange()<CR>


" run file with PHP CLI (CTRL-M)
:autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>

" PHP parser check (CTRL-L)
:autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>

" Folding
nnoremap <space> za
vnoremap <space> zf

" minbufexpl mapping

" Debugger mappings
nnoremap <Leader>dr :python debugger_resize()<cr>
nnoremap <F7> :python debugger_command('step_into')<cr>
nnoremap <Leader>do :python debugger_command('step_over')<cr>
nnoremap <F8> :python debugger_command('step_out')<cr>

nnoremap <Leader>dc :python debugger_context()<cr>
nnoremap <F11> :python debugger_property()<cr>
nnoremap <Leader>dp :python debugger_property()<cr>
nnoremap <Leader>dcg :python debugger_watch_input("context_get")<cr>A<cr>
nnoremap <Leader>dpg :python debugger_watch_input("property_get", '<cword>')<cr>A<cr>

" TaskList mappings
map <leader>d <Plug>TaskList

" YankRing mappings
" temporary fix to prevent YR from stealing dd mapping
let g:yankring_n_keys = 'x yy yw dw ye de yE dE yiw diw yaw daw y$ d$ Y D yG dG ygg dgg'

" Spell checking
nmap <silent> <leader>s :set spell!<CR>
set spelllang=en_us

" Invisible characters
nmap <silent> <leader>l :set list!<CR>

noremap <c-t> :tabnew<CR>

set pastetoggle=<F2>

" Clear search hilites
nmap <silent> ,/ :nohlsearch<CR>

" Sudo save after file has been opened by a regular user
cmap w!! w !sudo tee % >/dev/null

" PhpDocumentor
let g:pdv_cfg_Author = "Richard Laffers <rlaffers@gmail.com>"
let g:pdv_cfg_Copyright = "Copyright 2011 Richard Laffers"
let g:pdv_cfg_License = "The MIT License {@link http://www.opensource.org/licenses/mit-license.php}"

