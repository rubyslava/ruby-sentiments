angular.module('rs.events', [])

.config ($routeProvider) ->
  $routeProvider.when('/', {
    controller: 'Events.IndexController'
    templateUrl: 'app/events/views/index.html'
  })
