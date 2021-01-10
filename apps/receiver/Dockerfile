FROM golang:1.15-buster
# https://hub.docker.com/_/golang

ENV DEBIAN_FRONTEND=noninteractive

# Build & Setting
WORKDIR /go/src/receiver
COPY . .

RUN set -eux \
    && go get -d -v ./... \
    && go install -v ./...

ENV DEBIAN_FRONTEND=dialog

CMD ["receiver"]
