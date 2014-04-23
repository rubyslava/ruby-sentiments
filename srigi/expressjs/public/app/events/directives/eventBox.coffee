angular.module('rs.events')

.directive 'eventBox', (EventsResource) ->

  return {
    restrict: 'EA'
    templateUrl: 'app/events/directives/eventBox.html'
    replace: true
    scope: {
      event: '='
    }

    link: (scope, el, attrs) ->
      scope.limit = 80


      scope.unlimit = ->
        scope.limit += 4000

      scope.toggleAttend = (event) ->
        event.attending = !event.attending
        EventsResource.toggleAttend(id:event.id).$promise.then ->
          # success cb
          angular.noop()
        , ->
          # error cb
          event.attending = !event.attending

  }
