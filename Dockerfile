# Step 1: Use Node.js image for the build process
FROM node:18-alpine as build-stage

# Step 2: Copy the backend's package.json and package-lock.json into the container
COPY ./server/package.json ./server/package-lock.json ./server/

# Step 3: Install backend dependencies
RUN cd server && npm install

# Step 4: Copy the frontend's package.json and package-lock.json into the container
COPY ./billing-system/package.json ./billing-system/package-lock.json ./billing-system/

# Step 5: Install frontend dependencies
RUN cd billing-system && npm install

# Step 6: Copy all frontend files (including public and src directories)
COPY ./billing-system ./billing-system

# Step 7: Build the React frontend
RUN cd billing-system && npm run build

# Step 8: Copy all backend files
COPY ./server ./server
COPY ./server/.env ./server/.env
# Step 9: Install serve and nodemon globally
RUN npm install -g serve nodemon

# Step 10: Expose necessary ports (React frontend on 3000, Node backend on 5000)
EXPOSE 3000  
 # React frontend
EXPOSE 5000  
 # Node.js backend


# Step 11: Command to start both backend and frontend
CMD ["sh", "-c", "nodemon ./server/index.js & serve -s ./billing-system/build -l 3000"]
