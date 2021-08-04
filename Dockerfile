FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
 
FROM nginx
# für elastic beanstalk: Port 80 soll automatisch gemappt werden
EXPOSE 80
# kopiert nur den Ordner build aus Block1 in den nginx Container
# Zweck: alles andere wird nicht benötigt und kopiert
COPY --from=0 /app/build /usr/share/nginx/html
# nginx wird automatisch gestartet