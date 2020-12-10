FROM alpine:3.6
MAINTAINER Karel Bemelmans <mail@karelbemelmans.com>

# Install packages needed to build
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    python \
    py-pip \
    wget \
	git \
  && pip install --upgrade pip \
  && pip install -U awscli

# Install hugo.
ARG HUGO_VERSION=0.79.0
ARG HUGO_SHA256=1e5a2909e2c121823113f4c2fd2f4818b77319dc12991221d90f4fa66db04f9c

# Rember sha256sum (and md5sum) expect 2 spaces in front of the filename on alpine...
RUN curl -Ls https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
       -o /tmp/hugo.tar.gz \
  && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
  && tar xf /tmp/hugo.tar.gz -C /tmp \
  && mv /tmp/hugo /usr/bin/hugo \
  && rm -rf /tmp/hugo* \
