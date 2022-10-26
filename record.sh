DEST="192.168.0.61:10023"

ffmpeg \
  -video_size 1920x1080 \
  -y \
  -r 30 \
  -f x11grab \
  -draw_mouse 0 \
  -s 1920x1080 \
  -i :99 \
  -b:v 6000k \
  -f mpegts \
  udp://${DEST}
