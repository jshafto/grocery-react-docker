# serve a production react app

# build-stage
FROM node:15-alpine as build-stage

# Step 2: Set the working directory to /app
WORKDIR /app

COPY package*.json ./

# install dependences
RUN npm install && npm cache clean --force

# copy rest of files
COPY . .
# build app
RUN npm run build

# stage 2: nginx production server
FROM nginx:1.18-alpine

WORKDIR /usr/share/nginx/html

# copy in all production files
COPY --from=build-stage /app/build ./

# configure for react router
COPY nginx.conf /etc/nginx/conf.d/default.conf
