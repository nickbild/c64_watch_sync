# C64 Fitness Watch

Coming soon!

Keep tabs on your fitness with this C64-themed smartwatch that wirelessly syncs data to your Commodore 64 computer.

![](https://raw.githubusercontent.com/nickbild/c64_watch_sync/main/media/watch_pal_c64_sm.jpg)

## How It Works

## To Install

### Watch

- Add the official [T-Watch Library](https://github.com/Xinyuan-LilyGO/TTGO_TWatch_Library) to Arduino IDE.
  - This was built with the [original version of the library](https://github.com/Xinyuan-LilyGO/TTGO_TWatch_Library/tree/V1.1.0).  Incompatibilities have been reported with later versions, so `V1.1.0` is recommended.
- Copy [this](https://github.com/nickbild/c64_watch/blob/main/assets/c64_basic.c), [this](https://github.com/nickbild/c64_watch/blob/main/assets/menu.c), and [this](https://github.com/nickbild/c64_watch_sync/blob/main/assets/c64_sync.c) in to the `src/imgs/` folder within the library.
- Open [c64_watch.ino](https://github.com/nickbild/c64_watch_sync/blob/main/c64_watch/c64_watch.ino) in Arduino IDE.
- Plug the T-Watch 2020 in to your computer via USB, and click `Sketch->Upload`.

### Commodore 64

- Load [sync.prg](https://github.com/nickbild/c64_watch_sync/blob/main/sync.prg) and [wpal3.prg](https://github.com/nickbild/c64_watch_sync/blob/main/wpal3.prg) onto a disk, SD2IEC drive, etc.
- Run commands from BASIC prompt:
```
LOAD"SYNC.PRG",8,1
NEW
LOAD"WPAL3.PRG",8,1
RUN
```

## Media

Click here for the demo video.

C64 Watch:

![](https://raw.githubusercontent.com/nickbild/c64_watch_sync/main/media/home1_sm.jpg)

Watch sync tool:

![](https://raw.githubusercontent.com/nickbild/c64_watch_sync/main/media/sync4_sm.jpg)

Watch Pal program (for Commodore 64):

![](https://raw.githubusercontent.com/nickbild/c64_watch_sync/main/media/watch_pal_sm.jpg)

Arduino Micro and IR sensor connected to user port breakout board:

![](https://raw.githubusercontent.com/nickbild/c64_watch_sync/main/media/arduino_close_sm.jpg)

![](https://raw.githubusercontent.com/nickbild/c64_watch_sync/main/media/arduino_zoom_out_sm.jpg)

The watch runs BASIC, too:

![](https://raw.githubusercontent.com/nickbild/c64_watch_sync/main/media/basic_sm.jpg)

## Bill of Materials

- 1 x Lilygo T-Watch 2020
- 1 x Commodore 64
- 1 x Arduino Micro
- 1 x IR receiver sensor (TSOP38238)

## About the Author

[Nick A. Bild, MS](https://nickbild79.firebaseapp.com/#!/)
