angular.module "starter.home", []

.config ($stateProvider) ->

  $stateProvider

  .state 'layout.home',
      url: '/home',
      views:
        'main':
          templateUrl: 'templates/home.view.html',
          controller: 'HomeCtrl'
  return
