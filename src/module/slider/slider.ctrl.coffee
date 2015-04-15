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


  console.log 'WINDOW : ', window.location.host
  binaryClient = new BinaryClient "ws://#{window.location.host}:9000/binary"

  socket = io()
  box = $('#dropBox')
  currentPercent = 0;
  fileStack = []
  stack = -1
  uploadIsRunning = false

  $scope.videos = []

  $scope.deleteVideo = (index) ->
    $scope.videos.splice index, 1

  createNewVideo = (file) ->
    $scope.videos.push
      title: file.name
      percent: 0
      duration: 0
      preview: false
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
    console.log 'data : ', data
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
