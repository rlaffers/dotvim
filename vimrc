" Manage plugins. {{{1

" Pathogen - plugin management 
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set nocompatible
set guifont=Inconsolata\ Medium\ 16
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
set tags=.tags;/

set statusline=%M%h%y\ %t\ %F\ %p%%\ %l/%L\ %=[%{&ff},%{&ft}]\ [a=\%03.3b]\ [h=\%02.2B]\ [%l,%v]

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
 
  augroup markdown
      au!
      au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
  augroup END

  au BufNewFile,BufRead *.volt set filetype=volt
  au BufNewFile,BufRead *.volt set syntax=html
  

else

  set autoindent " always set autoindenting on

endif " has("autocmd")



" use indents of 4 spaces, and have them copied down lines:
set shiftwidth=4
set shiftround
set expandtab
"set nowrap
set preserveindent

"set autoindent
set smartindent
"set cindent
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

"autocmd FileType sql set cursorcolumn

" make searches case-insensitive, unless they contain upper-case letters:
set ignorecase
set smartcase

" show the `best match so far' as search strings are typed:
set incsearch

set ruler
let php_sql_query=1
let php_htmlInStrings=1
let php_noShortTags=1
set scrolloff=5

" Smarty syntax
"au BufRead,BufNewFile *.tpl set filetype=smarty 
"au Filetype smarty exec('set dictionary=/home/risko/.vim/syntax/smarty.vim')
"au Filetype smarty set complete+=k


" Taglist - jump on toggle
let Tlist_GainFocus_On_ToggleOpen = 1


let g:proj_flags="imstvcg"

set lines=50 columns=100


" Enable Zen coding bliss
"autocmd FileType html source ~/.vim/scripts/sparkup.vim
"autocmd BufRead *.tpl source ~/.vim/scripts/sparkup.vim
"autocmd BufRead *.php source ~/.vim/scripts/sparkup.vim
"autocmd BufRead *.phtml source ~/.vim/scripts/sparkup.vim
"autocmd BufRead *.ctp source ~/.vim/scripts/sparkup.vim

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
"autocmd FileType php set keywordprg=pman
autocmd FileType c set omnifunc=ccomplete#Complete


" Auto removal of trailing white spaces in PHP
" autocmd BufEnter *.php :%s/\s\+$//e

let mapleader = ","
let maplocalleader = "\\"

"
" Folding
"
" Folding cheet sheet
" zR open all folds
" zM close all folds
" za toggle fold at cursor position
" zj move down to start of next fold
" zk move up to end of previous fold

let php_folding=0
"set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1

" session manager autosave
let g:sessionman_save_on_exit=1

" saves the last session upon closing vim
fu! SessionAutoSave()
    if !exists('g:sessionman_save_on_exit')
	    let g:sessionman_save_on_exit = 1
    endif

    if exists('g:LAST_SESSION')
        return
    endif

	echo 'saving the session into ~/.vim/sessions/_autosave'

    if g:sessionman_save_on_exit
        "execute 'call mkdir(%:p:h/.vim)'
        execute 'mksession! $HOME/.vim/sessions/_autosave'
    endif
endfunction

" for restoring sessions
fu! SessionRestoreLast()
    if exists('g:LAST_SESSION')
        let s:session_name=g:LAST_SESSION
    else
        let s:session_name="_autosave"
    endif

    let s:session_file_path=$HOME . '/.vim/sessions/' . s:session_name
    echo s:session_file_path
    if !filereadable(s:session_file_path)
        echo "Session file " . s:session_name . " not found!"
        return
    endif

    echo 'restoring session from ' . s:session_name
    execute 'SessionOpen ' . s:session_name 
endfunction

autocmd VimLeave * :call SessionAutoSave()


" If you like the convenience of having Vim define folds automatically 
" by indent level, but would also like to create folds manually, you can get both by
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

nnoremap <space> za
vnoremap <space> zf
"map <Leader>f :set foldmethod=indent<cr>zM<cr>
"map <Leader>fc :set foldmethod=manual<cr>zR<cr>



" SuperTab plugin settings
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextDefaultCompletionType = "<c-p>"
"let g:SuperTabMappingForward = "<tab>"
"let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
"let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

set diffopt=filler
set diffopt+=iwhite
":set diffopt+=horizontal

" minbufexpl settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1 


" TaskList settings
let g:tlTokenList = ["FIXME", "TODO", "XXX", "@todo"]




"***************************
"
" Shortcut mappings
"
"***************************

"noremap <C-T> <Esc>:tabnew<CR>
inoremap <C-space> <C-X><C-O>
inoremap <S-space> <C-X><C-K>

" Moving lines
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv
" alternative Escape key
inoremap jj <esc>
" disable the Escape key to train myself to use "jj"
"inoremap <esc> <nop>

" close current buffer
noremap <leader>bc <Esc>:bdelete<CR>

noremap <leader>os <Esc>:SessionList<CR>
" open the last saved session
noremap <leader>oo :call SessionRestoreLast()<CR>

"NERTree toggle
noremap <F11> <Esc>:NERDTreeToggle<CR>

" Taglist
"map <F9> <Esc>:TlistToggle<CR>

" Show registers
"nnoremap <silent> <F4> :YRShow<CR> 

" toggle scrollbind for the current window
noremap <leader>sb <Esc>:set scb!<CR>

" Gundo - currently n/a
"nnoremap <F5> :GundoToggle<CR>

" UndoTree
nnoremap <Leader>u :UndotreeToggle<cr>

" Snipmate mappings
" defined in after/plugin/snipMate.vim
" <tab> is remapped to <c-x>
"let g:snips_author = 'Richard Laffers <rlaffers@gmail.com'
"let g:snips_trigger_key='<F1>'
"inoremap <silent> <c-d> <c-g>u<c-r>=snipMate#TriggerSnippet()<cr>
"snoremap <silent> <c-d> <esc>i<right><c-r>=snipMate#TriggerSnippet()<cr>
"inoremap <silent> <a-d> <c-r>=snipMate#BackwardsSnippet()<cr>
"snoremap <silent> <a-d> <esc>i<right><c-r>=snipMate#BackwardsSnippet()<cr>
"inoremap <silent> <c-r><F1> <c-r>=snipMate#ShowAvailableSnips()<cr>

" UltiSnips
set runtimepath+=~/.vim/bundle/ultisnips
let g:snips_author = 'Richard Laffers <rlaffers@gmail.com'
let g:UltiSnipsExpandTrigger='<c-d>'
let g:UltiSnipsListSnippets='<c-e>'
let g:UltiSnipsJumpForwardTrigger='<c-d>'
let g:UltiSnipsJumpBackwardTrigger='<c-b>'
let g:UltiSnipsSnippetDirectories=['bundle/ultisnips/UltiSnips']
"autocmd FileType html UltiSnipsAddFiletypes html.css.javascript.php
"autocmd FileType css UltiSnipsAddFiletypes css
"autocmd FileType javascript UltiSnipsAddFiletypes javascript.javascript_jasmine.json
"autocmd FileType php UltiSnipsAddFiletypes php
"autocmd FileType sh UltiSnipsAddFiletypes sh
"autocmd FileType vim UltiSnipsAddFiletypes vim
"autocmd FileType xml UltiSnipsAddFiletypes xml
"autocmd BufRead *.tpl source ~/.vim/scripts/sparkup.vim
autocmd FileType * call UltiSnips_FileTypeChanged()



" Zencoding settings
let g:user_zen_leader_key = '<c-space>'




" run file with PHP CLI (CTRL-M)
:autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>

" run file with node.js (CTRL-M)
:autocmd FileType javascript noremap <C-M> :w!<CR>:!/usr/bin/node %<CR>

" PHP parser check (CTRL-L)
:autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>


" minbufexpl mapping

" Debugger mappings - requires `dbgp` plugin
"nnoremap <Leader>dr :python debugger_resize()<cr>
"nnoremap <F6> :python debugger_command('step_over')<cr>
"nnoremap <F7> :python debugger_command('step_into')<cr>
"nnoremap <C-F7> :python debugger_command('step_out')<cr>
"nnoremap <Leader>do :python debugger_command('step_over')<cr>
"nnoremap <C-F5> :python debugger_quit()<cr>
"nnoremap <Leader>dc :python debugger_context()<cr>
"nnoremap <F11> :python debugger_property()<cr>
"nnoremap <Leader>dp :python debugger_property()<cr>
"nnoremap <Leader>dcg :python debugger_watch_input("context_get")<cr>A<cr>
"nnoremap <Leader>dpg :python debugger_watch_input("property_get", '<cword>')<cr>A<cr>
"nnoremap <Leader>bp :python debugger_mark('<args>')<cr>
"nnoremap <C-F8> :python debugger_mark('<args>')<cr>
"let g:debuggerProxyKey = 'php-xdebug'

" PhpDocumentor
inoremap <F3> <ESC>:call PhpDocSingle()<CR>i
nnoremap <F3> :call PhpDocSingle()<CR>
vnoremap <F3> :call PhpDocRange()<CR>


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

" Lusty Juggler
nmap <silent> <Leader>j :LustyJuggler<CR>

set pastetoggle=<F2>
" the same as above for normal mode
nnoremap <F2> :set invpaste paste?<CR>

" Clear search hilites
nmap <silent> ,/ :nohlsearch<CR>

" Sudo save after file has been opened by a regular user
cmap w!! w !sudo tee % >/dev/null

" PhpDocumentor
let g:pdv_cfg_Author = "Richard Laffers <richard.laffers@movys.sk>"
let g:pdv_cfg_Copyright = "Copyright 2013 MOVYS a.s."
let g:pdv_cfg_License = "The MIT License {@link http://www.opensource.org/licenses/mit-license.php}"
let g:pdv_cfg_Version = "$version$"

" Number of lines for the large file PHP mode (some syntax features disabled
let php_large_file = 5000

" CommandT settings
set wildignore+=docs/**,*.swp,*.png,*.gif,*.jpg
nmap <Leader>fl :CommandTFlush<CR>

" disable arrows for navigation
"inoremap  <Up>     <NOP>
"inoremap  <Down>   <NOP>
"inoremap  <Left>   <NOP>
"inoremap  <Right>  <NOP>
"noremap   <Up>     <NOP>
"noremap   <Down>   <NOP>
"noremap   <Left>   <NOP>
"noremap   <Right>  <NOP>


" bash-support plugin
filetype plugin on

" autocorrection of common spelling typos
command Autocorrect source ~/.vim/bundle/autocorrect/autocorrect.vim

" autoinsert closing parentheses and brackets and define CTRL+J as a get-out key
inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i
inoremap { {}<Esc>:let leavechar="}"<CR>i
imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a

" search in files
nmap gr :grep <cword> *<CR>
nmap gr :grep <cword> %:p:h/*<CR>
nmap gR :grep \b<cword>\b *<CR>
nmap GR :grep \b<cword>\b %:p:h/*<CR>

"map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git --exclude-from=exclude.list . -e " . expand("<cword>") . " " <bar> cwindow<CR>
map <F4> :execute " grep -srnw --binary-files=without-match --exclude-dir=.git . -e " . expand("<cword>") . " " <bar> cwindow<CR>

"command! -nargs=+ MyGrep execute 'silent grep! <args>' | copen 33

" all EasyGrep commands start with <leader>f
let EasyGrepMode = 2
let g:EasyGrep_key_for_grep_current_v = '<Leader>fv'
let g:EasyGrep_key_for_grep_current_V = '<Leader>fV'
let g:EasyGrep_key_for_options = '<Leader>fo'
let g:EasyGrep_key_for_grep_current_a = '<Leader>fa'
let g:EasyGrep_key_for_grep_current_A = '<Leader>fA'
let g:EasyGrep_key_for_replace_current_r = '<Leader>fr'
let g:EasyGrep_key_for_replace_current_R = '<Leader>fR'

" Fugitive
nnoremap <Leader>gh :help fugitive<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>gll :Gllog<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>grm :Gremove<CR>
nnoremap <Leader>gmv :Gmove<CR>
nnoremap <Leader>gbl :Gblame<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gg :Ggrep 
" search in changes to source code
nnoremap <Leader>gft :Glog -S
" search in commit messages
nnoremap <Leader>gfc :Glog --grep


" Syntastic
" TODO treba nakonfigurovat phpcs a phpmd rules, teraz su oba vypnute
noremap <leader>zc <Esc>:SyntasticCheck<CR>
noremap <leader>zt <Esc>:SyntasticToggle<CR>
noremap <leader>ze <Esc>:Errors<CR>
let g:syntastic_check_on_open=0
let g:syntastic_echo_current_error=1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
"let g:syntastic_php_checkers=['php', 'phpcs', 'phpmd']
let g:syntastic_php_checkers=['php']
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['php'] }
let g:syntastic_mode_map = { 'passive_filetypes': ['css'] }
"set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
"set statusline=%*
let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'



let php_sql_query = 1                                                                                        
let php_htmlInStrings = 1

" neocomplcache plugin (auto completion)
" Enable AutoComplPop.
let g:acp_enableAtStartup = 1
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" required by db tools
let $ORACLE_HOME="/usr/lib/oracle/current"
let $LD_LIBRARY_PATH="/usr/lib/oracle/current/client64/lib"
"let $ORACLE_HOME="/opt/instantclient"
"let $LD_LIBRARY_PATH="/opt/instantclient"
" path to tnsnames.ora
let $TNS_ADMIN="/home/laffers/.oracle"
let $TWO_TASK="MONITOR"
let $SQLPATH="/home/laffers/.sqlplus"
let $NLS_LANG="AMERICAN_AMERICA.UTF8"


" SQLUtilities
let g:sqlutil_align_where = 1
let g:sqlutil_align_comma = 1
let g:sqlutil_align_keyword_right = 1
let g:sqlutil_align_first_word = 0
let g:sqlutil_keyword_case = '\U'

" Align plugin
" Override default mappings because they conflict with CommandT
map <Leader>att <Plug>AM_tt
map <Leader>atsq <Plug>AM_tsq
map <Leader>atsp <Plug>AM_tsp
map <Leader>atml <Plug>AM_tml
map <Leader>atab <Plug>AM_tab
map <Leader>at@ <Plug>AM_t@
map <Leader>at~ <Plug>AM_t~
map <Leader>at? <Plug>AM_t?
map <Leader>ats= <Plug>AM_ts=
map <Leader>ats< <Plug>AM_ts<
map <Leader>ats; <Plug>AM_ts;
map <Leader>ats: <Plug>AM_ts:
map <Leader>ats, <Plug>AM_ts,
map <Leader>at= <Plug>AM_t=
map <Leader>at< <Plug>AM_t<
map <Leader>at; <Plug>AM_t;
map <Leader>at: <Plug>AM_t:
map <Leader>at, <Plug>AM_t,
map <Leader>at# <Plug>AM_t#
map <Leader>at| <Plug>AM_t|


" dbext
nmap <C-Enter> :DBExecSQLUnderCursor<CR>
vmap <C-Enter> :DBExecVisualSQL<CR>
nnoremap <unique> <S-CR> <Plug>DBExecSQLTopX
"nmap <F2> :DBPromptForBufferParameters<CR>

nmap <Leader>sff :DBCompleteTable<CR>
let g:dbext_default_profile_TMCOMMON         = 'type=ORA:user=common:passwd=ComMov'
let g:dbext_default_profile_TMCOMMONdbi     = 'type=DBI:user=common:passwd=ComMov:driver=Oracle:driver_parms=AutoCommit=1'

let g:dbext_default_profile_TMHISTORY        = 'type=ORA:user=tmhistory:passwd=tmnh694azd:driver_parms=AutoCommit=1'
let g:dbext_default_profile = 'TMCOMMON'

let g:dbext_default_buffer_lines = 20
let g:dbext_default_always_prompt_for_variables = 1

"autocmd BufRead * DBSetOption variable_def_regex=\(\w\|'\)\@<!?\(\w\|'\)\@<!,\zs\(@\|:\|$\)\a\+\>
"autocmd BufRead * DBSetOption variable_def_regex=\(\w\|'\)\@<!?\(\w\|'\)\@<!,\s\(@\|:\|$\)\a\+\>


" to be run when working on Telemonitor project
fu! InitTelemonitor()
    echohl Title
    echo "Initializing Telemonitor..."
    echohl None
    cd $HOME/Projects/telemonitor-git/src
    let s:cwd=getcwd()
    echo "Current working dir: " . s:cwd
    execute 'CommandTFlush'
    " ignore additional directories to speed up command-t
    let g:wildignore_backup = &wildignore
    set wildignore+=document_root/js/ext/**,document_root/js/ext-4.2.0/**,resources/**
    let g:snips_author = 'Richard Laffers <richard.laffers@movys.sk'
	"set noexpandtab
    " Start telemonitor syncing with D7. The lsyncd-init must exist in your path!
    execute '!lsyncd-init start ~/.lsyncd/telemonitor.conf'
endfunction

fu! DeInitTelemonitor()
    echohl Title
    echo "Deinitializing Telemonitor..."
    echohl None
    " Stop telemonitor syncing with D7. The lsyncd-init must exist in your path!
    execute '!lsyncd-init stop'
    " Set wildignore to its previous value
    if exists('g:wildignore_backup')
        let &wildignore = g:wildignore_backup
    endif
    let g:snips_author = 'Richard Laffers <rlaffers@gmail.com'
	"set expandtab
endfunction

nmap <Leader>x :call InitTelemonitor()<CR>
nmap <Leader>xx :call DeInitTelemonitor()<CR>


" edit a scratch file in /tmp/__scratch__
nmap <Leader>e :e /tmp/__scratch__<CR>
nmap <Leader>es :e /tmp/__scratch__.sql<CR>
nmap <Leader>ep :e /tmp/__scratch__.php<CR>
nmap <Leader>ej :e /tmp/__scratch__.js<CR>
nmap <Leader>eh :e /tmp/__scratch__.html<CR>

" TagBar
nnoremap <F8> <Esc>:TagbarToggle<CR>
let g:tagbar_autoclose = 1
let g:tagbar_left = 1

" MRU
map <Leader>o <Esc>:MRU<CR>

" Rainbow parens
"au VimEnter * RainbowParenthesesToggle
"au Syntax * RainbowParenthesesLoadRound
"au Syntax * RainbowParenthesesLoadSquare
"au Syntax * RainbowParenthesesLoadBraces
"au Syntax * RainbowParenthesesToggleAll
map <Leader>rp <Esc>:RainbowParenthesesToggleAll<CR>

" Ack
nnoremap <Leader>f :Ack 

" Splice (3-way merging)
"let g:splice_prefix="<localleader>"
"let g:splice_initial_scrollbind_grid=1

" Plugin key-mappings.
"imap <C-k>     <Plug>(neocomplcache_snippets_expand)
"smap <C-k>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><C-y>  neocomplcache#close_popup()
"inoremap <expr><C-e>  neocomplcache#cancel_popup()


" to fix syntastic stealing :E mapping to :Error
cmap E<CR> Ex<CR>

" Quickfix window shortcuts
nmap <leader>n <Esc>:cn<CR>
nmap <leader>p <Esc>:cp<CR>
nmap <leader>n0 <Esc>:cr<CR>
nmap <leader>n$ <Esc>:cla<CR>
nmap <leader>n1 <Esc>:cr 1<CR>
nmap <leader>n2 <Esc>:cr 2<CR>
nmap <leader>n3 <Esc>:cr 3<CR>
nmap <leader>n4 <Esc>:cr 4<CR>
nmap <leader>n5 <Esc>:cr 5<CR>

com -nargs=1 Quickjump call QuickJumpTo(<f-args>)
function! QuickJumpTo(num)
  exe ':cr ' . a:num
endfunction

"autocmd! FileType qf nnoremap <buffer> <Enter>
"
" better search and replace
nmap <leader>R <Esc>:%Subvert/<CR>

" rozbehat fuzzy fined

" jshint
noremap <leader>h <Esc>:JSHint<CR>
" check recursively everything in the current directory
"noremap <leader>hd <Esc>:JSHint<CR>


