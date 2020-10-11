FROM python:3.7.5

# apt-get insall
RUN set -ex && \
    apt-get update && \
    apt-get install -y supervisor curl git pwgen

# apt-get clean
RUN set -ex && \
	apt-get autoclean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/*

# useradd
RUN addgroup -S django && adduser -S django -G django
USER django
WORKDIR /home/django

# django 8000
EXPOSE 8000

#COPY entrypoint.sh entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]