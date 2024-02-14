FROM --platform=arm64 node:20-alpine AS build
WORKDIR /app

COPY ./frontend/package*.json ./

RUN npm install

COPY ./frontend/ ./

RUN npm run build

# Serve stage
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

# Copy custom Nginx configuration
COPY ./frontend/config/nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
