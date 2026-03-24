FROM node:18 as builder

WORKDIR /app
COPY . .

ENV NODE_OPTIONS=--openssl-legacy-provider

RUN npm install
RUN npm run build

FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html

EXPOSE 80