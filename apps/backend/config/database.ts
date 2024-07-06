import env from '#start/env'
import { defineConfig } from '@adonisjs/lucid'
import { AWS_PUBLIC_PEM } from './awsPublicPem.js'

const SSL_CONFIG = {
  ca: AWS_PUBLIC_PEM,
}

const dbConfig = defineConfig({
  connection: 'main',
  connections: {
    main: {
      client: 'pg',
      connection: {
        host: env.get('DB_HOST'),
        port: env.get('DB_PORT'),
        user: env.get('DB_USER'),
        password: env.get('DB_PASS'),
        database: env.get('DB_NAME'),
        ssl: env.get('NO_POSTGRES_SSL') ? false : SSL_CONFIG,
      },
      migrations: {
        naturalSort: true,
        paths: ['database/migrations'],
      },
    },
  },
})

export default dbConfig
