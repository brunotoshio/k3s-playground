FROM nginx:1.19.0-alpine

COPY src/default.conf /etc/nginx/conf.d/default.conf
COPY src/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /data/nginx/cache
