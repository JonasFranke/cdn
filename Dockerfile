FROM oven/bun:latest AS builder

WORKDIR /app

COPY . .

RUN bun install
RUN bun build index.ts --outfile ./build/index.js --minify --target bun

FROM oven/bun:alpine

WORKDIR /app
COPY --from=builder /app/build .
COPY --from=builder /app/static .

ENTRYPOINT [ "bun" "index.js" ]
