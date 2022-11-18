# koala

A web scraper that sends UDP video over a local network

## Requirements

Requires the following packages:

- xvfb
- chromium
- ffmpeg
- libxcb

By default, Koala uses the command `chromium` to launch a browser in kiosk mode. If your system is using a Flatpak build of chromium or chromium is not in your $PATH, the `$chrome` environment variable must either be set to your chromium command or manually changed in line 8 of `koala`. 

Examples:

```
export chrome="flatpak run com.github.Eloston.UngoogledChromium"
```

```
...
[ -z "$chrome" ] && chrome="flatpak run com.github.Eloston.UngoogledChromium"
...
```

## Usage

```
koala [OPTION ...]

Options:
-v         --verbose                      show debug logs
-f FILE    --file FILE                    single-file mode, FILE should
                                          be a stream descriptor file
 
-o         --oneshot                      enables oneshot mode (one-liner),
                                          required for all following options

-d IP:PORT --dest, --destination IP:PORT  destination for UDP stream
-u URL     --url URL                      URL of webpage
-w WIDTH   --width WIDTH                  width in pixels
-h HEIGHT  --height HEIGHT                height in pixels
-c DEPTH   --colordepth DEPTH             colordepth (unstable)
-r RATE    --framerate RATE               framerate in FPS
-b RATE    --bitrate RATE                 bitrate in kilobits
```

### Normal Mode

Create stream descriptor files using the `00-test` template in the streams folder. All files in that folder will be implemented as streams. Be careful to avoid using the same destination port in two different streams.

Afterwards, run with: `./koala`.

Alternatively, install the service unit with Systemd as described below.

### File Mode

A single stream descriptor file can be loaded using `./koala -f $FILE`.

### Oneshot Mode

A stream can be run using a one-liner with just a URL and destination:

```
./koala -o -u https://www.youtube.com/watch?v=9kaIXkImCAM -d 127.0.0.1:1337
```

Other options available are described in the usage table above.


## Systemd Installation

```
cd koala
ln -s $PWD /opt/koala
ln -s $PWD/koala.service $HOME/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user systemctl enable koala.service
systemctl --user systemctl start koala.service
```

Restart the service when adding, removing, or modifying streams:

```
systemctl --user systemctl restart koala.service
```

## Testing

A `tests` script is provided to test exceptions and terminations.

To test main functionality, you may use VLC.

Open VLC, navigate to `Media > Open Network Stream` and enter `udp://@:$PORT` replacing $PORT with which port your stream is pointing to.

Show verbose terminal output with `./koala -v` or `./koala --verbose`.

## Useful links

[FFmpeg UDP](http://underpop.online.fr/f/ffmpeg/help/examples-120.htm.gz)

[FFmpeg MPEG-TS](https://www.ffmpeg.org/ffmpeg-formats.html#mpegts-1)

[MPEG-TS Wikipedia](https://en.wikipedia.org/wiki/MPEG_transport_stream)

[FFmpeg Streaming Guide](https://trac.ffmpeg.org/wiki/StreamingGuide)

[Chromium CLI Switches](https://peter.sh/experiments/chromium-command-line-switches/)
