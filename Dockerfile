# build
FROM golang:1.9 as build

LABEL maintainer="sebastian.doell@axelspringer.de"
LABEL build="true"

ARG CONFD_VERSION

ENV VERSION ${CONFD_VERSION:-0.14.0}

RUN \
  mkdir -p /go/src/github.com/kelseyhightower/confd && \
  ln -s /go/src/github.com/kelseyhightower/confd /app && \
  go get github.com/tcnksm/ghr && \
	go get github.com/mitchellh/gox

WORKDIR /app

RUN wget -O /tmp/confd.zip https://github.com/kelseyhightower/confd/archive/v${VERSION}.tar.gz && \
  tar --strip-components=1 -xzvf /tmp/confd.zip -C /app && \
  gox -output "bin/{{.Dir}}_${VERSION}_{{.OS}}_{{.Arch}}" -os="linux" -arch="amd64" ./

# canary
FROM ubuntu:xenial

LABEL maintainer="sebastian.doell@axelspringer.de"
LABEL build="true"

ARG CONFD_VERSION

ENV VERSION ${CONFD_VERSION:-0.14.0}

COPY \
  --from=build /app/bin/confd_${VERSION}_linux_amd64 /usr/local/bin/confd

COPY \
    init.sh /

RUN \
    chmod +x /init.sh

RUN \
    apt-get update && \
    apt-get -y --no-install-recommends install curl apt-transport-https ca-certificates

RUN \
  curl -fLsS -o /usr/local/bin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 && \
  chmod +x /usr/local/bin/dumb-init

RUN \
  mkdir -p /etc/confd/conf.d && \
  mkdir -p /etc/confd/conf.d/templates

VOLUME ["/etc/confd"]

ENTRYPOINT ["/usr/local/bin/dumb-init", "/init.sh", "/usr/local/bin/confd"]
