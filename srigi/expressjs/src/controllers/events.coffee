Event = require '../models/event'
User = require '../models/user'


index = (req, res) ->
  userUuid = req.get('X-RS-user_uuid')
  user = new User(uuid:userUuid)

  user.fetch().then (result) ->
    user.save() if !result

    Event.collection().fetch().then (collection) ->
      res.send(collection.toJSON())


exports = module.exports = (app) ->
  app.get("/events", index)
