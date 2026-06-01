# Use the official lightweight Nginx image based on Alpine Linux
FROM nginx:alpine

# Set the working directory inside the container
# Nginx serves website files from this default web root directory
WORKDIR /usr/share/nginx/html

# Copy the local index.html file
# into the container working directory
COPY index.html index.html

# Inform Docker that the container uses port 80 for HTTP traffic
EXPOSE 80

# Start the Nginx web server
# "-g daemon off;" keeps Nginx running in foreground mode
# so the Docker container stays alive
# If Nginx runs in background, the container will stop immediately
CMD ["nginx", "-g", "daemon off;"]