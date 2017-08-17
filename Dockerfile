FROM alpine:3.6
MAINTAINER Mendelson Gusmão
RUN apk update
RUN apk add supervisor openbox xvfb xterm libstdc++ libgcc libc6-compat
RUN apk add x11vnc --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted
RUN addgroup -S soulseek
Run adduser -S -g soulseek soulseek
RUN echo "soulseek:soulseek" | /usr/sbin/chpasswd
RUN echo "soulseek    ALL=(ALL) ALL" >> /etc/sudoers
WORKDIR /home/soulseek
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD menu.xml /etc/xdg/openbox/menu.xml
ADD https://www.dropbox.com/s/7qh902qv2sxyp6p/SoulseekQt-2016-1-17-64bit.tgz?dl=1 /tmp/soulseek.tgz
RUN tar xvf /tmp/soulseek.tgz -C /usr/bin
RUN rm /tmp/soulseek.tgz
RUN mv /usr/bin/SoulseekQt-2016-1-17-64bit /usr/bin/soulseek
RUN chown soulseek:soulseek /usr/bin/soulseek*
RUN chown soulseek:soulseek /home/soulseek
ENV DISPLAY :1
ADD start /bin/start
USER soulseek
EXPOSE 5900 6080
CMD ["/bin/start"]
