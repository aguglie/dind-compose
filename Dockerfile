FROM docker:19.03.4-dind

ENV EDGE_MAIN http://dl-cdn.alpinelinux.org/alpine/edge/main
ENV EDGE_COMMUNITY http://dl-cdn.alpinelinux.org/alpine/edge/community

RUN apk update --repository=$EDGE_MAIN --repository=$EDGE_COMMUNITY \
	&& apk --no-cache add git curl make python3 python3-dev gcc libc-dev libffi-dev \
        openssl-dev --repository=$EDGE_MAIN --repository=$EDGE_COMMUNITY \
	&& pip3 --no-cache-dir install --upgrade pip \
	&& pip3 --no-cache-dir install docker-compose==1.24.1 \
	&& rm -f /var/cache/apk/* \
	&& rm -rf /root/.cache
