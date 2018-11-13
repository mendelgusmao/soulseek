FROM debian:stretch-slim
MAINTAINER github.com/mendelgusmao

ENV DISPLAY :1
ENV SOULSEEK_DL "https://www.dropbox.com/s/7qh902qv2sxyp6p/SoulseekQt-2016-1-17-64bit.tgz?dl=1"

RUN apt-get -yy update \
    && apt-get -y install --no-install-recommends \
       wget ca-certificates libx11-6 libx11-xcb1 libfontconfig1 supervisor xvfb x11vnc openbox \
    && addgroup soulseek \
    && useradd -m -s /bin/bash -g soulseek soulseek

RUN wget -qO- "$SOULSEEK_DL" | tar xzvf - -C /usr/bin --transform='s/.*/soulseek/' \
    && (apt-get -y remove --purge wget ca-certificates; \
        apt-get -y autoremove --purge; \
        apt-get clean; \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/*)

ADD root /

USER soulseek
EXPOSE 5900 2234 2235

CMD ["/bin/start"]
