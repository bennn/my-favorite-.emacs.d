alias ls='ls -G'
alias python='ipython'
# linux only
# alias open='gnome-open'
alias clearall='printf "\033c"'
alias espeak='say'
alias gits='git status'
alias ocaml='rlwrap ocaml' # 'ledit ocaml'
alias ssh_fabian='ssh -t fabian screen -R'
alias ssh_winhome='open smb://smb.cs.cornell.edu/winhome'
alias star_wars='telnet towel.blinkenlights.nl'

# opam
CAML_LD_LIBRARY_PATH="/Users/ben/.opam/system/lib/stublibs:/usr/local/lib/ocaml/stublibs"; export CAML_LD_LIBRARY_PATH;
PERL5LIB="/Users/ben/.opam/system/lib/perl5"; export PERL5LIB;
OCAML_TOPLEVEL_PATH="/Users/ben/.opam/system/lib/toplevel"; export OCAML_TOPLEVEL_PATH;
MANPATH=":/Users/ben/.opam/system/man"; export MANPATH;
PATH="/Users/ben/.opam/system/bin:/Users/ben/.rvm/gems/ruby-1.9.2-p320/bin:/Users/ben/.rvm/gems/ruby-1.9.2-p320@global/bin:/Users/ben/.rvm/rubies/ruby-1.9.2-p320/bin:/Users/ben/.rvm/bin:/usr/local/bin:/usr/local/sbin:/usr/local/mysql/bin:/usr/local/mysql-5.6.5-m8-osx10.6-x86_64/bin:/usr/local/Cellar/libxml2/2.7.8/lib/python2.7/site-packages:/usr/local/lib/python3.3/site-packages:/usr/bin:/bin:/usr/sbin:/sbin:/usr/bin/pdb:/opt/X11/bin:/usr/X11/bin:/usr/local/git/bin:/usr/texbin:/Users/ben/code/3110/cs3110/support/work:/opt/local/bin:/opt/local/sbin:/Volumes/heap/ben/ross/compilers/polyglot-2.5.3-src/bin:/Users/ben/.rvm/bin:/Users/ben/code/andriod-sdk-macosx/tools"; export PATH;

# postgis
export PATH=$PATH:/Applications/PostGIS.app/Contents/MacOS/bin
# export CLASSPATH=$CLASSPATH:/usr/local/lib/antlr-4.1-complete.jar
export TEXMFDIST=/usr/local/texlive/2011/texmf-dist
# geogit
export PATH=$PATH:/Users/ben/code/geogit/GeoGit/src/cli-app/target/geogit/bin
# android
export ANDROID_SDK_ROOT=/usr/local/opt/android-sdk
export PATH=$PATH:~/code/andriod-sdk-macosx/tools
# Tikz.
export PGFMAN=/usr/local/texlive/2011/texmf-dist/doc/generic/pgf/pgfmanual.pdf
# java_home. Alternately, for a past version, try: 
#   /System/Library/Frameworks/JavaVM.framework/Versions/1.5/Home 
export JAVA_HOME=$(/usr/libexec/java_home)
export PYTHONPATH=$PYTHONPATH:/usr/local/Cellar/libxml2/2.7.8/lib/python2.7/site-packages
# python3.3
# export PYTHONPATH=$PYTHONPATH:/usr/local/lib/python3.3/site-packages
export RENTENNA_HOME=/Users/ben/rentenna/rentenna
#idk what this is for
#export NODE_PATH=/usr/local/lib/node_modules
bindkey -e
#http://my.opera.com/blackbelt_jones/blog/2007/06/05/zsh-prompt-configuration-issue-solved
export EDITOR="vim"
# allow node to write many files
ulimit -n 1024

#http://www.techrepublic.com/article/learn-the-power-features-of-zsh/6138386
setopt autocd
# PS1=$'%{\e[1;32m%}%n@%m%{\e[0m%}:%B%~/%b >%# '

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
# setup rev-search
source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh

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



### Phils prompt. Alternate, good prompt commented below
# PS1=$'%{\e[1;32m%}%n@%m%{\e[0m%}:%B%~/%b >%# '
function precmd {
    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))
    ###
    # Truncate the path if it's too long.
    PR_FILLBAR=""
    PR_PWDLEN=""
    local promptsize=${#${(%):---(%n@%m:%l)---()--}}
    local pwdsize=${#${(%):-%~}}
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    ((PR_PWDLEN=$TERMWIDTH - $promptsize))
    else
	PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi


    ###
    # Get APM info.

    if which ibam > /dev/null; then
	PR_APM_RESULT=`ibam --percentbattery`
    elif which apm > /dev/null; then
	PR_APM_RESULT=`apm`
    fi
}

setopt extended_glob
preexec () {
    if [[ "$TERM" == "screen" ]]; then
	local CMD=${1[(wr)^(*=*|sudo|-*)]}
	echo -n "\ek$CMD\e\\"
    fi
}

setprompt () {
    ###
    # Need this so the prompt will work.
    setopt prompt_subst
    ###
    # See if we can use colors.
    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
	colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
    done
    PR_NO_COLOUR="%{$terminfo[sgr0]%}"
    ###
    # See if we can use extended characters to look nicer.
    
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    PR_SET_CHARSET="%{$terminfo[enacs]%}"
    PR_SHIFT_IN="%{$terminfo[smacs]%}"
    PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    PR_HBAR=${altchar[q]:--}
    PR_ULCORNER=${altchar[l]:--}
    PR_LLCORNER=${altchar[m]:--}
    PR_LRCORNER=${altchar[j]:--}
    PR_URCORNER=${altchar[k]:--}
    ###
    # Decide if we need to set titlebar text.
    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
    ###
    # Decide whether to set a screen title
    if [[ "$TERM" == "screen" ]]; then
	PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	PR_STITLE=''
    fi
    ###
    # APM detection
    if which ibam > /dev/null; then
	PR_APM='$PR_RED${${PR_APM_RESULT[(f)1]}[(w)-2]}%%(${${PR_APM_RESULT[(f)3]}[(w)-1]})$PR_LIGHT_BLUE:'
    elif which apm > /dev/null; then
	PR_APM='$PR_RED${PR_APM_RESULT[(w)5,(w)6]/\% /%%}$PR_LIGHT_BLUE:'
    else
	PR_APM=''
    fi
    
    
    ###
    # Finally, the prompt.

    PROMPT='$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_SHIFT_IN$PR_ULCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_GREEN%(!.%SROOT%s.%n)$PR_GREEN@%m:%l\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_HBAR${(e)PR_FILLBAR}$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_MAGENTA%$PR_PWDLEN<...<%~%<<\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_URCORNER$PR_SHIFT_OUT\

$PR_CYAN$PR_SHIFT_IN$PR_LLCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
%(?..$PR_LIGHT_RED%?$PR_BLUE:)\
${(e)PR_APM}$PR_YELLOW%D{%H:%M}\
$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_NO_COLOUR '

    RPROMPT=' $PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
($PR_YELLOW%D{%a,%b%d}$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOUR'

    PS2='$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR '
}

setprompt
