# Suckless's Simple Terminal (ST)

<!-- markdown-toc start - Don't edit this section. Run M-x markdown-toc-refresh-toc -->
**Table of Contents**

- [Suckless's Simple Terminal (ST)](#suckless's-simple-terminal-(st))
    - [List of files](#list-of-files)
    - [Simple Terminal (ST)](#simple-terminal-(st))
        - [Fitur](#fitur)
        - [Shortcut](#shortcut)
    - [st-flexipatch](#st-flexipatch)
        - [Alasan memakai *tool* ini?](#alasan-memakai-*tool*-ini?)
        - [Berikut adalah cara penggunaannya:](#berikut-adalah-cara-penggunaannya:)
        - [*Installer script*](#*installer-script*)
        - [Transparansi](#transparansi)

<!-- markdown-toc end -->

## List of files

``` shell
$ tree
.
├── config.h     ## file konfigurasinya ST
├── install.sh   ## script bash untuk menginstal ST
├── LICENSE      ## lisensi MIT
├── patches.h    ## file konfigurasinya patch
└── README.md
```

## Simple Terminal (ST)

**[Simple Terminal (ST)](https://st.suckless.org/)** adalah sejenis *terminal emulator* yang sederhana dan ringan yang dikembangkan oleh suckless.org yang mana dalam setiap proses instalasi dan pengubahan konfigurasi kita harus meng-*compile* kode sumbernya. Konsep / filosofi yang diusung dalam pengembangan ST ini adalah sebuah *terminal emulator* yang bagus tapi dengan fitur yang sangat minim tanpa perlu dijejali berbagai fitur yang sebenarnya sudah ada pada *tool* lain semacam *tmux*, dan memang idealnya *terminal emulator* ini digunakan secara bersamaan dengan *tmux*. Namun jika kamu ingin menambahkan sejumlah fitur secara *built-in (hard code)* tanpa harus memakai *tmux* maka kamu bisa menambahkannya melalui *patch*, sebagai contoh disini saya memakai *patch scrollback* supaya bisa *scroll* keatas / kebawah cukup melalui *keyboard* saja dan *patch keyboardselect* supaya bisa meng-*copy-paste* teks di *terminal emulator* juga hanya dengan melalui *keyboard* saja, kedua *patch* tersebut saya perlukan untuk mengurangi ketergantungan pada penggunaan *mouse* saat memakai *terminal emulator*.

> Versi st saat ini: 0.8.3

### Fitur

Untuk fitur utama silakan cek [st.suckless.org](https://st.suckless.org/), disini aku hanya akan menunjukkan daftar fitur tambahan hasil
kustomisasi ku, diantaranya:

* Tema: Gruvbox
* *Font: DejaVu Sans Mono for Powerline*
* *Scroll up / scroll down* tanpa menggunakan *mouse*
* *Select / copy / paste* tanpa menggunakan *mouse*

### Shortcut

Pengaturan shortcut ada di *config.h*, contohnya seperti berikut:

``` c++
static Shortcut shortcuts[] = {
    /* mask                 keysym          function         argument */
    { ControlMask,          XK_Print,       toggleprinter,   {.i =  0} },
    { ShiftMask,            XK_Insert,      clippaste,       {.i =  0} },
    { TERMMOD,              XK_C,           clipcopy,        {.i =  0} },
    #if OPENCOPIED_PATCH
    { MODKEY,               XK_o,           opencopied,      {.v = "xdg-open"} },
    #endif // OPENCOPIED_PATCH
};
```

* **Mask**

  |Mask        |Keterangan  |
  |:-----------|:-----------|
  |ControlMask |Ctrl        |
  |ShiftMask   |Shift       |
  |TERMMOD     |Ctrl-Shift  |
  |MODKEY      |left Alt    |

* **Standard**

  |Shortcut            |Keterangan                                                          |
  |:-------------------|:-------------------------------------------------------------------|
  |Ctrl-Shift-c        | *copy* ke *clipboard*                                              |
  |Ctrl-Shift-v        | *paste* dari *clipboard*                                           |
  |Ctrl-Shift-y        | *paste* dari *PRIMARY*                                             |
  |Shift-Insert        | *paste* dari *PRIMARY*                                             |
  |Ctrl-Shift-PageUp   | *zoom +*                                                           |
  |Ctrl-Shift-PageDown | *zoom -*                                                           |
  |Ctrl-Shift-Home     | *reset zoom*                                                       |
  |Shift-PageUp        | *scroll* ke atas                                                   |
  |Shift-PageDown      | *scroll* ke bawah                                                  |

  Teks yang dipilih / diblok di *terminal emulator* menggunakan kursor maka secara otomatis ter-*copy* ke *PRIMARY*

* **Keyboard Select**

  Ini adalah fitur tambahan dari *patch keyboard_select*, fungsinya untuk melakukan *copy/paste* tanpa melibatkan *mouse*.

  |Shortcut        |Keterangan                                                                              |
  |:---------------|:---------------------------------------------------------------------------------------|
  |Ctrl-Shift-Esc  | mengaktifkan *keyboard select* (*mode MOVE*)                                           |
  |h,j,k,l / arrow | menggerakkan kursor ke: kiri,bawah,atas,kanan                                          |
  |!, _, *         | menggerakkan kursor ke tengah: baris/kolom/layar                                       |
  |Backspace, $    | menggerakkan kursor ke awal/akhir baris                                                |
  |PgUp, PgDown    | menggerakkan kursor ke awal/akhir kolom                                                |
  |Home, End       | menggerakkan kursor ke awal/akhir layar                                                |
  |s               | ganti mode ke *MOVE/SEL*                                                               |
  |/, ?            | mengaktifkan mode pencarian                                                            |
  |n, N            | menuju ke hasil pencarian, ke atas/bawah                                               |
  |t               | ganti tipe seleksi antara yang biasa/kotak                                             |
  |Return          | menonaktifkan *keyboard select*, tetap mempertahankan *highlight* pada yang diseleksi  |
  |Escape          | menonaktifkan *keyboard select*                                                        |

  * Mulai dulu dengan *Ctrl-Shift-Esc* untuk mengaktifkan fitur ini.
  * Ganti mode *MOVE* ke mode *SEL* jika ingin meng-*copy* teks dengan menekan huruf s.
  * Indikator jenis mode yang aktif ada di pojok kanan bawah.
  * Teks yang ter-*copy* adalah yang ter-*highlight*, dan hanya ter-*copy* ke *PRIMARY*
  * Untuk meng-*copy* ke *CLIPBOARD*, tekan *Ctrl-Shift-c*
  * Tekan *Esc* untuk menonaktifkan fitur ini

## st-flexipatch

[st-flexipatch](https://github.com/bakkeby/st-flexipatch) adalah sebuah *tool* untuk membantu menginstal [Simple Terminal](https://st.suckless.org/) dari suckless.org, *tool* ini dilengkapi dengan berbagai *patch* yang bisa langsung dipakai untuk diterapkan di *Simple Terminal* dengan cara yang sangat mudah yaitu cukup dengan mengganti nilai 0 (*disable*) menjadi 1 (*enable*) pada *file patches.h*

### Alasan memakai *tool* ini?

Aku ingin menginstal versi terbaru dari *Simple Terminal* (v0.8.3), tapi beberapa *patch* yang aku butuhkan tidak cocok untuk diterapkan di versi terbaru ini karena memang belum diperbarui untuk versi ini.

Dengan pemahaman yang minim tentang bahasa c dan *patching*, tentunya aku akan sangat kesulitan jika ingin memperbaiki *patch-patch* tersebut.

Maka dari itu aku mencari cara alternatif untuk menginstal versi terbaru dari *Simple Terminal*, dan untunglah ternyata ada yang sudah membuat *tool*nya yaitu *st-flexipatch*.

### Berikut adalah cara penggunaannya:

* *Clone* *repo* *st-flexipatch*, kemudian *build* dulu untuk mencobanya tanpa *patch*

  ``` shell
  $ git clone https://github.com/bakkeby/st-flexipatch.git
  $ cd st-flexipatch
  $ make
  $ ./st &
  ```

* Aktifkan *patch-patch* yang akan kamu pakai dengan meng-*edit file patches.h*

  ``` shell
  $ nvim patches.h   # kamu bisa mengganti nvim dengan text editor yang lain yang kamu suka.
  ```

  ``` c++
  /* Disini aku hanya pakai 2 patch: KEYBOARDSELECT & SCROLLBACK, jadi aku hanya mengubah nilai 0 ke 1
   * pada kedua patch tsb seperti berikut
   */
  #define KEYBOARDSELECT_PATCH 1
  #define SCROLLBACK_PATCH 1
  ```

* Buat beberapa perubahan pada *file config.h* jika kamu tidak suka pengaturan *default*-nya, misal:

  ``` shell
  $ nvim config.h   # kamu bisa mengganti nvim dengan text editor yang lain yang kamu suka.
  ```

  ``` c++
  /* Font-nya aku ubah ke Dejavu Sans Mono karena lebih nyaman dengan font ini */
  static char *font = "DejaVu Sans Mono for Powerline:style=Book:pixelsize=12:antialias=true:autohint=true";

  /*
   * Berikut ini adalah color scheme dari tema gruvbox, background-nya aku ubah ke #000000 agar
   *  lebih gelap
   */

  /* Terminal colors (16 first used in escape sequence) */
  static const char *colorname[] = {
      "#000000",   /* "#282828" , hard contrast: #1d2021 / soft contrast: #32302f */
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

  ## Install
  $ sudo make clean install
  ```

### *Installer script*

Selain cara manual seperti yang dijelaskan diatas, aku juga membuatkan instalernya menggunakan *bash script*, tujuannya untuk memudahkan proses instalasi, cara penggunaannya seperti berikut:

``` shell
$ git clone https://github.com/kenardes/my-st-flexipatch.git

$ cd my-st-flexipatch

## Pilih salah satu dari perintah berikut:

$ ./install.sh -b   ## untuk build

$ ./install.sh -u   ## untuk uninstall

$ ./install.sh -i   ## untuk install
```

### Transparansi

Untuk menambahkan efek transparansi pada *background*, kita bisa menggunakan *compton*.

``` shell
## Install dulu aplikasi compton, untuk distro debian perintahnya berikut:
$ sudo apt install compton

## Edit file ~/.config/compton.conf , jika tidak ada bisa buat dulu
## Ubah / tambahkan opicity-rule seperti berikut
$ nvim ~/.config/compton.conf
opacity-rule = [
    "92:class_g = 'st-256color'",
    "92:class_g = 'Xfce4-terminal'"
];

## Jika background tidak berubah transparan, coba ganti angka 92 (opacity) diatas
```
