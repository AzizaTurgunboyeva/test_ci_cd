FROM node:alpine AS builder
WORKDIR /app
ADD package*.json ./
RUN NPM ci
ADD . .
RUN npm run buid --prod

FROM node:alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
ADD package.json ./
RUN npm i --omit=dev 
CMD ["node,"./dist/main.js]
