angular.module('rs.events')

.controller 'Events.IndexController', ($scope, EventsResource) ->
  $scope.events = EventsResource.query()
