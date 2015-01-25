angular.module "starter.layout", []

.config ($urlRouterProvider, $stateProvider) ->

  $stateProvider

  .state 'layout',
    abstract: true,
    templateUrl: 'templates/layout.view.html'

  $urlRouterProvider.otherwise "home"
  return
