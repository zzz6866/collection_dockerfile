FROM buildpack-deps:buster

ENV DJANGO_SETTINGS_MODULE alldev.settings.production
ENV WINEPREFIX /root/.wine32
ENV WINARCH win32 winetricks corefonts win10
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
    apt-get update && apt-get install -y --install-recommends wine-stable winetricks

# install novnc
RUN apt-get install -y x11vnc xvfb fluxbox novnc supervisor

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# default packages install
RUN apt-get install -y git pwgen net-tools vim

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