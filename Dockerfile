# Dockerfile
FROM nginx:latest

# Copy content to serve
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80
