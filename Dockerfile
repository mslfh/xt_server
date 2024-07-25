FROM node:18

WORKDIR /admin

#ENV NODE_ENV="production"
ENV TZ="UTC"

COPY package.json ./
#COPY yarn.lock ./

#RUN yarn install --frozen-lockfile --production
RUN yarn install
COPY . .

RUN npm i -g typescript
RUN yarn build
#RUN npx prisma generate
#RUN rm -rf src

#ENV ADMIN_JS_SKIP_BUNDLE="true"

EXPOSE 5000
CMD yarn start
