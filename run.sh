export DISPLAY=:99
URL="https://editor.wallboard.us/displayer/index.html#/87ba0422c82d4fd280925e31ac1709ac/Default?signageModeSecret=35b3cc6795534c488b2335c89ce25891"

Xvfb :99 -screen 0 1920x1080x24 &
  i3 &
  chromium \
    --kiosk \
    --fullscreen \
    ${URL}
