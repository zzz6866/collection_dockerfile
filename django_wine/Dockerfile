FROM buildpack-deps:buster

ENV DJANGO_SETTINGS_MODULE alldev.settings.production
ENV WINEPREFIX /root/.wine32
ENV WINEARCH win32 winecfg
ENV DISPLAY :0
ENV DEBIAN_FRONTEND noninteractive

# wine insall
# => https://computingforgeeks.com/how-to-install-wine-on-debian/
# => https://linuxhint.com/installing_wine_debian_10/
RUN set -ex && \
    dpkg --add-architecture i386 && \
    apt-get update  && \
    apt-get -y install gnupg2 software-properties-common apt-utils && \
    wget -qO - https://dl.winehq.org/wine-builds/winehq.key | apt-key add -  && \
    apt-add-repository https://dl.winehq.org/wine-builds/debian/ && \
    wget -O- -q https://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10/Release.key | apt-key add - && \
    echo "deb http://download.opensuse.org/repositories/Emulators:/Wine:/Debian/Debian_10 ./" | tee /etc/apt/sources.list.d/wine-obs.list && \
    apt-add-repository contrib && \
    apt-get update && apt-get install -y --install-recommends winehq-stable winetricks

RUN wget -P /opt/wine-stable/share/wine/mono https://dl.winehq.org/wine/wine-mono/5.1.1/wine-mono-5.1.1-x86.msi
RUN wget -P /opt/wine-stable/share/wine/gecko https://dl.winehq.org/wine/wine-gecko/2.47.1/wine-gecko-2.47.1-x86.msi

# install novnc
RUN apt-get install -y x11vnc xvfb fluxbox novnc supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# setting language utf-8 korea
RUN apt-get install -y locales
RUN locale-gen ko_KR.UTF-8
RUN localedef -i ko_KR -f UTF-8 ko_KR
ENV LANG ko_KR.UTF-8
ENV LANGUAGE ko_KR.UTF-8
ENV LC_ALL ko_KR.UTF-8



# default packages install
RUN apt-get install -y git pwgen net-tools vim fonts-nanum*

# setting font
RUN fc-cache -fv

# apt-get clean
RUN set -ex && \
	apt-get autoclean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

# useradd
#RUN useradd django
#USER django
#WORKDIR /home/django

# django 8000, vnc server 5900
EXPOSE 8000 5900

CMD ["/usr/bin/supervisord"]