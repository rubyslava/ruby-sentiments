db = require '../db'


exports = module.exports = EventUser = db.Model.extend({
  tableName: 'events_users'
  idAttribute: null
})
