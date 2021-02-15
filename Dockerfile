FROM node:latest

USER root
RUN mkdir -p /home/node/app/views 
WORKDIR /home/node/app

COPY . .
RUN npm install

ENV PORT 8082
EXPOSE 8082

USER 1001
CMD ["npm", "start"]
LABEL app='nodejs'
