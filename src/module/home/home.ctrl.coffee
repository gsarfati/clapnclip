angular.module "starter.home"

.controller "HomeCtrl", ($scope) ->

  binaryClient = new BinaryClient 'ws://localhost:9000'

  socket = io('/api')
  box = $('.video-container')
  currentPercent = 0;
  fileStack = []
  stack = -1
  uploadIsRunning = false

  $scope.videos = []

  createNewVideo = (file) ->
    $scope.videos.push
      title: file.name
      percent: 0
      duration: 0
    $scope.$apply()

  doNothing = (e) ->
    e.preventDefault()
    e.stopPropagation()
    return

  sendFile = (file) ->
    binaryClient.send(file,
      name: file.name
      size: file.size)


  socket.on 'end', (data) ->

    $scope.videos[stack].preview = data.thumbnail
    $scope.videos[stack].duration = data.duration
    $scope.$apply()

    uploadIsRunning = false

    if fileStack[stack + 1] and !uploadIsRunning
      uploadIsRunning = true
      stream = sendFile fileStack[stack + 1]
      stack++

      tx = 0
      currentPercent = 0
      stream.on 'data', (data) ->
        newPercent = (Math.floor(tx += data.rx * 100))
        if currentPercent < newPercent
          currentPercent = newPercent
          $scope.videos[stack].percent = currentPercent
          $scope.$apply()
          console.log currentPercent + '%'
        return

  binaryClient.on 'open', ->

    box.on 'dragenter', doNothing
    box.on 'dragover', doNothing

    box.on 'drop', (e) ->
      e.originalEvent.preventDefault()

      for fileUpload in e.originalEvent.dataTransfer.files
        fileStack.push fileUpload
        createNewVideo fileUpload

      unless uploadIsRunning
        uploadIsRunning = true
        stream = sendFile fileStack[stack + 1]
        stack++

        tx = 0
        currentPercent = 0;
        stream.on 'data', (data) ->
          newPercent = (Math.floor(tx += data.rx * 100))
          if currentPercent < newPercent
            currentPercent = newPercent
            $scope.videos[stack].percent = currentPercent
            $scope.$apply()
            console.log currentPercent + '%'
          return
        return

    return
