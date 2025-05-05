FROM node:22-alpine as BASE

WORKDIR /app

COPY package*.json ./

RUN npm install 

COPY . .

EXPOSE 8000
ENV PORT=8000

CMD ["npm", "run", "start"]
