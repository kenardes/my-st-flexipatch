[st-flexipatch](https://github.com/bakkeby/st-flexipatch) adalah sebuah tool untuk membantu menginstal Simple Terminal dari suckless.org, tool ini dilengkapi dengan patch-patch yang langsung siap dipakai untuk diterapkan di Simple Terminal dengan cara yang sangat mudah yaitu cukup dengan mengganti value dari bernilai 0 (disable) menjadi 1 (enable) pada pengaturan patch-patch tersebut yaitu pada file patches.h

## Why I use it?

I want to install the latest version of Simple Terminal (v0.8.3) but the patch that I need only able to be applied to the previous version of Simple Terminal and I can not fix it by my self so I search another way to install it and then I've found st-flexipatch which is a tool that can easily achieve what I need.

## Berikut adalah cara penggunaannya:

* Clone repo st-flexipatch and then build first to try without patch

  ``` shell
  $ git clone https://github.com/bakkeby/st-flexipatch.git
  $ cd st-flexipatch
  $ make
  $ ./st &
  ```

* Enable patches of your choices by editing file patches.h

  ``` shell
  $ nvim patches.h   # you can use your favorite inferior text editor of your choice to edit this file.
  ```

  ``` c++
  /* I only need 2 patch: KEYBOARDSELECT & SCROLLBACK, so I only change the value from 0 to 1
   * only to these patches
   */
  #define KEYBOARDSELECT_PATCH 1
  #define SCROLLBACK_PATCH 1
  ```

* Make some change to config.h if you don't like the default configuration

  ``` shell
  $ nvim config.h   # you can use your favorite inferior text editor of your choice to edit this file.
  ```

  ``` c++
  /* I prefer font of Dejavu Sans Mono then the default font */
  static char *font = "DejaVu Sans Mono for Powerline:style=Book:pixelsize=12:antialias=true:autohint=true";

  /* Below is color scheme of gruvbox theme with little change to the background */
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

* Now build again then install to the system

  ``` shell
  ## Build
  $ make
  st build options:
  CFLAGS  = -I/usr/X11R6/include  -I/usr/include/uuid -I/usr/include/freetype2 -I/usr/include/libpng16  -I/usr/include/freetype2 -I/usr/include/libpng16 -DVERSION="0.8.3" -D_XOPEN_SOURCE=600  -O
  LDFLAGS = -L/usr/X11R6/lib -lm -lrt -lX11 -lutil -lXft -lXrender -lXcursor -lfontconfig -lfreetype  -lfreetype
  CC      = c99
  c99 -o st st.o x.o -L/usr/X11R6/lib -lm -lrt -lX11 -lutil -lXft -lXrender -lXcursor `pkg-config --libs fontconfig`  `pkg-config --libs freetype2`

  ## Install
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
## Next:
* install script: a bash script to help me easily install st-flexipatch on my debian linux machine.
