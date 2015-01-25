angular.module "starter.home", []

.config ($stateProvider) ->

  $stateProvider

  .state 'layout.home',
      url: '/home',
      views:
      	'menu':
	        templateUrl: 'templates/menu.view.html'
	        controller: 'MenuCtrl'
        'main':
          templateUrl: 'templates/home.view.html',
          controller: 'HomeCtrl'
  return
