# Stage 1 : Build de l'application Node.js
FROM node:20-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Stage 2 : Image de production Nginx pour servir le build statique
FROM nginx:alpine

# Copier les fichiers compilés (dossier dist ou public selon la config du projet)
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]