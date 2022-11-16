# koala

A web scraper that sends UDP video over a local network

## Requirements

Requires the following packages:

- xvfb
- chromium
- ffmpeg

Important: The `$chrome` environment variable must either be set to your chromium binary or manually changed in line 2 of `koala`. By default, Koala uses the command `chromium`.

Example:

```
export chrome="flatpak run com.github.Eloston.UngoogledChromium"
```

## Usage

Create stream descriptor files using the `00-test` template in the streams folder. All files in that folder will be implemented as streams. Be careful to avoid using the same destination port in two different streams.

Afterwards, run with: `./koala`.

Alternatively, install the service unit as described below.

## Testing

Show verbose terminal output with `./koala -v` or `./koala --verbose`.

To quickly test functionality, you may use VLC.

Open VLC, navigate to `Media > Open Network Stream` and enter `udp://@:10022` replacing 10022 with whatever port your stream is pointing to.

## Systemd

```
cd koala
ln -s $PWD /opt/koala
ln -s $PWD/koala.service $HOME/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user systemctl start koala.service
```

Execute the following command when adding, removing, or modifying streams:

```
systemctl --user systemctl restart koala.service
```

## Useful links

[FFmpeg UDP](http://underpop.online.fr/f/ffmpeg/help/examples-120.htm.gz)

[FFmpeg MPEG-TS](https://www.ffmpeg.org/ffmpeg-formats.html#mpegts-1)

[MPEG-TS Wikipedia](https://en.wikipedia.org/wiki/MPEG_transport_stream)

[FFmpeg Streaming Guide](https://trac.ffmpeg.org/wiki/StreamingGuide)

[Chromium CLI Switches](https://peter.sh/experiments/chromium-command-line-switches/)
