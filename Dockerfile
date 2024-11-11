# Dockerfile
FROM nginx:latest

# Copy content to serve
COPY ./index.html /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80
