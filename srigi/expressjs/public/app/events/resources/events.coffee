angular.module('rs.events')

.factory 'EventsResource', ($resource) ->
  res = $resource('/events/:id/:subaction', {
    id: '@id'
    subaction: '@subaction'

  }, {
    toggleAttend: {
      method: 'POST'
      params: { subaction:'toggleAttend' }
    }

  })


  return res
