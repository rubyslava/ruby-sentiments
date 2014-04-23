db = require '../db'
Event = require './event'


exports = module.exports = User = db.Model.extend({
  tableName: 'users'
})
