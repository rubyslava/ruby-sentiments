angular.module('rs.events')

.factory 'EventsResource', ($resource) ->
  res = $resource('/events/:id', {
    id: '@id'
  })

  return res
