# Use the official NGINX image as the base
FROM nginx:latest

# Copy custom files into the default HTML directory
COPY . /usr/share/nginx/html
