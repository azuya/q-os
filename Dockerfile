# Stage 1: Build Vue project
FROM node:18 as builder

WORKDIR /app

# Clone Q-OS-UI repo
RUN git clone https://github.com/IceWhaleTech/Q-OS-UI.git . \
    && rm -rf .git

# Salin branding dan logo custom
COPY public/logo.png ./public/logo.png
COPY src/branding.js ./src/branding.js
COPY src/App.vue ./src/App.vue
COPY src/components/Header.vue ./src/components/Header.vue

# Install dan build
RUN npm install && npm run build

# Stage 2: Serve via nginx
FROM nginx:alpine

COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]