FROM ubuntu:17.04
MAINTAINER Mendelson Gusmão
RUN apt-get -yy update \
&& apt-get -y install --no-install-recommends wget libx11-6 libx11-xcb1 libfontconfig1 supervisor xvfb x11vnc software-properties-common openbox xterm\
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN addgroup soulseek
RUN useradd -m -s /bin/bash -g soulseek soulseek
RUN echo "soulseek:soulseek" | /usr/sbin/chpasswd
RUN echo "soulseek    ALL=(ALL) ALL" >> /etc/sudoers
WORKDIR /home/soulseek
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD menu.xml /etc/xdg/openbox/menu.xml
RUN wget -qO /tmp/soulseek.tgz https://www.dropbox.com/s/7qh902qv2sxyp6p/SoulseekQt-2016-1-17-64bit.tgz?dl=1
RUN tar xvf /tmp/soulseek.tgz -C /usr/bin && rm /tmp/soulseek.tgz
RUN mv /usr/bin/SoulseekQt-2016-1-17-64bit /usr/bin/soulseek
RUN chown soulseek:soulseek /usr/bin/soulseek*
RUN chown soulseek:soulseek /home/soulseek
ENV DISPLAY :1
ADD start /bin/start
USER soulseek
EXPOSE 5900 2234 2235
CMD ["/bin/start"]
