# Mixtape Generator

This is a quick-n-dirty makefile for generating "mixtape" videos  from a single
still image and music from YouTube.

It's useful for creating party playlists or playlists to work out to. No real
YouTube video examples are given to avoid copyright issues so contact me
privately if you want my Synthwave/Retrowave exercise mix :-)

## Dependencies

This makes use of [youtube-dl](https://youtube-dl.org/),
[wget](https://www.gnu.org/software/wget/) and [ffmpeg](https://www.ffmpeg.org/)
which you can install via your normal package manager usually.

## How to use

Clone the repo

    git clone https://github.com/avengerpenguin/mixtapes.git
    cd mixtapes

Create as many input files as you want with `.txt` extension that look like:

```
https://some.domain/path/to/image/file.jpg
youtubeid1
youtubeid2
youtubeid3
```

i.e. the first line is a URL of an image you'd like to use and  the remaining
lines are YouTube IDs of videos whose music you would like to use, in order.

Then you may run:

   make

and the following will happen (if your input is e.g. `foo.txt`):

* Make will generate a series of `.webm` files with the audio only for each
  YouTube video ID you gave. This is hard-coded to download a particular format
  to keep it efficient and only get the audio, so it's not 100% guaranteed to
  work on every video (adjust it maybe if that's a problem).

* Then each `.webm` file will be converted to mp3.

* The makefile will then generate a `foo.list` file (if your input file was
  `foo.txt` that contains ) with each mp3 in the order you have. This is in
  the format `ffmpeg` expects as input for `-f concat`

* Then `ffmpeg -f concat` is run on that `foo.list` file such that you get a
  single `foo.mp3` file. This file is usable as a single mixtape file if you
  wish.

* Your chosen image URL at the top of `foo.txt` will be downloaded as `foo.jpg`.

* Finally, `ffmpeg` is run again to generate a `foo.mp4` video that has your
  playlist with your given still image.

The `makefile` is generic enough that you can populate the repo with as many
`$foo.txt` files as you like and it will generate as many output mp4 files
as you like. Run with `make -j` to run lots of things in parallel if you have a
lot of cores (`make -j 4` to restrict to e.g. 4 cores).

## Possible Extensions

This is something that's good enough for me that is open to copy/use but feel
free to contribute any extensions you do to make it more advanced, e.g.:

* Change the image when the song changes.
* Have an animated gif like a nyancat throughout the video.
* Generating playlists from YouTube playlists or indeed from elsewhere like
  Spotify.
