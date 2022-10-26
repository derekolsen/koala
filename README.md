# koala

Should work on the current Ubuntu LTS 22.04.1

Initialize i3 with:
```
cp /etc/i3/config ~/.config/i3/config
```

`run.sh` creates a virtual framebuffer on display `:99` running chromium under i3 and points to `$URL`

`record.sh` uses ffmpeg to create a mpeg2 over UDP stream pointing at `$DEST`
