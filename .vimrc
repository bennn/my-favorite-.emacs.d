set background=dark
set tabstop=2
set shiftwidth=4
set expandtab
set ai
set cc=81
set list
"line numbers
set nu
" Display these characters differently
set listchars=tab:» ,trail:.
",eol:Â¶
syntax on
"status at bottom right
set ruler
"highlight columns over 80 chars
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
" map F5 to compiling latex, only inline
":map <F5> :w <CR> :!pdflatex <file> <CR>
