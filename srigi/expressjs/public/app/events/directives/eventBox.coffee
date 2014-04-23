angular.module('rs.events')

.directive 'eventBox', () ->

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

  }
