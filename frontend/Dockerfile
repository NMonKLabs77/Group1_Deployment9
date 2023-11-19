# Use Node 10 as the base image
FROM node:10

# Git Clone
RUN git clone https://github.com/NMonKLabs77/Group1_Deployment9.git

# Set the working directory
WORKDIR Group1_Deployment9/frontend/

# Copy the local directory contents into the container
COPY . .

# Install dependencies
RUN npm install --save-dev @babel/plugin-proposal-private-property-in-object
RUN npm install

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
