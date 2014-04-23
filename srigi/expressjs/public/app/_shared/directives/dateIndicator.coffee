angular.module('rs.shared')

.directive 'dateIndicator', ($filter) ->

  return {
    restrict: 'EA'
    templateUrl: 'app/_shared/directives/dateIndicator.html'
    scope: {
      date: '='
    }

    link: (scope, el, attrs) ->
      date = new Date(scope.date)

      scope.month = $filter('date')(date, 'MMM')
      scope.day = date.getDate()

  }
