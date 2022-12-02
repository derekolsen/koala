# koala

A web scraper that sends UDP video over a local network

## Requirements

Requires the following packages:

- xvfb
- chromium
- ffmpeg

By default, Koala uses the command `chromium` to launch a browser in kiosk mode.
If your system is using a Flatpak build of chromium or chromium is not in your
$PATH, the `$chrome` environment variable must either be set to your chromium
command or manually changed in line 6 of `koala`. 

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
-h         --help                         display this usage message and exit

-f FILE    --file FILE                    single-file mode, FILE should
                                          be a stream descriptor file
 
-o         --oneshot                      enables oneshot mode (one-liner),
                                          required for all following options

-d IP:PORT --dest, --destination IP:PORT  destination for UDP stream
-u URL     --url URL                      URL of webpage
-x WIDTH   --width WIDTH                  width in pixels
-y HEIGHT  --height HEIGHT                height in pixels
-c DEPTH   --colordepth DEPTH             colordepth (unstable)
-r RATE    --framerate RATE               framerate in FPS
-b RATE    --bitrate RATE                 bitrate in kilobits
```

### Normal Mode

Create stream descriptor files using the `00-defaults` template in the streams
folder. All files in that folder will be implemented as streams.
Be careful to avoid using the same destination port in two different streams.

Afterwards, run with: `./koala`.

Alternatively, install the service unit with Systemd as described below.

### File Mode

A single stream descriptor file can be loaded using `./koala -f $FILE`.

### Oneshot Mode

A stream can be run using a one-liner with just a URL and destination:

```
./koala -o -u https://www.youtube.com/watch?v=9kaIXkImCAM -d 127.0.0.1:1337
```

Other available options are described in the usage table above.


## Systemd Installation

### Script Install

An installation script is provided for Debian only and creates a user named `koala`.
Use this command to install:

```
curl -fsSL https://raw.githubusercontent.com/derekolsen/koala/main/install.sh | sudo bash
```

### Manual Install

Manually install the script to any user with these commands:

```
cd koala
ln -s $PWD /opt/koala
ln -s $PWD/koala.service $HOME/.config/systemd/user/
systemctl --user daemon-reload
systemctl --user systemctl enable koala.service
systemctl --user systemctl start koala.service
```

### Modifying Streams

Restart the service while logged in as the Koala user when adding, removing, or modifying streams:

```
systemctl --user systemctl restart koala.service
```

### Notes about Systemd

Koala is meant to run as an unprivileged user (this is mainly for chromium compatibility),
and so the service unit is built as a user service.

## Testing

A `tests` script is provided to test exceptions and terminations.

To test main functionality, you may use VLC.

Open VLC, navigate to `Media > Open Network Stream` and enter `udp://@:$PORT`
replacing $PORT with which port your stream is pointing to. `00-default` uses
port 10023.

Show verbose terminal output with `./koala -v` or `./koala --verbose`.

## Useful links

[FFmpeg UDP](http://underpop.online.fr/f/ffmpeg/help/examples-120.htm.gz)

[FFmpeg MPEG-TS](https://www.ffmpeg.org/ffmpeg-formats.html#mpegts-1)

[MPEG-TS Wikipedia](https://en.wikipedia.org/wiki/MPEG_transport_stream)

[FFmpeg Streaming Guide](https://trac.ffmpeg.org/wiki/StreamingGuide)

[Chromium CLI Switches](https://peter.sh/experiments/chromium-command-line-switches/)
