import db from '@adonisjs/lucid/services/db'

export default class DatabaseService {
  get mainDb() {
    return db.connection('main')
  }
}
