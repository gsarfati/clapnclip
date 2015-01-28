angular.module "starter"

.service 'ParseSDK', ($http, $rootScope, $state) ->

  service =

    login: ->

      Parse.FacebookUtils.logIn 'email,user_friends,read_friendlists',
          success: (user) ->
            unless user.existed()
              console.log "User signed up and logged in through Facebook!"
            else
              console.log "User logged in through Facebook!"

            $rootScope.$broadcast 'fb:user:logged'
            $state.go 'layout.friends'
            return

          error: (user, error) ->
            console.log "User cancelled the Facebook login or did not fully authorize."
            console.log error
            return
        return

    friends: ->

      FB.api '/me/invitable_friends', (friends) ->
        $rootScope.$broadcast 'user:friends', friends
        console.log 'friends function'
        return friends

    me: ->

      FB.api '/me', (me) ->
        $rootScope.$broadcast 'user:me', me
        console.log me
        return me


