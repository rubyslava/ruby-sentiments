Event = require '../models/event'


index = (req, res) ->
  Event.collection().fetch().then (collection) ->
    res.render('index/index', { userEvents:collection.models })


exports = module.exports = (app) ->
  app.get("/", index)
