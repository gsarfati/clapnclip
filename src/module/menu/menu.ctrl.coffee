angular.module "starter.menu"

.controller "menuCtrl", ($rootScope, $scope, $document) ->

  $scope.height = window.innerHeight / 3

  console.log "HEIGH : ",  window.innerHeight / 3

  $scope.blocks = [
    { name: 'Inscription', target: 'id-notre-expertise', background: 'rgb(115,146,173)', picto: 'img/expertise.png'}
    { name: 'Connexion', target: 'accelerator', background: 'rgb(163,64,72)', picto: 'img/accelerateur.png'}
    { name: 'Profile', target: 'id-portfolio', background: 'rgb(157,161,179)', picto: 'img/portfolio.png'}
    { name: 'CLaPer', target: 'id-ecosysteme', background: 'rgb(41,81,102)', picto: 'img/ecosysteme.png'}
    { name: 'CLiPer', target: 'id-notre-team', background: 'rgb(93,64,91)', picto: 'img/team.png'}
    { name: 'Blog', target: 'footer', background: 'rgb(17,156,175)', picto: 'img/contact.png'}
  ]

  $scope.scrollTo = (target) ->
    $document.scrollToElement angular.element(document.getElementById(target)), 0, 1000
    $rootScope.toggleMenu()
