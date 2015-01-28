angular.module "starter", [
  "ui.router"
  "ngCordova"
  "ngAnimate"
  "ngStorage"
  "ngResource"

  "starter.translate"
  "starter.layout"
  "starter.home"
]

.config ->
    
    Parse.initialize(
      "aRjKHd0n73VWhZdWH3qRtXUWQX4EMaOWJI1WscOD"
      "ibPD3bF0bhxOlIMisDNu0irteJK3NnREiCN1t372"
    )

.run ($rootScope, menuService) ->

  $rootScope.menu = menuService
  $rootScope.user =
    email: ''
    ip: ''
    lang: ''
