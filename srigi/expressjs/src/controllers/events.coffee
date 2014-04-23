Event = require '../models/event'
User = require '../models/user'
EventUser = require '../models/eventUser'


index = (req, res) ->
  userUuid = req.get('X-RS-user_uuid')
  user = new User(uuid:userUuid)

  user.fetch().then (result) ->
    user.save() if !result

    Event.collection().query((qb) ->
      # not very proud of using low-level functions, but only one SELECT
      qb.join('events_users', 'events.id', '=', 'events_users.event_id', 'left')
        .join('users', 'events_users.user_id', '=', 'users.id', 'left')
        .orderBy('begin_time')
    ).fetch({withRelated:'users'}).then (result) ->
      result = result.toJSON()

      # compute attendance by looking in event.users and searching for userUuid
      result.forEach (event) ->
        event.users = event.users.filter (user) ->
          user.uuid == userUuid
        event.attending = !!event.users.length
        delete event.users

      res.send(result)

toggleAttend = (req, res) ->
  userUuid = req.get('X-RS-user_uuid')
  eventId = req.params.id
  user = new User(uuid:userUuid)

  user.fetch().then (result) ->
    return res.send(404) if !result

    eventUser = new EventUser({ event_id:eventId, user_id:user.id })
    eventUser.fetch().then (result) ->
      if result
        eventUser.query((qb) -> # Model cannot be destroyed without an idAttribute, create WHERE
          qb.where('event_id', eventId)
            .andWhere('user_id', user.id)
        ).destroy()
      else
        eventUser.save()
      res.send(200)



exports = module.exports = (app) ->
  app.get("/events", index)
  app.post("/events/:id/toggleAttend", toggleAttend)
