FROM oven/bun:alpine AS bundler

WORKDIR /app

COPY package.json .
COPY bun.lock .
COPY index.ts .
COPY static/* ./static/

RUN bun install --production --frozen-lockfile
RUN bun build ./index.ts --outfile ./build/index.js --minify --target bun

FROM oven/bun:alpine

WORKDIR /app

RUN apk add --no-cache curl

COPY --from=bundler /app/build/index.js /app/index.js
COPY --from=bundler /app/static /app/static

HEALTHCHECK --interval=60s --retries=5 CMD curl --fail http://localhost:3000/api/status || exit 1

ENTRYPOINT ["bun", "run", "index.js"]
