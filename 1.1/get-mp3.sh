#!/bin/bash

# Busqueda
function buscar {
    curl https://www.youtube.com/results\?search_query\=$1 | sed -n 's/.*href="\(\/watch[^"]*\).*/\1/p' | uniq | head -n 4 > .res.tmp
    # add youtube prefix - works
    sed -e 's/^/https:\/\/www.youtube.com/' .res.tmp > .search.tmp
    youtube-dl -e --no-playlist -a .search.tmp > .titles.tmp
    echo "exit" >> .titles.tmp
    mapfile -t OPTIONS < <(cat .titles.tmp)
    mapfile -t URLS < <(cat .search.tmp)
    clear
}

#Descarga
function download {
    if [ $# -eq 1 ]
    then
        VIDEO=$RANDOM.webm
        youtube-dl -x --audio-format $FORMAT -o "$VIDEO.%(ext)s" $2
    elif [ $# -eq 2 ]
    then
        youtube-dl -x --embed-thumbnail --audio-format $FORMAT -o "$1.%(ext)s" $2
    else
        echo "número de parámetros erroneo"
        exit 255
    fi
}

function options {
    PS3="-->"
    select opt in "${OPTIONS[@]}"
    do
        case $opt in
            "${OPTIONS[0]}")
                download "${OPTIONS[0]}" ${URLS[0]}
                mv "${OPTIONS[0]}.$FORMAT" $DIR
                SELECTED="${OPTIONS[0]}"
                break
                ;;
            "${OPTIONS[1]}")
                download "${OPTIONS[1]}" ${URLS[1]}
                mv "${OPTIONS[1]}.$FORMAT" $DIR
                SELECTED="${OPTIONS[1]}"
                break
                ;;
            "${OPTIONS[2]}")
                download "${OPTIONS[2]}" ${URLS[2]}
                mv "${OPTIONS[2]}.$FORMAT" $DIR
                SELECTED="${OPTIONS[2]}"
                break
                ;;
            "${OPTIONS[3]}")
                download "${OPTIONS[3]}" ${URLS[3]}
                mv "${OPTIONS[3]}.$FORMAT" $DIR
                SELECTED="${OPTIONS[3]}"
                break
                ;;
            "exit")
                break
                ;;
            *)
                echo invalid option
                ;;
        esac
    done
    echo -------------------------------------------
    echo "Downloaded: $SELECTED.$FORMAT"

    clean
    exit 0
}

# clean function
function clean {
    rm .search.tmp .titles.tmp
    clear
    exit 0
}

# main
clear
if [ -f .conf-gmp3 -a -r .conf-gmp3 ]
then
    . .conf-gmp3
else
    echo "DIR=.\nFORMAT=mp3" > .conf-gmp3
fi
if [ $1 = "-h" -o $1 = "--help" ]
then
    echo -----------------[ get-mp3 ]-----------------
    echo "Usage:  ./${0##*/} your search query"
    echo
    echo ~~~~~~~~~~~~~~~~~[ options ]~~~~~~~~~~~~~~~~~
    echo "./${0##*/} --location path/to/folder/"
    echo "./${0##*/} --format 'best','aac','flac','mp3','m4a','opus','vorbis',or 'wav'"
    exit 0
else
    if [ $# -eq 2 -a $1 = "--location" ]
    then
        if [ ! -z "$2" -a -d "$2" ]
        then
            DIR=$2
            echo "DIR=$2" > .conf-gmp3
        else
            echo "do you want to create it? (y/n)"
            read ANSWER
            if [ $ANSWER = "y" -a "mkdir $2" ]
            then
                mkdir "$2"
                echo "DIR=$2" > .conf-gmp3
            fi

        fi
        echo new directory setted
        exit 0;
    elif [ $# -eq 2 -a $1 = "--format" ]
         then
         echo "DIR=$DIR\nFORMAT=$2" > .conf-gmp3
         echo format changed successfully
         exit 0;
    else
        SEARCH=$(echo $@ | sed 's/ \+/+/g')
        buscar $SEARCH
        options
    fi
fi
