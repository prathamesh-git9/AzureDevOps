# Use the official NGINX image as a base
FROM nginx:latest

# Copy local files to the container's web directory
COPY . /usr/share/nginx/html
