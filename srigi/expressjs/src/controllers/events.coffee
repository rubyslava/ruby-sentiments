Event = require '../models/event'


index = (req, res) ->
  Event.collection().fetch().then (collection) ->
    res.send(collection.toJSON())


exports = module.exports = (app) ->
  app.get("/events", index)
