# Build stage
FROM node:lts-alpine as build-stage

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files and folders to the current working directory (i.e., /app)
COPY . .

# Build app for production with minification
RUN npm run build

# Production stage
FROM nginx:stable-alpine as production-stage

# Copy built assets from build-stage to nginx server
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Expose port 80 to the Docker host, so we can access it
EXPOSE 80

# Start nginx when the container launches
CMD ["nginx", "-g", "daemon off;"]
