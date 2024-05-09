FROM base

WORKDIR /app/apps/backend/build

RUN pnpm i --prod --config.confirmModulesPurge=false

COPY --from=base /app/apps/backend/.env.production .

EXPOSE 3333

CMD [ "node", "bin/server.js" ]