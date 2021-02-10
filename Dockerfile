FROM node:latest as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install -g @vue/cli
RUN npm install
COPY . .
RUN npm run build

# etapa de producción
FROM nginx as production-stage
RUN mkdir /app
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build-stage /app/dist /app
