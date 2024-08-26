FROM alpine:3.20

# Install packages needed to build
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    python3 py3-pip \
    wget \
	  git \
    aws-cli

# Install hugo.
ARG HUGO_VERSION=0.89.1
ARG HUGO_SHA256=4a4072150791e2b0d0b60b408775c7feb33cf95a888be200dffabab56cb48b7a

# Rember sha256sum (and md5sum) expect 2 spaces in front of the filename on alpine...s
RUN curl -Ls https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz \
       -o /tmp/hugo.tar.gz \
  && echo "${HUGO_SHA256}  /tmp/hugo.tar.gz" | sha256sum -c - \
  && tar xf /tmp/hugo.tar.gz -C /tmp \
  && mv /tmp/hugo /usr/bin/hugo \
  && rm -rf /tmp/hugo*