#STEP 1 BUILD VUE PROJECT
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json ./
RUN yarn install
COPY . . 
RUN yarn build


#STEP 2 CREATE ENGINE SERVER
FROM nginx:1.23.1-alpine as prod-stage
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

