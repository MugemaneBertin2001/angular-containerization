FROM node:22-alpine3.18 AS build
WORKDIR /app
COPY package.json ./
RUN  npm install
RUN npx ngcc --properties es2023 browser module main --first-only --create-ivy-entry-points
COPY . .
RUN npm run build
FROM nginx:latest
COPY  default.conf /etc/nginx/conf.d
COPY --from=build /app/dist/angular-containerization /usr/share/nginx/html
EXPOSE 80
