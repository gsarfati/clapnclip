angular.module "starter.home"

.controller "HomeCtrl", ($scope) ->
  
  Suscriber = Parse.Object.extend "Suscriber"

  suscriber = new Suscriber()

  $scope.submit = (value) ->
    console.log 'submit : ', value
    suscriber.save({email: value})
    .then (object) ->
      console.log object