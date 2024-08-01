# Stage 1: Build the React app add base-image environment
FROM node:16 AS build
# Set the working directory
WORKDIR /app


# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the source code
COPY . .


# Build the React app
RUN npm run build

# Stage 2: Serve the app
FROM nginx:alpine


# Copy the build files from the previous stage
COPY --from=build /app/build /usr/share/nginx/html


# Expose port 80
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]