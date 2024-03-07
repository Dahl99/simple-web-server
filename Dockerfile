FROM golang:1.22 AS builder

WORKDIR /src

COPY go.mod ./

#RUN go mod download all

COPY . ./

RUN CGO_ENABLED=0 go build -v -o /bin/app ./main.go

FROM scratch AS final

WORKDIR /app

COPY --from=builder /bin/app ./

CMD ["./app"]