# base image
FROM node:21.1-alpine3.17
LABEL Description="Imagem NodeJS App" Vendor="LEMA-UFPB <contato@lema.ufpb.br>" Version="1.0"

USER root 
RUN apk update && apk upgrade --no-cache

RUN adduser --shell /sbin/nologin --disabled-password \
    --uid 5000 --ingroup root app-user

WORKDIR /app

COPY ./package.json /app
COPY ./index.html /app
COPY ./css /app/css
COPY ./img /app/img
COPY ./js /app/js
COPY ./.npmrc /app

RUN npm install 

USER app-user

EXPOSE 3000
CMD npm run server


