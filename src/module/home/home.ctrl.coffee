angular.module "starter.home"

.controller "HomeCtrl", ($scope) ->

  binaryClient = new BinaryClient 'ws://localhost:9000/binary'

  $scope.videos = []
  currentPercent = 0;
  box = $('.video-container')

  doNothing = (e) ->
    e.preventDefault()
    e.stopPropagation()
    return

  socket = io('http://localhost:9082')

  socket.on 'event', (data) ->
    console.log '@data', data

  socket.on 'end', (data) ->
    console.log '@end', data
    $scope.videos[0].preview = data.thumbnail
    $scope.videos[0].duration = data.duration
    console.log '@@@ thumbnail @@@@', data.thumbnail
    $scope.$apply()

  binaryClient.on 'open', ->


    box.on 'dragenter', doNothing
    box.on 'dragover', doNothing

    box.on 'drop', (e) ->
      e.originalEvent.preventDefault()
      file = e.originalEvent.dataTransfer.files[0]
      # Add to list of uploaded files
      console.log file.name
      $scope.videos.push
        title: file.name
        preview: 0
        percent: 0
        duration: 0
      $scope.$apply()
      # `binaryClient.send` is a helper function that creates a stream with the
      # given metadata, and then chunks up and streams the data.
      stream = binaryClient.send(file,
        name: file.name
        size: file.size)
      # Print progress
      tx = 0
      stream.on 'data', (data) ->
        newPercent = (Math.floor(tx += data.rx * 100))
        if currentPercent < newPercent
          currentPercent = newPercent
          $scope.videos[0].percent = currentPercent
          $scope.$apply()
          console.log currentPercent + '%'
        return
      return
    return
