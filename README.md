# koala

A web scraper that sends UDP video over a local network

## Usage

Create stream descriptor files using the `00-test` template in the streams folder. All files in that folder will be implemented as streams. Be careful to avoid using the same destination port in two different streams.

Afterwards, run with: `./koala`

Alternatively, install the service unit as described below.

## Systemd

```
ln -s $PWD/koala.service $HOME/.config/systemd/user/

systemctl --user daemon-reload
systemctl --user systemctl start koala.service
```

## Useful links

[FFmpeg UDP](http://underpop.online.fr/f/ffmpeg/help/examples-120.htm.gz)

[FFmpeg MPEG-TS](https://www.ffmpeg.org/ffmpeg-formats.html#mpegts-1)

[MPEG-TS Wikipedia](https://en.wikipedia.org/wiki/MPEG_transport_stream)

[FFmpeg Streaming Guide](https://trac.ffmpeg.org/wiki/StreamingGuide)

[Chromium CLI Switches](https://peter.sh/experiments/chromium-command-line-switches/)
