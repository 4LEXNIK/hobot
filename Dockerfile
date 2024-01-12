FROM golang:1.21 as builder

WORKDIR /go/src/app
COPY . .
ARG TARGETARCH
RUN make build TARGETARCH=$TARGETARCH

FROM alpine:latest as tzdata

RUN apk add --no-cache tzdata

FROM scratch

WORKDIR /
COPY --from=builder /go/src/app/hobot .
COPY --from=tzdata /usr/share/zoneinfo /usr/share/zoneinfo
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Установка переменной окружения TELE_TOKEN
ENV TELE_TOKEN 6936816360:AAFG6gKf-zuf7CGzmWXie4fI6wlbl2q0S3E

ENTRYPOINT ["./hobot"]