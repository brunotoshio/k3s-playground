FROM nginx:1.19.0-alpine

COPY src/production.template /etc/nginx/conf.d/production.template
COPY src/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /data/nginx/cache
