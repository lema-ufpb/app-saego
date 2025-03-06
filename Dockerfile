FROM node:21.1-alpine3.17

USER root 
RUN apk update && apk upgrade --no-cache

RUN addgroup -S app_group && adduser -S app_user -G app_group

WORKDIR /app

RUN chown -R app_user:app_group /app

COPY --chown=app_user:app_group ./package.json /app
COPY --chown=app_user:app_group ./index.html /app
COPY --chown=app_user:app_group ./css /app/css
COPY --chown=app_user:app_group ./img /app/img
COPY --chown=app_user:app_group ./js /app/js
COPY --chown=app_user:app_group ./.npmrc /app

RUN npm install 

USER app_user

EXPOSE 3000
CMD ["npm", "run", "server"]
