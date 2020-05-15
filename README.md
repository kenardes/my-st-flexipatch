[st-flexipatch](https://github.com/bakkeby/st-flexipatch) adalah sebuah *tool* untuk membantu menginstal [Simple Terminal](https://st.suckless.org/) dari suckless.org, *tool* ini dilengkapi dengan berbagai *patch* yang bisa langsung dipakai untuk diterapkan di *Simple Terminal* dengan cara yang sangat mudah yaitu cukup dengan mengganti nilai dari bernilai 0 (*disable*) menjadi 1 (*enable*) pada pengaturan berbagai *patch* tersebut yaitu pada *file* patches.h

## Alasan memakai *tool* ini?

Aku ingin menginstal versi terbaru dari *Simple Terminal* (v0.8.3), tapi beberapa *patch* yang aku butuhkan tidak cocok untuk diterapkan di versi terbaru ini karena memang belum diperbarui untuk versi ini.

Dengan pemahaman yang minim tentang bahasa c dan *patching*, tentunya aku akan sangat kesulitan jika ingin memperbaiki *patch-patch* tersebut.

Maka dari itu aku mencari cara alternatif untuk menginstal versi terbaru dari *Simple Terminal*, dan untunglah ternyata ada yang sudah membuat *tool*nya yaitu st-flexipatch.

## Berikut adalah cara penggunaannya:

* *Clone* *repo* st-flexipatch, kemudian *build* dulu untuk mencobanya tanpa *patch*

  ``` shell
  $ git clone https://github.com/bakkeby/st-flexipatch.git
  $ cd st-flexipatch
  $ make
  $ ./st &
  ```

* Aktifkan *patch-patch* yang akan kamu pakai dengan meng-*edit* *file* patches.h

  ``` shell
  $ nvim patches.h   # Disini kita pakai nvim (neovim), tapi kamu bisa menggantinya dengan text editor yang lain yang kamu suka.
  ```

  ``` c++
  /* Disini aku hanya pakai 2 patch: KEYBOARDSELECT & SCROLLBACK, jadi aku hanya mengubah nilai 0 ke 1
   * hanya pada kedua patch tsb seperti berikut
   */
  #define KEYBOARDSELECT_PATCH 1
  #define SCROLLBACK_PATCH 1
  ```

* Buat beberapa perubahan pada *file* config.h jika kamu tidak suka pengaturan *default*-nya

  ``` shell
  $ nvim config.h   # Disini kita pakai nvim (neovim), tapi kamu bisa menggantinya dengan text editor yang lain yang kamu suka.
  ```

  ``` c++
  /* Font-nya aku ubah ke Dejavu Sans Mono karena lebih nyaman dengan font ini */
  static char *font = "DejaVu Sans Mono for Powerline:style=Book:pixelsize=12:antialias=true:autohint=true";

  /* Berikut ini adalah color scheme dari tema gruvbox, background-nya aku ubah ke #000000 agar lebih gelap */
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

* Sekarang *build* lagi lalu instal ke sistem

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

## *Installer script*

Selain cara diatas untuk menginstal *Simple Terminal* via st-flexipatch, untuk memudahkan proses instalasi, aku buat instalernya pakai bash script, cara pakainya seperti berikut:

``` shell
$ git clone https://github.com/kenardes/my-st-flexipatch.git

$ cd my-st-flexipatch

## Pilih salah satu dari perintah berikut:

$ ./install.sh -b   ## untuk build

$ ./install.sh -u   ## untuk uninstall

$ ./install.sh -i   ## untuk install
```

## Next:
* translate
