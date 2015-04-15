angular.module "starter", [
  "ui.router"
  "ngCordova"
  "ngAnimate"
  "ngStorage"
  "ngResource"

  "starter.translate"

  "starter.menu"
  "starter.banner"
  "starter.uploader"
  "starter.slider"
  "starter.footer"
]

.config ($urlRouterProvider, $stateProvider) ->

  $urlRouterProvider.otherwise '/'

  $stateProvider

  .state 'layout',
    url: '/'
    views:
      'menu':
        templateUrl: 'menu.view.html'
        controller: 'menuCtrl'
      'banner':
        templateUrl: 'banner.view.html'
        controller: 'bannerCtrl'
      'uploader':
        templateUrl: 'uploader.view.html'
        controller: 'uploaderCtrl'
      'slider':
        templateUrl: 'slider.view.html'
        controller: 'sliderCtrl'
      'footer':
        templateUrl: 'footer.view.html'
        controller: 'footerCtrl'


  # Parse.initialize(
  #   "aRjKHd0n73VWhZdWH3qRtXUWQX4EMaOWJI1WscOD"
  #   "ibPD3bF0bhxOlIMisDNu0irteJK3NnREiCN1t372"
  # )

.run ($rootScope, menuService) ->

  $rootScope.menuIsOpen = undefined

  $rootScope.toggleMenu = ->
    if $rootScope.menuIsOpen is undefined
      $rootScope.menuIsOpen = true
    else
      $rootScope.menuIsOpen = !$rootScope.menuIsOpen


