#!/bin/bash

# Busqueda
function buscar {
    curl -s https://www.youtube.com/results\?search_query\=$1 | sed -n 's/.*href="\(\/watch[^"]*\).*/\1/p' | uniq | head -n 4 > .res.tmp
    # add youtube prefix - works
    sed -e 's/^/https:\/\/www.youtube.com/' .res.tmp > .search.tmp
    youtube-dl -e --no-playlist -a .search.tmp > .titles.tmp
    echo "exit" >> .titles.tmp
    mapfile -t OPTIONS < <(cat .titles.tmp)
    mapfile -t URLS < <(cat .search.tmp)
}

#Descarga
function download {
    if [ $# -eq 1 ]
    then
        VIDEO=$RANDOM.webm
        youtube-dl -x --audio-format mp3 -o "$VIDEO.%(ext)s" $2
    elif [ $# -eq 2 ]
    then
        youtube-dl -x --audio-format mp3 -o "$1.%(ext)s" $2
    else
        echo "número de parámetros erroneo"
        exit 255
    fi
    exit 0
}

# clean function
function clean {
    rm .search.tmp .titles.tmp
    clear
    exit 0
}

# main
if [ $1 = "-h" -o $1 = "--help" ]
then
    echo "get-mp3 your search query"
    exit 0
else
    SEARCH=$(echo $@ | sed 's/ \+/+/g')
    buscar $SEARCH
fi
PS3=">"
select opt in "${OPTIONS[@]}"
do
    case $opt in
        "${OPTIONS[0]}")
            echo "Downloading: ${OPTIONS[0]}"
            download "${OPTIONS[0]}" ${URLS[0]}
            break
            ;;
        "${OPTIONS[1]}")
            echo "Downloading: ${OPTIONS[1]}"
            download "${OPTIONS[1]}" ${URLS[1]}
            break
            ;;
        "${OPTIONS[2]}")
            echo "Downloading: ${OPTIONS[2]}"
            download "${OPTIONS[2]}" ${URLS[2]}
            break
            ;;
        "${OPTIONS[3]}")
            echo "Downloading: ${OPTIONS[3]}"
            download "${OPTIONS[3]}" ${URLS[3]}
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
clean
