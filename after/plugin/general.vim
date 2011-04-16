let Tlist_Ctags_Cmd = "/usr/bin/ctags-exuberant"
let Tlist_Inc_Winwidth = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_File_Fold_Auto_Close = 1
let Tlist_Process_File_Always = 1
let Tlist_Enable_Fold_Column = 0
let tlist_php_settings = 'php;c:class;d:constant;f:function'
if exists('loaded_taglist')
  nmap <silent> <F9> :TlistToggle<CR>
  nmap <silent> <F8> :TlistOpen<CR>
endif
if exists('loaded_snippet')
  imap <C-B> <Plug>Jumper
endif
"inoremap <Tab> <C-R>=MyTabOrComplete()<CR>
