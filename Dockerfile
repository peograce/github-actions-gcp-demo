# FROM nginx:latest

# RUN echo "Hello World!" > /usr/share/nginx/html/index.html

FROM nginx:alpine

# Replace Nginx default config to listen on $PORT (Cloud Run provides PORT=8080)
RUN apk add --no-cache bash
RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak

# Add template that uses $PORT
RUN echo 'server {\n\
  listen ${PORT};\n\
  location / {\n\
    root /usr/share/nginx/html;\n\
    index index.html;\n\
  }\n\
}' > /etc/nginx/conf.d/default.conf.template

# Enable Nginx template support
ENV NGINX_ENVSUBST_TEMPLATE_DIR=/etc/nginx/conf.d
ENV NGINX_ENVSUBST_OUTPUT_DIR=/etc/nginx/conf.d

# Add index.html
RUN echo "Hello from Nginx on Cloud Run!" > /usr/share/nginx/html/index.html

# Expose Cloud Run port
EXPOSE 8080

CMD ["/docker-entrypoint.sh", "nginx", "-g", "daemon off;"]
