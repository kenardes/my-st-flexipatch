#!/usr/bin/env bash

# this is a crude bash script to easily install suckless's simple terminal via st-flexipatch

mprepare(){
    if ! [ -e "st-flexipatch" ]
    then
        git clone https://github.com/bakkeby/st-flexipatch.git
    fi

    if [ -e "config.h" ]; then
        if [ -e "st-flexipatch/config.h" ]; then
            rm st-flexipatch/config.h
            cp config.h st-flexipatch/config.h
        else
            cp config.h st-flexipatch/config.h
        fi
    fi

    if [ -e "patches.h" ]; then
        if [ -e "st-flexipatch/patches.h" ]; then
            rm st-flexipatch/patches.h
            cp patches.h st-flexipatch/patches.h
        else
            cp patches.h st-flexipatch/patches.h
        fi
    fi
}

mdelgit(){
    echo "Delete source? y or n"
    read DELSRC
    if [[ $DELSRC == 'y' ]]; then
        rm -rf ./st-flexipatch
    elif [[ $DELSRC == 'n' ]]; then
        exit
    else
        echo "Wrong answer."
        mdelgit
    fi
}

if [[ $1 == '-b' ]]; then
    ## build
    mprepare
    make -C st-flexipatch
    mdelgit
elif [[ $1 == '-u' ]]; then
    ## uninstall
    mprepare
    sudo make uninstall -C st-flexipatch
    sudo rm -f /usr/local/bin/st
    sudo rm -f /usr/local/share/man/man1/st.1
    mdelgit
elif [[ $1 == '-i' ]]; then
    ## Install
    mprepare
    sudo make clean install -C st-flexipatch
    mdelgit
else
    echo  "usage:
    install.sh -b   : build
    install.sh -u   : uninstall
    install.sh -i   : install"
    exit
fi
