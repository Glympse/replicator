# Replicator is a daemon that provides automatic scaling of Nomad jobs and
# worker nodes.
#
# docker run --rm -it \
# 			 --name replicator \
#				 elsce/replicator agent

FROM alpine:edge
LABEL maintainer Kainoa Seto<(kainoa.seto@gmail.com>
LABEL vendor "Glympse Engineering"
LABEL documentation "https://github.com/glympse/replicator"

ENV REPLICATOR_VERSION v1.1.1

WORKDIR /usr/local/bin/

RUN     apk --no-cache add \
        ca-certificates

RUN buildDeps=' \
                bash \
                wget \
        ' \
        set -x \
        && apk --no-cache add $buildDeps \
        && wget -O replicator https://github.com/glympse/replicator/releases/download/${REPLICATOR_VERSION}/linux-amd64-replicator \
        && chmod +x /usr/local/bin/replicator \
        && apk del $buildDeps \
        && echo "Build complete."

ENTRYPOINT [ "replicator" ]
CMD [ "agent", "--help" ]
