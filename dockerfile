# Use the official Hugo image
FROM klakegg/hugo:latest as builder

# Set the working directory
WORKDIR /app

# Copy your Hugo site
COPY . .

# Build the static files
RUN server

# Use Nginx to serve the site
FROM nginx:alpine
COPY --from=builder /app/public /usr/share/nginx/html
