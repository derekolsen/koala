# koala

Tested working on the current Ubuntu LTS 22.04.1

Initialize i3 with:
```
cp /etc/i3/config ~/.config/i3/config
```

`run.sh` creates a virtual framebuffer on display `:99` running chromium under i3 and points to `$URL`

`record.sh` uses ffmpeg to create a mpeg2 over UDP stream pointing at `$DEST`

## Docker container

Currently not working, see issues.

```
docker build -t koala-testing .
docker run -p 10023:10023 koala-testing
```

## Useful links

[FFMPEG UDP](http://underpop.online.fr/f/ffmpeg/help/examples-120.htm.gz)
[FFMPEG MPEG-TS](https://www.ffmpeg.org/ffmpeg-formats.html#mpegts-1)
[MPEG-TS Wikipedia](https://en.wikipedia.org/wiki/MPEG_transport_stream)
[FFMPEG Streaming Guide](https://trac.ffmpeg.org/wiki/StreamingGuide)
[Chromium CLI Switches](https://peter.sh/experiments/chromium-command-line-switches/)
