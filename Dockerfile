FROM golang:1.22 AS build

WORKDIR /app

COPY go.mod ./

RUN go mod download

COPY . .

RUN go build -o ./main .

FROM gcr.io/distroless/base

WORKDIR /app

COPY --from=build /app/main /app

COPY --from=build /app/static /app/static

EXPOSE 8081

CMD ["./main"]
