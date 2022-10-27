export DISPLAY=:99
URL="https://editor.wallboard.us/displayer/index.html#/87ba0422c82d4fd280925e31ac1709ac/Default?signageModeSecret=35b3cc6795534c488b2335c89ce25891"
DEST="192.168.0.61:10023"
RES="1920x1080"

_kill_procs() {
  kill -TERM $ffmpeg
  kill -TERM $chromium
  wait $chromium
  kill -TERM $i3
  kill -TERM $xvfb
}

trap _kill_procs SIGTERM

Xvfb :99 -screen 0 ${RES}x24 &
$xvfb=$!

i3 &
$i3=$!

chromium \
    --kiosk \
    --fullscreen \
    --no-sandbox \
    ${URL} &
$chromium=$!

ffmpeg \
  -video_size ${RES} \
  -y \
  -r 30 \
  -f x11grab \
  -draw_mouse 0 \
  -s ${RES} \
  -i :99 \
  -b:v 6000k \
  -f mpegts \
  udp://${DEST} &
$ffmpeg=$!

wait $ffmpeg
wait $chromium
wait $i3
wait $xvfb
