FROM benzbrake/alpine as builder
WORKDIR /
ARG BUILD_VERSION="latest"
ADD ["healthcheck.sh","tracker.sh", "aria2.conf", "entrypoint.sh", "/data/"]
ADD ["download_aria2.sh","/"]
RUN chmod +x /download_aria2.sh && /download_aria2.sh

FROM benzbrake/alpine
LABEL maintainer="Ryan Lieu <github-benzBrake@woai.ru>"

COPY --from=builder /aria2/aria2c /bin/aria2c
COPY --from=builder /aria2/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=builder /data /data
ENV TZ="Asia/Shanghai" PUID="1000" PGID="1000" UPDATE_TRACKER="true"
RUN set -ex && \
    apk add --update --no-cache su-exec && \
    chmod +x /bin/aria2c /data/*.sh
HEALTHCHECK --interval=5s --timeout=3s \
    CMD /data/healthchek.sh
VOLUME /data/aria2
EXPOSE 6800 6880
ENTRYPOINT ["/data/entrypoint.sh"]