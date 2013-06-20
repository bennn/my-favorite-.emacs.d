setopt VI
bindkey -e
PS1=$'%{\e[1;32m%}%n@%m%{\e[0m%}:%B%~/%b >%# '

alias python='ipython'
alias gnome-open=open
alias ocaml='ledit ocaml'
alias gits='git status'
# really clear. Kill all stored text
alias clearall='printf "\033c"'

export EDITOR="vi"
setopt autocd

# clear & color
function paint {
    local lines columns colour a b p q i pnew
        ((columns=COLUMNS-1, lines=LINES-1, colour=2))
        for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
            for ((a=-2.0; a<=1; a+=3.0/columns)) do
                echo -n "\\e[4${colour}m "
                ((colour=(colour % 6)+3))
            done
            echo
        done
}
function _clear {
    paint
    clear
}
alias clear=_clear

#mandlebrot fractal
function mandlebrot_zsh {
    local lines columns colour a b p q i pnew
        ((columns=COLUMNS-1, lines=LINES-1, colour=0))
        for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
            for ((a=-2.0; a<=1; a+=3.0/columns)) do
                for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
                    ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
                        done
                        ((colour=(i/4)%8))
                        echo -n "\\e[4${colour}m "
                        done
                        echo
                        done
}


#Opens files to edit in vim. If root is owner, obtains root permissions
function vim {
    LIMIT=$#
    for ((i = 1; i <= $LIMIT; i++ )) do
    eval file="\$$i"
    if [[ -e $file && ! -O $file ]]
    then
        otherfile=1
    else

    fi
    done
    if [[ $otherfile = 1 ]]
    then
        sudo vi "$@"
    else
        command vi "$@"
    fi
}

