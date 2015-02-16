angular.module "starter.home"

.controller "HomeCtrl", ($scope) ->

  socket = io.connect('http://localhost:8081')
  $scope.mystery = 'tutu'
  $scope.filename = undefined
  $scope.file = undefined
  fileReader = new FileReader()
  startUpload = ->
    console.log 'start upload'
    return if $scope.filename is undefined

    filename = $scope.filename

    content = "<span id='NameArea'>Uploading " + $scope.file.name + " as " + filename + "</span>";
    content += '<div id="ProgressContainer"><div id="ProgressBar"></div></div><span id="percent">0%</span>';
    content += "<span id='Uploaded'> - <span id='MB'>0</span>/" + Math.round($scope.file.size / 1048576) + "MB</span>";

    document.getElementById('UploadArea').innerHTML = content
    fileReader.onload = (event) ->
        socket.emit('upload', { 'name' : filename, data : event.target.result });

    socket.emit('start', { 'name' : filename, 'size' : $scope.file.size });
  fileChosen = (event) ->
    console.log 'file chosen'
    $scope.file = event.target.files[0]

  $scope.$watch 'file', (n, m)->
    console.log 'watch : ', n , m

  document.getElementById('UploadButton').addEventListener('click', startUpload);
  document.getElementById('FileBox').addEventListener('change', fileChosen);


  socket.on 'moreData', (data) ->
    console.log 'moreData'
    console.log data
    updateBar data.percent
    place = data.place * 524288
    newFile = $scope.file.slice(place, place + Math.min(524288, ($scope.file.size - place)))
    fileReader.readAsBinaryString(newFile)

  socket.on 'done', (data) ->
    console.log '@@@@@@@ DONE @@@@@@@@'
    console.log data
  updateBar = (percent)->
    document.getElementById('ProgressBar').style.width = percent + '%'
    document.getElementById('percent').innerHTML = (Math.round(percent*100)/100) + '%'
    MBDone = Math.round percent / 100.0 * $scope.file.size / 1048576
    document.getElementById('MB').innerHTML = MBDone
