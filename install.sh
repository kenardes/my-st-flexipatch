#!/usr/bin/env bash

# this is a crude bash script to easily install suckless's simple terminal

if ! [ -e "st-flexipatch" ]
then
    git clone https://github.com/bakkeby/st-flexipatch.git
    make -C st-flexipatch
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

if [[ $1 == '-b' ]]; then
    ## build
    make -C st-flexipatch
elif [[ $1 == '-u' ]]; then
    ## uninstall
    sudo make uninstall -C st-flexipatch
    sudo rm -f /usr/local/bin/st
    sudo rm -f /usr/local/share/man/man1/st.1
elif [[ $1 == '-i' ]]; then
    ## Install
    sudo make clean install -C st-flexipatch
else
    echo  "usage:
    install.sh -b   : build
    install.sh -u   : uninstall
    install.sh -i   : install"
    exit
fi
