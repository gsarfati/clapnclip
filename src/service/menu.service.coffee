angular.module "starter"

.service 'menuService',  ($rootScope) ->

  service =

    isOpen: undefined

    toggleMenu: -> @isOpen = if @isOpen is undefined then true else !@isOpen



