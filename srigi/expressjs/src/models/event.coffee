db = require '../db'


exports = module.exports = Event = db.Model.extend({
  tableName: 'events'
})
