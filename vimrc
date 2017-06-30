"let g:loaded_youcompleteme = 1
let g:ctrlp_map = '<F2>'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard -- [^ft]*/']

let g:tmux='build'
let g:tlist_rs_settings='rust;b:bibitem;c:command;l:label'
let g:Tlist_Auto_Highlight_Tag=1
execute pathogen#infect()

let g:alternateExtensions_cxx = "hxx"
let g:alternateExtensions_hxx = "cxx"

colors jellybeans
filetype indent on
filetype plugin on
syntax on
behave xterm
se ar aw nu et ts=4 sw=4 nosol so=5 diffopt=filler,iwhite,vertical si hls ut=400 nows nowrap sc ic scs modeline
setglobal undodir=/home/sehe/WORK/.vimundo 
setglobal undofile
se isfname-==

"se guifont=Monospace\ 12
se guifont=Hack\ 11

let VCSCommandDeleteOnHide=1

nnoremap <leader>g  :YcmCompleter GoTo<CR>
nnoremap <leader>t  :YcmCompleter GetType<CR>
nnoremap <leader>fi :YcmCompleter FixIt<CR>
" F4
nnoremap <F4> :cnext<CR>
nnoremap <S-F4> :cprev<C-m>
" F5
nnoremap <F5> :lnext<CR>
nnoremap <S-F5> :lprevious<CR>
" F9
nnoremap <F9> :A<CR><C-g>
inoremap <F9> <ESC>:A<CR><C-g>

set runtimepath+=/usr/share/lilypond/2.10.33/vim

cabbrev amk mak
cabbrev kma mak

nnoremap <F10> :Dispatch<CR>
inoremap <F10> <C-O>:Dispatch<CR>

nnoremap <F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q [^ft]*/

set showcmd
se mouse=icnr

se go=agi nu complete-=i et sw=4 ts=4 path=.,/usr/local/include,/usr/include,~/custom/boost/

se switchbuf=useopen,usetab

function! ToggleFullScreen()
   call system("wmctrl -i -r ".v:windowid." -b toggle,fullscreen")
   redraw
endfunction

nnoremap <M-f> :call ToggleFullScreen()<CR>
inoremap <M-f> <C-\><C-O>:call ToggleFullScreen()<CR>

" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre  *.raw let &bin=1
    au BufReadPost *.raw if &bin | %!xxd
    au BufReadPost *.raw set ft=xxd | endif
    au BufWritePre *.raw if &bin | %!xxd -r
    au BufWritePre *.raw endif
    au BufWritePost *.raw if &bin | %!xxd
    au BufWritePost *.raw set nomod | endif
augroup END

let g:netrw_liststyle = 3
let g:ycm_always_populate_location_list = 1
let g:ycm_open_loclist_on_ycm_diags = 0
let g:ycm_extra_conf_globlist = [ '~/WORK/pocpp/*' ]
let g:ycm_confirm_extra_conf              = 0
let g:ycm_min_num_of_chars_for_completion = 1
let g:ycm_seed_identifiers_with_syntax    = 0

se path+=~/custom/boost/
nnoremap <Leader>tub cib=MakeTinyURL(@")
vnoremap <Leader>tu c=MakeTinyURL(@")
nnoremap <C-s> :update!
inoremap <C-s> :update!
nnoremap <C-S> :update!
inoremap <C-S> :update!


" let's fool around
nmap <leader>gl :Gist -l<CR>
let g:gist_show_privates = 1
let g:gist_list_vsplit = 1
let g:gist_detect_filetype = 1
let g:gist_get_multiplefile = 1

function! RelaunchVim()
    silent! exec '!(sleep 3; gvim -S ' . v:this_session . ')&'
    qa
endfunction

function! GotoProto() 
    let name = expand('%:t')
    if name =~ '\v.*\.pb\.(h|cpp)'
        let name = substitute(name, '\v.pb.(h|cpp)$', '.proto', '')
        "silent! exec 'buf ' . name
        silent! exec 'find ' . name
    else
        echo "Not a protobuf file"
    endif
endfunction

nnoremap <F7> :Gstatus <Bar> wincmd K<CR>
nnoremap <F8> :call GotoProto()<CR>

function! EpochMicrosToTimestamp()
    return system('date -d @' . (expand('<cword>') / 1000000) . ' +"%Y-%m-%dT%H:%M:%S"')
endfunction

function! EpochToTimestamp()
    return system('date -d @' . expand('<cword>') . ' +"%Y-%m-%dT%H:%M:%S"')
endfunction

se makeprg=make\ -C\ ../build
"se makeprg=make\ -C\ ../build\ tests/test_runner
set fillchars+=vert:│
hi VertSplit cterm=NONE
let g:gitgutter_diff_args = '-w'

se path+=common/src
se path+=common/src/protobuf

function! g:Undotree_CustomMap()
    nmap <buffer> J <plug>UndotreeGoNextState
    nmap <buffer> K <plug>UndotreeGoPreviousState
endfunc

" F6
nnoremap <F6> :UndotreeShow<Bar>UndotreeFocus<CR>

inoremap <expr>  <C-K>   HUDG_GetDigraph()                            ##

autocmd BufReadPre fugitive:///* let b:ycm_largefile=1

" testing this again
"se wildmode=longest:full,list:full
"se wildmenu

command! StripTrailingWhitespace keeppatterns %s/\s\+$//ge
nnoremap <silent> <leader>b :CommandTMRU<CR>
" when trawling git logs/blames, when you entered an individual side-by-side
" diff, close the diff and return to the containing commit
nmap ZD hZZC

nmap <leader>SQL /LIKE<CR>?AND<CR>y%:%s/\V<C-r>"/%clause%/g<CR>ggOclause=<Esc>p:w<Bar>ne<CR>

nmap [32~ :grep -RI  */

" autocmd FileType c,cpp setlocal equalprg=clang-format-3.8
" your favorite style options
"let g:clang_format#auto_formatexpr=1
let g:clang_format#style_options = {
      \ "AccessModifierOffset" : -4,
      \ "AllowShortIfStatementsOnASingleLine" : "true",
      \ "AlwaysBreakTemplateDeclarations" : "true",
      \ "Standard" : "C++14"}

augroup ClangFormatSettings
    autocmd!
    " map to <Leader>cf in C++ code
    autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
    " if you install vim-operator-user
    autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
augroup END

nnoremap <F3> :silent! !killall make<CR>
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m
