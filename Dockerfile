#Build Phase for production

# Specify a base image
FROM node:alpine as builder

WORKDIR /app

# Install some depenendencies
COPY ./package.json ./
RUN npm install
COPY . .

# Default command
RUN npm run build

#Run Phase for production

# Specify a base image
FROM nginx
#only understood by the elastic beanstalk not on local
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
