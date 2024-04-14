# Use the official Nginx image as the base image
FROM nginx:alpine as runtime

# install openssh
RUN apk add --no-cache openssh
# install ssl
RUN apk add --no-cache openssl
# run ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/nginx.key -out /etc/nginx/nginx.crt -subj "/C=IL/ST=Tel Aviv/L=Tel Aviv/O=Security/CN=localhost"

# Copy custom Nginx configuration file to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 and 443 to the outside world
EXPOSE 80
EXPOSE 443

# Command to start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
