FROM base

WORKDIR /app/apps/backend/build

RUN pnpm i --prod --config.confirmModulesPurge=false

COPY --from=base /app/apps/backend/.env.production .env.local

EXPOSE 3333

ENV NODE_ENV=production

CMD [ "node", "bin/server.js" ]