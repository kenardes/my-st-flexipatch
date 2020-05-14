# st-flexipatch

https://github.com/bakkeby/st-flexipatch

An st build with preprocessor directives to decide which patches to include during build time 

``` shell
$ git clone https://github.com/bakkeby/st-flexipatch.git

$ cd st-flexipatch

$ make
st build options:
CFLAGS  = -I/usr/X11R6/include  -I/usr/include/uuid -I/usr/include/freetype2 -I/usr/include/libpng16  -I/usr/include/freetype2 -I/usr/include/libpng16 -DVERSION="0.8.3" -D_XOPEN_SOURCE=600  -O
LDFLAGS = -L/usr/X11R6/lib -lm -lrt -lX11 -lutil -lXft -lXrender -lXcursor -lfontconfig -lfreetype  -lfreetype
CC      = c99
c99 -o st st.o x.o -L/usr/X11R6/lib -lm -lrt -lX11 -lutil -lXft -lXrender -lXcursor `pkg-config --libs fontconfig`  `pkg-config --libs freetype2`

$ sudo make clean install
[sudo] password for opoel34:
rm -f st st.o x.o st-0.8.3.tar.gz
c99 -I/usr/X11R6/include  `pkg-config --cflags fontconfig`  `pkg-config --cflags freetype2` -DVERSION=\"0.8.3\" -D_XOPEN_SOURCE=600  -O -c st.c
c99 -I/usr/X11R6/include  `pkg-config --cflags fontconfig`  `pkg-config --cflags freetype2` -DVERSION=\"0.8.3\" -D_XOPEN_SOURCE=600  -O -c x.c
c99 -o st st.o x.o -L/usr/X11R6/lib -lm -lrt -lX11 -lutil -lXft -lXrender -lXcursor `pkg-config --libs fontconfig`  `pkg-config --libs freetype2`
mkdir -p /usr/local/bin
cp -f st /usr/local/bin
chmod 755 /usr/local/bin/st
mkdir -p /usr/local/share/man/man1
sed "s/VERSION/0.8.3/g" < st.1 > /usr/local/share/man/man1/st.1
chmod 644 /usr/local/share/man/man1/st.1
tic -sx st.info
7 entries written to /etc/terminfo
Please see the README file regarding the terminfo entry of st.
```

``` shell
$ nvim patches.h
```

``` c++
#define KEYBOARDSELECT_PATCH 1
#define SCROLLBACK_PATCH 1
```

``` shell
$ nvim config.h
```

``` c++
/*
static char *font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";
*/
static char *font = "DejaVu Sans Mono for Powerline:style=Book:pixelsize=12:antialias=true:autohint=true";

/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {
    "#000000",   // "#282828", /* hard contrast: #1d2021 / soft contrast: #32302f */
    "#cc241d",
    "#98971a",
    "#d79921",
    "#458588",
    "#b16286",
    "#689d6a",
    "#a89984",
    "#928374",
    "#fb4934",
    "#b8bb26",
    "#fabd2f",
    "#83a598",
    "#d3869b",
    "#8ec07c",
    "#ebdbb2",

    [255] = 0,

    /* more colors can be added after 255 to use with DefaultXX */
    "#282828",   /* 256 -> bg */
    "#ebdbb2",   /* 257 -> fg */
    "#add8e6", /* 258 -> cursor */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
unsigned int defaultfg = 257;
unsigned int defaultbg = 0;
unsigned int defaultcs = 258;
unsigned int defaultrcs = 0;
```

???
* The transparancy enable via compton

