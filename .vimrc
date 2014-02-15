set title
set background=light
set tabstop=2
set shiftwidth=2
set expandtab
set ai
set list
set listchars=tab:» 
set nu
filetype plugin indent on
",trail:�
",eol:¶
syntax on
" set syntax for non-standard extensions
au BufNewFile,BufRead *.jl set filetype=java
au BufNewFile,BufRead *.coffee set filetype=javascript
"line numbers
"set nu
"status at bottom right
set ruler
"highlight columns over 80 chars
""highlight OverLength ctermbg=red ctermfg=white guibg=#592929
""match OverLength /\%81v.\+/
"Jump to last cursor position
"\ if ! exists("g:leave_my_cursor_position_alone") |
"\ if line("'\"") > 0 && line ("'\"") <= line("$") |
"\ exe "normal g'\"" |
"\ endif |
"\ endif
"nmap ; :
"imap jj <ESC> 

"COMMENT SELECTION : 
"  C-v to select (do not use V), 
"  I to insert at the beginning of the line
"  enter comment syntax (every MF time)
"  hit ESC, watch the magic happen slowly

""" VUNDLE
set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My bundles here:
"
" original repos on GitHub
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
" non-GitHub repos
Bundle 'git://git.wincent.com/command-t.git'
" Git repos on your local machine (i.e. when working on your own plugin)
Bundle 'file:///Users/gmarik/path/to/plugin'
" ...
Bundle 'https://github.com/atn34/cubex.vim'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install (update) bundles
" :BundleSearch(!) foo - search (or refresh cache first) for foo
" :BundleClean(!)      - confirm (or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle commands are not allowed.
