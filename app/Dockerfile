FROM nginx:1.30.6-alpine-slim

ARG BUILD_SHA=local

LABEL maintainer="Kpere Ragnar"
LABEL description="DevOps Intern Final Assessment NGINX Application"

COPY --chown=nginx:nginx nginx.conf /etc/nginx/nginx.conf
COPY --chown=nginx:nginx index.html /usr/share/nginx/html/index.html

RUN sed -i "s/__BUILD_SHA__/${BUILD_SHA}/g" /usr/share/nginx/html/index.html \
    && mkdir -p /tmp/client_temp \
                /tmp/proxy_temp \
                /tmp/fastcgi_temp \
                /tmp/uwsgi_temp \
                /tmp/scgi_temp \
    && chown -R nginx:nginx /tmp

USER nginx

EXPOSE 8080

HEALTHCHECK --interval=30s \
            --timeout=3s \
            --start-period=5s \
            --retries=3 \
            CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
