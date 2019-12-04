FROM library/alpine:3.7 as timezone

# Ref: https://wiki.alpinelinux.org/wiki/Setting_the_timezone
# Use multistage, so this image can always be cached
RUN apk add --no-cache tzdata \
	&& cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone


# ---------- 8< ----------

FROM library/alpine:3.7

COPY --from=timezone /etc/localtime /etc/localtime
COPY --from=timezone /etc/timezone  /etc/timezone

RUN apk add --no-cache ca-certificates bash \
    && mkdir -pv /project/log /project/config
WORKDIR /project
ADD ./console /project/console
ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod +x   /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]