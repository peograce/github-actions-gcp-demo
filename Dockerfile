# FROM nginx:latest

# RUN echo "Hello World!" > /usr/share/nginx/html/index.html

FROM nginx:latest

# Replace port 80 with port 8080 in default nginx config
RUN sed -i 's/80/8080/' /etc/nginx/conf.d/default.conf

# Add your index.html content
RUN echo "Hello World!" > /usr/share/nginx/html/index.html

# Cloud Run expects the app to listen on PORT (usually 8080)
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
