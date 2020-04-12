# pull official base image
FROM node:13.12.0-alpine

# set working directory
WORKDIR /frontend/app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /frontend/app/node_modules/.bin:$PATH

# install app dependencies
COPY /frontend/app/package.json ./

# COPY /frontend/app/package-lock.json ./
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent

# add app
COPY /frontend/app ./

# start app
CMD ["npm", "start"]