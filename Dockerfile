FROM golang:1.8-alpine as build-server
RUN apk --no-cache add make
COPY . /opt/golm
WORKDIR /opt/golm
RUN make build-server

FROM codesimple/elm:0.18 as build-ui
RUN apt-get update && apt-get install -y \
    automake \
 && rm -rf /var/lib/apt/lists/*
COPY . /opt/golm
WORKDIR /opt/golm
RUN make build-ui

FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=build-server /opt/golm/golm /
COPY --from=build-server /opt/golm/templates /templates
COPY --from=build-ui /opt/golm/js /js
CMD ["/golm"]
EXPOSE 1337
