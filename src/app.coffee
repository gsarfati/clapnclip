angular.module "starter", [
  "ionic"

  "ngCordova"
  "ngAnimate"
  "ngStorage"
  "ngResource"

  "starter.translate"
  "starter.layout"
  "starter.menu"
  "starter.home"
]

.run ($ionicPlatform, $rootScope, menuService) ->

  $ionicPlatform.ready ->
    cordova.plugins.Keyboard.hideKeyboardAccessoryBar true  if window.cordova and window.cordova.plugins.Keyboard
    StatusBar.styleDefault() if window.StatusBar
    return

  $rootScope.menu = menuService
