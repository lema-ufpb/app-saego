FROM node:21.1-alpine3.17 AS builder

WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

COPY ./index.html ./
COPY ./css ./css
COPY ./img ./img
COPY ./js ./js
COPY ./.npmrc ./

RUN addgroup -S app_group && adduser -S app_user -G app_group

FROM node:21.1-alpine3.17 AS runner

WORKDIR /app
RUN addgroup -S app_group && adduser -S app_user -G app_group
RUN chown -R app_user:app_group /app

COPY --from=builder --chown=app_user:app_group /app/node_modules ./node_modules
COPY --from=builder --chown=app_user:app_group /app/index.html ./
COPY --from=builder --chown=app_user:app_group /app/css ./css
COPY --from=builder --chown=app_user:app_group /app/img ./img
COPY --from=builder --chown=app_user:app_group /app/js ./js


USER app_user

EXPOSE 3000
CMD ["npm", "run", "server"]
