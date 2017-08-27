FROM ajoergensen/baseimage-alpine
MAINTAINER ajoergensen

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-url="https://github.com/ajoergensen/docker-sshd.git" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0.0-rc1"

COPY root/ /

RUN \
	/build/setup.sh && \
	rm -rf /build

EXPOSE 22

VOLUME /config /etc/ssh/keys
