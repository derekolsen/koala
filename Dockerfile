FROM debian:stable
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y xvfb
RUN apt-get install -y i3
RUN mkdir -p ~/.config/i3 && cp /etc/i3/config ~/.config/i3/config
RUN apt-get install -y ffmpeg
RUN apt-get install -y chromium
WORKDIR /koala
COPY . .
CMD /koala/run.sh
