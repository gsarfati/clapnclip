angular.module "starter.slider"

.controller "sliderCtrl", ($scope) ->

  $scope.user =
    mailCliper: undefined
    mailClaper: undefined

  $scope.step = 1

#--------------------------------------> Arrow

  $scope.nextChevronIsVisible = false
  $scope.prevChevronIsVisible = false

  $scope.$watch 'step',  (value) ->
    console.log 'watch : ', value
    $scope.nextChevronIsVisible = if value in [1..10] then false else true
    $scope.prevChevronIsVisible = if value in [1] then false else true

    console.log '$scope.nextChevronIsVisible : ', $scope.nextChevronIsVisible

#-------------------------------------->
  $scope.goToStep = (step) ->
    $scope.step = step

  $scope.nextStep = ->
    console.log 'nextStep'
    $scope.step += 1

  $scope.prevStep = ->
    console.log 'prevStep : ', $scope.step
    if $scope.step is 10
      $scope.step = 1
    else
      $scope.step -= 1

#--------------------------------------> Video Uploader

