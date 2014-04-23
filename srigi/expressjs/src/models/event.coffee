db = require '../db'
User = require './user'


exports = module.exports = Event = db.Model.extend({
  tableName: 'events'

  users: ->
    @belongsToMany(User)

})
