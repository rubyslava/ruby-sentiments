angular.module('rs', [
  'rs.shared'
  'rs.events'
])

.run ($http, $localStorage, random) ->
  $localStorage.userUuid ?= random(40)
  $http.defaults.headers.common['X-RS-user_uuid'] = $localStorage.userUuid
