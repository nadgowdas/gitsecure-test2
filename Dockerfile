FROM golang:1.11
RUN apt-get update --fix-missing && apt-get install -y --fix-missing libnghttp2-14=1.36.0-2
WORKDIR /go/src/github.com/multi-stage3
RUN go get -d -v golang.org/x/net/html  
COPY app.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
WORKDIR /root/
COPY --from=0 /go/src/github.com/multi-stage3/app .
CMD ["./app"]  
